//
//  TableViewHeaderFooterViewAdapter.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class TableViewHeaderFooterViewAdapter: NSObject {

    // MARK: 属性
    
    /// HeaderFooter的重用标识
    var reuseIdentifier : String?
    
    /// HeaderFooterView的数据,可以为空
    var data : Any?
    
    /// HeaderFooterView的高度(默认值为自动适配类型)
    var height : CGFloat = UITableView.automaticDimension
    
    /// 额外的数据(根据自己的需求设定)
    var info : Any?
    
    // MARK: 便利构造方法
    
    convenience init(reuseIdentifier : String? = nil,
                     data            : Any?    = nil,
                     height          : CGFloat = UITableView.automaticDimension,
                     info            : Any?    = nil) {
        
        self.init()
        self.reuseIdentifier = reuseIdentifier
        self.data            = data
        self.height          = height
        self.info            = info
    }
}
