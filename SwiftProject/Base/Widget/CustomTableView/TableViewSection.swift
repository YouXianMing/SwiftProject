//
//  TableViewSection.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class TableViewSection: NSObject {

    // MARK: 属性
    
    /// 标记
    var mark : String?
    
    /// headerView的数据
    var header : TableViewHeaderFooterViewAdapter?
    
    /// cell数据的数组
    var adapters : [TableViewCellAdapter] = []
    
    /// footerView的数据
    var footer : TableViewHeaderFooterViewAdapter?
}
