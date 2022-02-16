//
//  AutoLayoutCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit
import ProjectBaseLibs

class AutoLayoutCell: BaseTableViewCell {

    fileprivate lazy var infoLabel : UILabel = { return UILabel()}()

    override func buildSubviews() {
        
        contentView.backgroundColor = .gray.withAlphaComponent(0.2)
        
        contentView.addSubview(infoLabel)
        infoLabel.textAlignment   = .center
        infoLabel.backgroundColor = .gray.withAlphaComponent(0.1)
        
        infoLabel.snp.makeConstraints { make in
            
            make.left.right.top.bottom.equalToSuperview().inset(50)
        }
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
        
            infoLabel.text = str
            
        } else {
            
            infoLabel.text = ""
        }
    }
    
    override func cellSelectedEvent() {
        
        appPrint(adapter?.data ?? "")
    }
    
    override func willDisplay(_ indexPath: IndexPath) {
        
        appPrint("AutoLayoutCell willDisplay")
    }
    
    override func didEndDisplaying(_ indexPath: IndexPath) {
        
        appPrint("AutoLayoutCell didEndDisplaying")
    }
}
