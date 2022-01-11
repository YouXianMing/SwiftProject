//
//  AutoLayoutSheetInfoViewBuilder.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit

class AutoLayoutSheetInfoViewBuilder: SheetInfoContentViewBuilder {

    override func builderSubview() -> UIView {
        
        let view             = UIView(frame: CGRect.zero)
        view.backgroundColor = .yellow
        
        // 添加hide事件
        view.addTapGestureWithEventBlock({ [weak self] _ in self?.hide()})
        
        return view
    }
    
    override func adjustLayout(view: UIView) {
        
        view.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(500)
        }
        
        // view开始布局
        view.layoutIfNeeded()
        
        // 设置contentView的大小
        contentView.ml_height = view.ml_height
    }
}
