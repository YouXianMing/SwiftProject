//
//  Section_2_Footer.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class Section_2_Footer: BaseTableViewHeaderFooterView {

    fileprivate lazy var infoLabel : UILabel = { return UILabel()}()
    
    override func setupHeaderFooterView() {
    
        contentView.backgroundColor = .red.withAlphaComponent(0.1)
    }
    
    override func buildSubviews() {
        
        contentView.addSubview(infoLabel)
        infoLabel.backgroundColor = .red
        infoLabel.snp.makeConstraints { make in
            
            make.left.right.top.equalToSuperview().inset(20)
            
            // 将优先级改低,避免报约束问题
            // https://www.wangquanwei.com/75.html
            make.bottom.equalToSuperview().offset(-20).priority(.low)
        }
    }
    
    override func loadContent() {
        
        if let str = adapter?.data as? String {
        
            infoLabel.text = str
            
        } else {
            
            infoLabel.text = ""
        }
    }
    
    override func willDisplay(_ section: Int) {
        
        print("Section_2_Footer willDisplay")
    }
    
    override func didEndDisplaying(_ section: Int) {
        
        print("Section_2_Footer didEndDisplaying")
    }
}
