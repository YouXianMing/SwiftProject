//
//  UIView+Debug.swift
//  Debug use.
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

extension UIView {
    
    // MARK: debug用方法
    
    /// 显示当前view的外边框(细)，可以在断点处使用
    func debug_showOutlineWithColor(_ color         : UIColor  = .red,
                                    width           : CGFloat  = 2,
                                    backgroundColor : UIColor? = nil) {
        
        showOutline(outlineColor: color, width: width, backgroundColor: backgroundColor)
    }
    
    /// 显示当前view的外边框(粗)，可以在断点处使用
    func debug_showBoldOutlineWithColor(_ color         : UIColor  = .red,
                                        width           : CGFloat  = 5,
                                        backgroundColor : UIColor? = nil) {
        
        showOutline(outlineColor: color, width: width, backgroundColor: backgroundColor)
    }
    
    // MARK: 私有方法
    
    fileprivate func showOutline(outlineColor    : UIColor  = .red,
                                 width           : CGFloat  = 2,
                                 backgroundColor : UIColor? = nil) {
#if DEBUG
        layer.borderWidth = width
        layer.borderColor = outlineColor.cgColor
        if let color = backgroundColor {
            
            self.backgroundColor = color
        }
#endif
    }
}
