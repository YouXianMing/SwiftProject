//
//  Section_1_Header.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class Section_1_Header: BaseTableViewHeaderFooterView {

    fileprivate lazy var infoLabel : UILabel = { return UILabel()}()
    
    override func setupHeaderFooterView() {
    
        contentView.backgroundColor = .red.withAlphaComponent(0.1)
    }
    
    override func buildSubviews() {
        
        contentView.addSubview(infoLabel)
        infoLabel.backgroundColor = .red
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
        
            infoLabel.text = str
            
        } else {
            
            infoLabel.text = ""
        }
        
        infoLabel.sizeToFit()
        infoLabel.centerX = Screen.width / 2
        infoLabel.centerY = (adapter?.height ?? 0) / 2
    }
    
    override func willDisplay(_ section: Int) {
        
        print("Section_1_Header willDisplay")
    }
    
    override func didEndDisplaying(_ section: Int) {
        
        print("Section_1_Header didEndDisplaying")
    }
}
