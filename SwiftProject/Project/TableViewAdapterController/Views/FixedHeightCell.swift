//
//  FixedHeightCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class FixedHeightCell: BaseTableViewCell {
    
    fileprivate lazy var infoLabel : UILabel = {
        
        let label             = UILabel()
        label.backgroundColor = .red.withAlphaComponent(0.1)
        
        return label
    }()
    
    override func buildSubviews() {
        
        contentView.backgroundColor = .gray.withAlphaComponent(0.1)
        contentView.addSubview(infoLabel)
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
            
            infoLabel.text = str
            
        } else {
            
            infoLabel.text = ""
        }
        
        infoLabel.sizeToFit()
        
        if let height = adapter?.height {
            
            infoLabel.centerY = height / 2
            infoLabel.centerX = Screen.width / 2
        }
    }
    
    override func cellSelectedEvent() {
        
        appPrint(adapter?.data ?? "")
    }
    
    override func willDisplay(_ indexPath: IndexPath) {
        
        appPrint("FixedHeightCell willDisplay")
    }
    
    override func didEndDisplaying(_ indexPath: IndexPath) {
        
        appPrint("FixedHeightCell didEndDisplaying")
    }
}
