//
//  CollectionViewSection.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class CollectionViewSection: NSObject {

    // MARK: 属性
    
    /// 标记
    var mark : String?
    
    /// section的inset
    var inset : UIEdgeInsets = UIEdgeInsets.zero
    
    /// 元素换行时的间距
    var minimumLineSpacing : CGFloat = 0
    
    /// 元素排列时的间距
    var minimumInteritemSpacing : CGFloat = 0
    
    /// header的数据
    var header : CollectionReusableViewAdapter?
    
    /// cell数组的数据
    var adapters : [CollectionViewCellAdapter] = []
    
    /// footer的数据
    var footer : CollectionReusableViewAdapter?
}
