//
//  TableViewCellAdapter.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

class TableViewCellAdapter: NSObject {

    // MARK: 属性
    
    /// cell的重用标识
    var reuseIdentifier : String?
    
    /// cell的数据,可以为空
    var data : Any?
    
    /// cell的高度(默认值为自动适配类型)
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
