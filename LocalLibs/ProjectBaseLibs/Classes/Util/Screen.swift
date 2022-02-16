//
//  Screen.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/29.
//

import UIKit

open class Screen {
    
    /// 是不是刘海屏
    public static let isFringe = Screen.getFringe()
    
    /// 屏幕宽度(实时获取)
    public static var width : CGFloat { get { return UIScreen.main.bounds.size.width}}
    
    /// 屏幕高度(实时获取)
    public static var height : CGFloat { get { return UIScreen.main.bounds.size.height}}
    
    /// 状态栏高度(实时获取)
    public static var statusBarHeight : CGFloat { get { return UIApplication.shared.statusBarFrame.height}}
    
    /// 导航栏高度
    public static let navigationBarHeight : CGFloat = 44

    /// Tabbar高度
    public static let tabbarHeight : CGFloat = 49
    
    // MARK: - 私有方法
    
    /// 获取是不是刘海屏，只执行一次
    private static func getFringe() -> Bool {
        
        if #available(iOS 11.0, *) {
            
            return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 > 0
            
        } else {
            
            return false
        }
    }
}
