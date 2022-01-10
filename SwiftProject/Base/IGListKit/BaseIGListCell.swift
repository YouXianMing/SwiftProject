//
//  BaseIGListCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit

class BaseIGListCell: UICollectionViewCell {
    
    weak var cellInfo : IGListCellInfo?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupCell()
        buildSubviews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// 基本设置
    func setupCell() {}
    
    /// 构建子views
    func buildSubviews() {}
    
    /// 加载数据
    func loadContent() {}
    
    class func sizeWithData(_ data : Any? = nil) -> CGSize { return CGSize.zero}
    
    class func info(_ reuseIdentifier : String? = nil,
                    data              : Any?    = nil,
                    size              : CGSize  = CGSize.zero) -> IGListCellInfo {
        
        return IGListCellInfo.init(cellClass: self.classForCoder(),
                                   size: size,
                                   data: data,
                                   reuseIdentifier: reuseIdentifier)
    }
}
