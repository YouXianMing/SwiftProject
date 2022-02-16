//
//  ProjectImageCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit
import ProjectBaseLibs

class ProjectImageCell: BaseTableViewCell {

    fileprivate lazy var iconImageView : PlaceholderImageView = {
        
        let view   = PlaceholderImageView.tilesType()
        view.frame = CGRect(x: 10, y: 0, width: Screen.width - 20, height: Self.heightWithData())
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func buildSubviews() {
        
        contentView.addSubview(iconImageView)
    }
    
    override class func heightWithData(_ data: Any? = nil) -> CGFloat { return 150}
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
            
            iconImageView.urlString = str
        }
    }
}
