//
//  IGListKitController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/7.
//

import UIKit
import IGListKit

class IGListKitController: NormalTitleViewController {
    
    let collectionView: UICollectionView = {
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .white
        return view
    }()
    
    lazy var adapter: ListAdapter = {
        
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    var sections : [BaseIGListSectionDataDiffable] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        do {
            
            let dataDiffable = BaseIGListSectionDataDiffable.init()
            dataDiffable.cellInfos.append(IGListType1Cell.info(data: "33", size: IGListType1Cell.sizeWithData("333")))
            dataDiffable.cellInfos.append(IGListType1Cell.info(data: "33", size: IGListType1Cell.sizeWithData("333")))
            dataDiffable.cellInfos.append(IGListType1Cell.info(data: "33", size: IGListType1Cell.sizeWithData("333")))
            
            sections.append(dataDiffable)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in make.edges.equalToSuperview()}
        
        adapter.collectionView = collectionView
        adapter.dataSource     = self
    }
}

extension IGListKitController: ListAdapterDataSource {
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        
        return sections
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if let object = object as? BaseIGListSectionDataDiffable {
        
            return object.getIGListSectionController()
        }
        
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        
        return nil
    }
}
