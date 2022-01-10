//
//  BaseIGListSection.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit
import IGListKit

class BaseIGListSectionController: ListSectionController {
        
    /// IGListSectionData
    var sectionData : BaseIGListSectionDataDiffable
    
    required init(_ sectionData: BaseIGListSectionDataDiffable) {
        
        self.sectionData = sectionData
        super.init()
    }
    
    override func numberOfItems() -> Int {
        
        return sectionData.cellInfos.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        
        return sectionData.cellInfos[index].size
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let cellInfo = sectionData.cellInfos[index]
        
        let cell = collectionContext?.dequeueReusableCell(of: cellInfo.cellClass.self,
                                               withReuseIdentifier: cellInfo.reuseIdentifier,
                                               for: self,
                                               at: index)
    
        if let cell = cell as? BaseIGListCell {
            
            cell.cellInfo = cellInfo
            cell.loadContent()
        }
        
        return cell!
    }
}
