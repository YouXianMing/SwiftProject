//
//  Section_1_Header.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit
import ProjectBaseLibs

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
        infoLabel.ml_centerX = Screen.width / 2
        infoLabel.ml_centerY = (adapter?.height ?? 0) / 2
    }
    
    override func willDisplay(_ section: Int) {
        
        appPrint("Section_1_Header willDisplay")
    }
    
    override func didEndDisplaying(_ section: Int) {
        
        appPrint("Section_1_Header didEndDisplaying")
    }
}
