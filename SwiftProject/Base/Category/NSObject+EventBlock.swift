//
//  NSObject+EventBlock.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/4.
//

import UIKit

typealias NSObjectEventBlock = (_: Any?, _: Any?) -> Void

private var objectEventBlockKey: String = "objectEventBlockKey"

extension NSObject {

    /// 给NSObject对象添加事件block回调的属性
    var objectEventBlock: NSObjectEventBlock? {
        
        get { return (objc_getAssociatedObject(self, &objectEventBlockKey) as? NSObjectEventBlock)}
        set(newVal) { objc_setAssociatedObject(self, &objectEventBlockKey, newVal, .OBJC_ASSOCIATION_COPY)}
    }
    
    /// 给当前的object对象添加事件回调的block
    /// - Parameter block: block对象
    func addObjectEventBlock(_ block: @escaping NSObjectEventBlock) {
        
        objectEventBlock = block
    }
    
    /// 移除当前对象的block回调属性
    func removeObjectEventBlock() {
        
        objectEventBlock = nil
    }
}
