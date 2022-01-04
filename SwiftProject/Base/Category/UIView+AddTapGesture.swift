//
//  UIView+AddTapGesture.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/4.
//

import UIKit

typealias UIViewGestureEventBlock = (_: UIGestureRecognizer) -> Void
typealias UIViewGestureConfigBlock = (_: UIGestureRecognizer) -> Void

private var tapGestureEventBlockKey: String = "tapGestureEventBlockKey"

extension UIView {

    // MARK: 属性
    
    /// tap手势事件的block
    var tapGestureEventBlock: UIViewGestureEventBlock? {
        
        get { return (objc_getAssociatedObject(self, &tapGestureEventBlockKey) as? UIViewGestureEventBlock)}
        set(newVal) { objc_setAssociatedObject(self, &tapGestureEventBlockKey, newVal, .OBJC_ASSOCIATION_COPY)}
    }
    
    // MARK: 公开方法
    
    /// 给当前view添加tap手势事件的block
    /// - Parameters:
    ///   - block: tap手势的block
    ///   - config: tap手势的配置,可以为空
    func addTapGestureWithEventBlock(_ block : @escaping UIViewGestureEventBlock,
                                     config : UIViewGestureConfigBlock? = nil) {
     
        // 开启交互
        isUserInteractionEnabled = true
        
        // 添加手势
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(uiviewRuntimeTapGestureEvent(gesture:)))
        
        // 如果需要配置,则可以对手势进行配置
        if let config = config { config(tapGesture)}
        
        // 添加手势
        addGestureRecognizer(tapGesture)
        
        // 设置tapGestureEventBlock
        tapGestureEventBlock = block
    }
    
    /// 清除tap手势事件的block
    func removetapGestureEventBlock() {
        
        tapGestureEventBlock = nil
    }
    
    // MARK: 私有方法
    
    @objc private func uiviewRuntimeTapGestureEvent(gesture : UITapGestureRecognizer) {
        
        if let block = tapGestureEventBlock { block(gesture)}
    }
}
