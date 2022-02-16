//
//  CollectionViewAutolayoutCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit
import ProjectBaseLibs

class CollectionViewAutolayoutCell: BaseCollectionViewCell {
    
    fileprivate lazy var label : UILabel = {
        
        let label = UILabel()
        return label
    }()
    
    override func buildSubviews() {
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            
            make.left.right.top.bottom.equalToSuperview().inset(20)
        }
        
        contentView.debug_showOutlineWithColor()
    }
    
    override func loadContent() {
        
        label.text = "测试"
    }
}
