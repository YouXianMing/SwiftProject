//
//  LayoutBaseViewController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/29.
//

import UIKit

class LayoutBaseViewController: BaseViewController {
    
    /// backgroundView
    lazy var backgroundView : UIView = { return UIView()}()
    
    /// contentView
    lazy var contentView : UIView = { return UIView()}()
    
    /// titleView
    lazy var titleView : UIView = { return UIView()}()
    
    /// [子类根据需要重写] baseViews是否使用自动布局，默认为true，如果返回false，则表示手动布局
    class func baseViewsUseAutoLayout() -> Bool { return true}
     
    /// pop事件,提供给子类的按钮调用
    @objc func popEvent() { popViewController()}
    
    /// [子类根据需要重写] 构建基础BaseViews
    func buildBaseViews() {
    
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        view.addSubview(titleView)
        
        /// 状态栏+导航栏的高度
        let titleViewHeight = Screen.statusBarHeight + Screen.navigationBarHeight
        
        if (Self.baseViewsUseAutoLayout()) {
            
            do {
                
                backgroundView.translatesAutoresizingMaskIntoConstraints = false
                let leftConstraint   = backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor)
                let rightConstraint  = backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor)
                let topConstraint    = backgroundView.topAnchor.constraint(equalTo: view.topAnchor)
                let bottomConstraint = backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
            }
            
            do {
                
                contentView.translatesAutoresizingMaskIntoConstraints = false
                let leftConstraint   = contentView.leftAnchor.constraint(equalTo: view.leftAnchor)
                let rightConstraint  = contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
                let topConstraint    = contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: titleViewHeight)
                let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
            }
            
            do {
                
                titleView.translatesAutoresizingMaskIntoConstraints = false
                let leftConstraint   = titleView.leftAnchor.constraint(equalTo: view.leftAnchor)
                let rightConstraint  = titleView.rightAnchor.constraint(equalTo: view.rightAnchor)
                let topConstraint    = titleView.topAnchor.constraint(equalTo: view.topAnchor)
                let heightConstraint = titleView.heightAnchor.constraint(equalToConstant: titleViewHeight)
                view.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])
            }
            
        } else {
            
            backgroundView.frame = view.bounds
            contentView.frame    = CGRect(x: 0, y: titleViewHeight, width: Screen.width, height: Screen.height - titleViewHeight)
            titleView.frame      = CGRect(x: 0, y: 0, width: Screen.width, height: titleViewHeight)
        }
    }
    
    func setup() {}
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buildBaseViews()
        setup()
    }
}

