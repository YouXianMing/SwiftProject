//
//  PlaceholderImageView.swift
//  BasePlaceholderViewConfig
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

/// 占位图控件的抽象配置类
open class BasePlaceholderViewConfig {
    
    /// [子类重写] 开始调整view(调用PlaceholderImageView的config的setter方法时会触发该方法)
    open func placeholderViewStartAdjust(_ placeholderView : UIView) {}
    
    /// [子类重写] placeholder的superView已经执行完了DidLayoutSubviews,你可以在这个时候进行一些调整,当然你也可以啥也不干)
    open func superviewDidLayoutSubviews(_ placeholderView : UIView) {}
    
    public init() {}
}

/// 占位图控件的抽象类
open class PlaceholderImageView: UIView {
    
    // MARK: 子类重写
    
    /// [子类重写] 图片地址,子类需要重写其setter,getter方法
    open var urlString : String?
    
    /// [子类重写] 占位图控件
    open var placeholderView : UIView { get { return UIView()}}
    
    // MARK: 公开属性
    
    /// 图片加载完之后占位图是否需要隐藏,默认为true
    open var placeholderImageNeedHide = true
    
    /// 配置文件
    open var config : BasePlaceholderViewConfig? {
        
        get { return configValue}
        set(newVal) {
            
            configValue = newVal
            configValue?.placeholderViewStartAdjust(placeholderView)
        }
    }
    
    // MARK: 私有属性
    
    fileprivate var configValue : BasePlaceholderViewConfig?
    
    // MARK: 提供便利的构造器
    
    public convenience init(frame                    : CGRect = CGRect.zero,
                            config                   : BasePlaceholderViewConfig? = nil,
                            placeholderImageNeedHide : Bool = true) {
        
        self.init(frame: frame)
        self.config                   = config
        self.placeholderImageNeedHide = true
    }
    
    // MARK: 系统方法
    
    public override init(frame: CGRect) { super.init(frame: frame)}
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
}
