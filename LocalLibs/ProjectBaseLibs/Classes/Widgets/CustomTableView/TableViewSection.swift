//
//  TableViewSection.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

open class TableViewSection: NSObject {
    
    // MARK: 属性
    
    /// 标记
    open var mark : String?
    
    /// headerView的数据
    open var header : TableViewHeaderFooterViewAdapter?
    
    /// cell数据的数组
    open var adapters : [TableViewCellAdapter] = []
    
    /// footerView的数据
    open var footer : TableViewHeaderFooterViewAdapter?
}
