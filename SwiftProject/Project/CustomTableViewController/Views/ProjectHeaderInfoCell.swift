//
//  ProjectHeaderInfoCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class ProjectHeaderInfoCell: BaseTableViewCell {

    override func setupCell() {
        
        super.setupCell()
        contentView.backgroundColor = .clear
        backgroundColor             = .clear
    }
    
    override func buildSubviews() {
     
        let label  = UILabel()
        label.text = "My Projects"
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
