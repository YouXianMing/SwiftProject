//
//  UIView+ManualLayout.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit

extension UIView {
    
    /// viewOrigin
    var ml_viewOrigin : CGPoint {
        
        get { return frame.origin}
        set(newVal) {
            
            var tmpFrame    = frame
            tmpFrame.origin = newVal
            frame           = tmpFrame
        }
    }
    
    /// viewSize
    var ml_viewSize : CGSize {
        
        get{ return frame.size}
        set(newVal) {
            
            var tmpFrame  = frame
            tmpFrame.size = newVal
            frame         = tmpFrame
        }
    }
    
    /// x
    var ml_x : CGFloat {
        
        get { return frame.origin.x}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// y
    var ml_y : CGFloat {
        
        get { return frame.origin.y}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame             = tmpFrame
        }
    }
    
    /// height
    var ml_height : CGFloat {
        
        get { return frame.size.height}
        set(newVal) {
            
            var tmpFrame         = frame
            tmpFrame.size.height = newVal
            frame                = tmpFrame
        }
    }
    
    /// width
    var ml_width : CGFloat {
        
        get { return frame.size.width}
        set(newVal) {
            
            var tmpFrame        = frame
            tmpFrame.size.width = newVal
            frame               = tmpFrame
        }
    }
    
    /// left
    var ml_left : CGFloat {
        
        get { return frame.origin.x}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal
            frame             = tmpFrame
        }
    }
    
    /// right
    var ml_right : CGFloat {
        
        get { return frame.origin.x + frame.size.width}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.x = newVal - frame.size.width
            frame             = tmpFrame
        }
    }
    
    /// top
    var ml_top : CGFloat {
        
        get { return frame.origin.y}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal
            frame = tmpFrame
        }
    }
    
    /// bottom
    var ml_bottom : CGFloat {
        
        get { return frame.origin.y + frame.size.height}
        set(newVal) {
            
            var tmpFrame      = frame
            tmpFrame.origin.y = newVal - frame.size.height
            frame             = tmpFrame
        }
    }
    
    /// centerX
    var ml_centerX : CGFloat {
        
        get { return center.x}
        set(newVal) { center = CGPoint(x: newVal, y: center.y)}
    }
    
    /// centerY
    var ml_centerY : CGFloat {
        
        get { return center.y}
        set(newVal) { center = CGPoint(x: center.x, y: newVal)}
    }
    
    /// middleX
    var ml_middleX : CGFloat {
        
        get { return bounds.width / 2}
    }
    
    /// middleY
    var ml_middleY : CGFloat {
        
        get { return bounds.height / 2}
    }
    
    /// middlePoint
    var ml_middlePoint : CGPoint {
        
        get { return CGPoint(x: bounds.width / 2, y: bounds.height / 2)}
    }
}

