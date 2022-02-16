//
//  ProjectPlansCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit
import ProjectBaseLibs

class ProjectPlansCell: BaseTableViewCell {

    private lazy var whiteBgView : UIView = {
        
        let whiteBgView                = UIView()
        whiteBgView.backgroundColor    = .white
        whiteBgView.layer.cornerRadius = 10
        whiteBgView.clipsToBounds      = true
        
        return whiteBgView
    }()
    
    private lazy var titleLabel : UILabel = {
        
        let label           = UILabel()
        label.numberOfLines = 0
        label.font          = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private lazy var line : UIView = {
        
        let view             = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.25)
        return view
    }()
    
    private lazy var infoLabel : UILabel = {
        
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    private lazy var priceLabel : UILabel = {
        
        let label       = UILabel()
        label.font      = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .blue
        
        return label
    }()
    
    override func setupCell() {
        
        super.setupCell()
        contentView.backgroundColor = .clear
        backgroundColor             = .clear
    }
    
    override func buildSubviews() {
     
        contentView.addSubview(whiteBgView)
        whiteBgView.addSubview(titleLabel)
        whiteBgView.addSubview(infoLabel)
        whiteBgView.addSubview(line)
        whiteBgView.addSubview(priceLabel)
        
        whiteBgView.snp.makeConstraints { make in
            
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        titleLabel.snp.makeConstraints { make in
            
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(25)
            make.bottom.equalTo(line).offset(-25)
        }
        
        line.snp.makeConstraints { make in
            
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1)
        }
        
        infoLabel.snp.makeConstraints { make in
            
            make.left.equalTo(10)
            make.top.equalTo(line).offset(15)
            make.bottom.equalTo(-15)
        }
        
        priceLabel.snp.makeConstraints { make in
            
            make.right.equalTo(-10)
            make.centerY.equalTo(infoLabel)
        }
    }
    
    override func loadContent() {
        
        titleLabel.text = "Plans & Permitting"
        infoLabel.text  = "Total Cost:"
        if let str = adapter?.data as? String {
            
            priceLabel.text = str
        }
    }
    
    override func cellSelectedEvent() {
        
        adapter?.data = "$\(Int(arc4random() % 2000) + 2000)"
        loadContent()
    }
}
