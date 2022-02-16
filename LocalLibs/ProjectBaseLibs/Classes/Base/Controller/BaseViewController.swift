//
//  BaseViewController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/29.
//

import UIKit

open class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /// 是否是NavigationController的根控制器,如果子类重写了此方法并返回了true,interactivePopGestureRecognizerEnable会在
    /// viewDidAppear中设置为false,在viewDidDisappear中设置为true
    open class func isNavigationControllerRootController() -> Bool { return false}
    
    /// 是否开启侧滑手势，设置为true则为开启，设置为false则为关闭，如果当前控制器被设置为navigationController的根控制器，
    /// 则需要将interactivePopGestureRecognizerEnable设置为false，否则会出现bug
    open var interactivePopGestureRecognizerEnable : Bool? {
        
        get { return (self.navigationController?.interactivePopGestureRecognizer?.isEnabled)}
        set(newVal) { self.navigationController?.interactivePopGestureRecognizer?.isEnabled = newVal!}
    }
    
    /// 只有在当前控制器被设置为navigationController的根控制器时才需要调用此方法
    open func useInteractivePopGestureRecognizer() {
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// 返回到上一级控制器
    open func popViewController(animated: Bool = true) {
        
        navigationController?.popViewController(animated: animated)
    }
    
    /// 返回到根控制器
    open func popToRootViewController(animated : Bool = true) {
        
        navigationController?.popToRootViewController(animated: animated)
    }
    
    // MARK: -- System method && Debug message --
    
    deinit { print("[❌] '" + String(describing: self.classForCoder) + "' is released.")}
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        if (Self.isNavigationControllerRootController()) { interactivePopGestureRecognizerEnable = false}
        print("[➡️] enter to --> '" + String(describing: self.classForCoder) + "'.")
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        if (Self.isNavigationControllerRootController()) { interactivePopGestureRecognizerEnable = true}
        print("[🕒] leave from <-- '" + String(describing: self.classForCoder) + "'.")
    }
}
