//
//  CollectionReusableViewAdapter.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class CollectionReusableViewAdapter: NSObject {

    /// cell的重用标识
    var reuseIdentifier : String?
    
    /// HeaderFooterView的数据,可以为空
    var data : Any?
    
    /// 额外的数据(根据自己的需求设定)
    var info : Any?
    
    /// 尺寸
    var referenceSize : CGSize = CGSize.zero
    
    /// ReusableView的类型
    var elementKind : String?
    
    // MARK: 便利构造方法
    
    convenience init(reuseIdentifier : String? = nil,
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
