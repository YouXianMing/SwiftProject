//
//  BaseNavigationController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    convenience public init(rootViewController: BaseViewController, hideNavBar : Bool) {
        
        self.init(rootViewController : rootViewController)
        rootViewController.useInteractivePopGestureRecognizer()
        setNavigationBarHidden(hideNavBar, animated: false)
    }
    
    // MARK: -- System method && Debug message --
    
    deinit { print("[❌] '[NAV] " + String(describing: self.classForCoder) + "' is released.")}
    
    open override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        print("[➡️] enter to --> '[NAV] " + String(describing: self.classForCoder) + "'.")
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        print("[🕒] leave from <-- '[NAV] " + String(describing: self.classForCoder) + "'.")
    }
}
