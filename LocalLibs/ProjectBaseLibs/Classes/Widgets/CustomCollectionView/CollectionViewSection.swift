//
//  CollectionViewSection.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

open class CollectionViewSection: NSObject {

    // MARK: 属性
    
    /// 标记
    open var mark : String?
    
    /// section的inset
    open var inset : UIEdgeInsets = UIEdgeInsets.zero
    
    /// 元素换行时的间距
    open var minimumLineSpacing : CGFloat = 0
    
    /// 元素排列时的间距
    open var minimumInteritemSpacing : CGFloat = 0
    
    /// header的数据
    open var header : CollectionReusableViewAdapter?
    
    /// cell数组的数据
    open var adapters : [CollectionViewCellAdapter] = []
    
    /// footer的数据
    open var footer : CollectionReusableViewAdapter?
}
