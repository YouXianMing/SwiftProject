//
//  HomeMenuCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit
import ProjectBaseLibs

class HomeMenuCell: BaseTableViewCell {

    fileprivate lazy var infoLabel : UILabel = { return UILabel()}()
    fileprivate lazy var line      : UIView  = {
        
        let view             = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        return view
    }()
    
    override func buildSubviews() {
        
        contentView.addSubview(infoLabel)
        contentView.addSubview(line)
        
        infoLabel.snp.makeConstraints { make in
            
            make.top.left.equalTo(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        line.snp.makeConstraints { make in
            
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override func loadContent() {
        
        if let model = adapter?.data as? ControllerModel {
            
            infoLabel.text = model.title
            
        } else {
            
            infoLabel.text = ""
        }
    }
    
    override func cellSelectedEvent() { cellCallDelegateEvent()}
}
