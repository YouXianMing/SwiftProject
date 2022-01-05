//
//  HomeMenuHeader.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class HomeMenuHeader: BaseTableViewHeaderFooterView {
    
    fileprivate lazy var infoLabel : UILabel = {
        
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    fileprivate lazy var line : UIView  = {
        
        let view             = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        return view
    }()
    
    override func setupHeaderFooterView() {
        
        super.setupHeaderFooterView()
        contentView.backgroundColor = .lightGray
    }
    
    override func buildSubviews() {
        
        contentView.addSubview(infoLabel)
        contentView.addSubview(line)
        
        infoLabel.snp.makeConstraints { make in
            
            make.top.left.equalTo(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10).priority(.low)
        }
        
        line.snp.makeConstraints { make in
            
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
        
            infoLabel.text = str
        }
    }
}
