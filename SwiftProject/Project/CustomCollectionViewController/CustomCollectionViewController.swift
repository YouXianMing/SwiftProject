//
//  CustomCollectionViewController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit
import SwiftUI

class CustomCollectionViewController: NormalTitleViewController {

    fileprivate lazy var customCollectionView : CustomCollectionView = {
        
        let collectionView = CustomCollectionView.init(frame: CGRect.zero)
        
        GoodsItemCell.registerTo(collectionView.collectionView)
        GoodsHeader.headerRegisterTo(collectionView.collectionView)
        GoodsFooter.footerRegisterTo(collectionView.collectionView)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        // 添加tableView并设置布局
        contentView.addSubview(customCollectionView)
        customCollectionView.snp.makeConstraints { make in make.edges.equalToSuperview()}
        
        customCollectionView.addEventBlock { [weak self] view, data in
            
            self?.showView()
            
//            if let _ = view as? GoodsItemCell {
//
//                appPrint(data ?? "")
//
//            } else if let _ = view as? GoodsHeader {
//
//                appPrint(data ?? "")
//
//            } else if let _ = view as? GoodsFooter {
//
//                appPrint(data ?? "")
//            }
        }
        
        do {
            
            let section                     = CollectionViewSection.init()
            section.minimumInteritemSpacing = 10
            section.minimumLineSpacing      = 10
            section.inset                   = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
            customCollectionView.sections.append(section)
            
            section.header = GoodsHeader.headerAdapter(referenceSize: GoodsHeader.sizeWithData())
            section.footer = GoodsFooter.footerAdapter(referenceSize: GoodsFooter.sizeWithData())
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            
            appPrint(customCollectionView.contentSize)
            
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            
            appPrint(customCollectionView.contentSize)
            
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            
            appPrint(customCollectionView.contentSize)
            
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            
            appPrint(customCollectionView.contentSize)
            
            section.adapters.append(GoodsItemCell.adapter(size: GoodsItemCell.sizeWithData()))
            
            appPrint(customCollectionView.contentSize)
        }
    }
    
    func showView() {
        
        let sheetView         = SheetInfoView.init()
        sheetView.contentView = navigationController?.view
        // sheetView.viewBuilder = SheetInfoViewBuilder()
        sheetView.viewBuilder = AutoLayoutSheetInfoViewBuilder()
        sheetView.canTapBackgroundToHide = true
        sheetView.buildSubviews(with: "Hello world")
        sheetView.show()
    }
}
