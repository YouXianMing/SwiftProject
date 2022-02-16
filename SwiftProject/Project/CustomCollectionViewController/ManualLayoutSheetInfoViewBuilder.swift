//
//  ManualLayoutSheetInfoViewBuilder.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit
import ProjectBaseLibs

class ManualLayoutSheetInfoViewBuilder: SheetInfoContentViewBuilder {

    override func builderSubview() -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0,
                                        width: contentView.ml_width,
                                        height: contentView.ml_height * 0.7))
        view.backgroundColor = .yellow

        // 添加hide事件
        view.addTapGestureWithEventBlock({ [weak self] _ in self?.hide()})
        
        return view
    }
    
    override func adjustLayout(view: UIView) {
        
        contentView.ml_height = view.ml_height
    }
}
