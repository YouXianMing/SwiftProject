//
//  CollectionViewCellAdapter.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

open class CollectionViewCellAdapter: NSObject {
    
    // MARK: 属性
    
    /// cell的重用标识
    open var reuseIdentifier : String?
    
    /// cell的数据,可以为空
    open var data : Any?
    
    /// cell的尺寸(如果尺寸为zero,并且UICollectionViewFlowLayout的estimatedItemSize设置为UICollectionViewFlowLayout.automaticSize时
    /// 则会使用自动布局的方式扩展cell)
    open var size : CGSize = CGSize.zero
    
    /// 额外的数据(根据自己的需求设定)
    open var info : Any?
    
    // MARK: 便利构造方法
    
    public convenience init(reuseIdentifier : String? = nil,
                            data            : Any?    = nil,
                            size            : CGSize  = CGSize.zero,
                            info            : Any?    = nil) {
        
        self.init()
        self.reuseIdentifier = reuseIdentifier
        self.data            = data
        self.size            = size
        self.info            = info
    }
}
