//
//  IGListCellInfo.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit
import IGListKit

class IGListCellInfo: NSObject {
    
    /// cell的class
    var cellClass : AnyClass
    
    /// cell的尺寸
    var size : CGSize
    
    /// cell的数据
    var data : Any?
    
    /// cell的重用标识
    var reuseIdentifier : String?
    
    required init(cellClass       : AnyClass,
                  size            : CGSize,
                  data            : Any?    = nil,
                  reuseIdentifier : String? = nil) {
        
        self.size            = size
        self.cellClass       = cellClass
        self.data            = data
        self.reuseIdentifier = reuseIdentifier
        
        super.init()
    }
}

