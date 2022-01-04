//
//  GoodsItemCell.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit

class GoodsItemCell: BaseCollectionViewCell {
    
    fileprivate lazy var iconImageView : PlaceholderImageView = {
        
        let view         = PlaceholderImageView.labelType()
        view.frame       = bounds
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override class func sizeWithData(_ data: Any? = nil) -> CGSize {
        
        let width  = (Screen.width - 10 * 3) / 2 - 1
        let height = width * 1.2
        
        return CGSize(width: width, height: height)
    }
    
    override func buildSubviews() {
        
        contentView.addSubview(iconImageView)
        
        // 添加点击事件
        iconImageView.addTapGestureWithEventBlock { [weak self] _ in
            
            self?.cellCallDelegateEvent(self, data: "数据")
        }
    }
    
    override func loadContent() {
        
    }
}
