//
//  TableViewHeaderFooterViewAdapter.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

open class TableViewHeaderFooterViewAdapter: NSObject {
    
    // MARK: 属性
    
    /// HeaderFooter的重用标识
    open var reuseIdentifier : String?
    
    /// HeaderFooterView的数据,可以为空
    open var data : Any?
    
    /// HeaderFooterView的高度(默认值为自动适配类型)
    open var height : CGFloat = UITableView.automaticDimension
    
    /// 额外的数据(根据自己的需求设定)
    open var info : Any?
    
    // MARK: 便利构造方法
    
    public convenience init(reuseIdentifier : String? = nil,
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
