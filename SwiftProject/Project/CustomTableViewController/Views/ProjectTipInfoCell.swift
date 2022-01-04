//
//  ProjectTipInfoCell.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class ProjectTipInfoCell: BaseTableViewCell {

    private lazy var whiteBgView : UIView = {
        
        let whiteBgView                = UIView()
        whiteBgView.backgroundColor    = .white
        whiteBgView.layer.cornerRadius = 10
        whiteBgView.clipsToBounds      = true
        
        return whiteBgView
    }()
    
    private lazy var infoLabel : UILabel = {
        
        let label           = UILabel()
        label.numberOfLines = 0
        label.font          = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    override func setupCell() {
        
        super.setupCell()
        contentView.backgroundColor = .clear
        backgroundColor             = .clear
    }
    
    override func buildSubviews() {
     
        contentView.addSubview(whiteBgView)
        whiteBgView.addSubview(infoLabel)
        
        whiteBgView.snp.makeConstraints { make in
            
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        infoLabel.snp.makeConstraints { make in
            
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
            
            infoLabel.text = str
        }
    }
}
