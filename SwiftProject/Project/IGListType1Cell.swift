//
//  IGListType1Cell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit
import ProjectBaseLibs

class IGListType1Cell: BaseIGListCell {
    
    override class func sizeWithData(_ data: Any? = nil) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    override func setupCell() {
        
        contentView.backgroundColor = .red
    }
    
    override func loadContent() {
        
        appPrint(cellInfo?.data ?? "")
    }
}
