//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/4.
//

import UIKit
import SnapKit
import ProjectBaseLibs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        if let window = window {
                        
            window.backgroundColor    = .white
            window.rootViewController = BaseNavigationController(rootViewController: MenuController(), hideNavBar: true)
            window.makeKeyAndVisible()
        }
        
        return true
    }
}



