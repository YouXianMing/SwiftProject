//
//  CollectionReusableViewAdapter.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

open class CollectionReusableViewAdapter: NSObject {
    
    // MARK: 属性
    
    /// cell的重用标识
    open var reuseIdentifier : String?
    
    /// HeaderFooterView的数据,可以为空
    open var data : Any?
    
    /// 额外的数据(根据自己的需求设定)
    open var info : Any?
    
    /// 尺寸
    open var referenceSize : CGSize = CGSize.zero
    
    /// ReusableView的类型
    open var elementKind : String?
    
    // MARK: 便利构造方法
    
    public convenience init(reuseIdentifier : String? = nil,
                            elementKind     : String,
                            data            : Any?    = nil,
                            referenceSize   : CGSize  = CGSize.zero,
                            info            : Any?    = nil) {
        
        self.init()
        self.elementKind     = elementKind
        self.reuseIdentifier = reuseIdentifier
        self.data            = data
        self.referenceSize   = referenceSize
        self.info            = info
    }
}
