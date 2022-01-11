//
//  BaseSheetInfoView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit

enum SheetInfoViewAnimationType {
    
    case fromBottomToTop
    case fromTopToBottom
    case fromLeftToRight
    case fromRightToLeft
}

class SheetInfoView: UIView {
    
    // MARK: 属性
    
    /// 设置contentView
    var contentView : UIView? {
        
        set(newVal) {
            
            fatherView = newVal
            if let view = fatherView {
                
                frame = view.bounds
                view.addSubview(self)
                
            } else {
                
                if (self.superview != nil) { self.removeFromSuperview()}
            }
        }
        
        get { return fatherView}
    }
    
    /// view构造器
    var viewBuilder : SheetInfoContentViewBuilder = SheetInfoContentViewBuilder()
    
    /// 动画类型
    var animationType : SheetInfoViewAnimationType = .fromBottomToTop
    
    /// 是否可以通过点击背景进行hide,默认为true
    var canTapBackgroundToHide : Bool = true
    
    /// 背景view的颜色
    var backgroundViewColor : UIColor = .black.withAlphaComponent(0.5)
    
    // MARK: 私有属性
    
    /// contentView的持有者
    private weak var fatherView : UIView?
    
    /// 背景view
    private lazy var backgroundView : UIView = {
        
        let view             = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// 做动画用的view
    private lazy var animationView : UIView = {
        
        return UIView()
    }()
    
    // MARK: 方法
    
    func buildSubviews(with data: Any? = nil) {
        
        // 添加背景view
        backgroundView.frame = bounds
        addSubview(backgroundView)
        
        // 背景view添加手势
        let tapGesture = UITapGestureRecognizer.init(target: self,
                                                     action: #selector(backgroundTapEvent))
        backgroundView.addGestureRecognizer(tapGesture)
        
        // 添加做动画用的view,后续尺寸调整由SheetInfoContentViewBuilder进行处理
        animationView.frame = bounds
        addSubview(animationView)
        
        // 设置添加进来的view
        viewBuilder.layoutBounds  = bounds
        viewBuilder.animationView = animationView
        viewBuilder.data          = data
        viewBuilder.sheetInfoView = self
        let viewBuilderView = viewBuilder.builderSubview()
        animationView.addSubview(viewBuilderView)
        viewBuilder.adjustLayout(view: viewBuilderView)
    }
    
    func show() {
        
        animationView.ml_top = self.ml_height
        backgroundView.backgroundColor = .clear
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            
            self.animationView.ml_bottom        = self.ml_height
            self.backgroundView.backgroundColor = self.backgroundViewColor
            
        } completion: { _ in}
    }
    
    // MARK: 私有方法
    
    @objc fileprivate func backgroundTapEvent() {
        
        if (canTapBackgroundToHide) { hideAnimation()}
    }
    
    fileprivate func hideAnimation() {
        
        UIView.animate(withDuration: 0.45, delay: 0) {
            
            self.animationView.ml_top           = self.ml_height
            self.backgroundView.backgroundColor = .clear
            
        } completion: { _ in
            
            self.removeFromSuperview()
        }
    }
    
    // MARK: 系统方法
    
    deinit {
        
        print("[❌] '" + String(describing: self.classForCoder) + "' is released.")
    }
}

class SheetInfoContentViewBuilder: NSObject {
    
    /// SheetInfoView调用buildSubviews时携带的参数
    var data : Any?
    
    /// contentView可用的最大的尺寸
    var contentBounds : CGRect { get { return layoutBounds!}}
    
    /// BaseSheetInfoView中的animationView
    var contentView : UIView { get { return animationView!}}
    
    fileprivate var      layoutBounds  : CGRect?
    fileprivate weak var animationView : UIView?
    fileprivate weak var sheetInfoView : SheetInfoView?
    
    // 通过调用此方法来进行hide操作
    func hide() { sheetInfoView?.hideAnimation()}
    
    // [子类重写]
    func builderSubview() -> UIView { return UIView()}
    
    // [子类重写]
    func adjustLayout(view: UIView) {}
}
