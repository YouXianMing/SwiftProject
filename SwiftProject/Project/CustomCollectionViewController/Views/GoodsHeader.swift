//
//  GoodsHeader.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit
import ProjectBaseLibs

class GoodsHeader: BaseCollectionReusableView {
        
    fileprivate lazy var bgView : UIView = {
        
        let view             = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func buildSubviews() {
        
        addSubview(bgView)
        
        bgView.snp.makeConstraints { make in

            make.edges.equalToSuperview()
        }
        
        bgView.addTapGestureWithEventBlock { [weak self] _ in
            
            self?.collectionReusableViewCallDelegateEvent(self, data: "Header")
        }
    }
    
    override class func sizeWithData(_ data: Any? = nil) -> CGSize {
        
        return CGSize(width: Screen.width, height: 50)
    }
    
    override func loadContent() {
        
    }
}
