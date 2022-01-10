//
//  IGListSectionData.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//

import UIKit
import IGListKit

// BaseIGListSectionDataDiffable

class BaseIGListSectionDataDiffable: NSObject, ListDiffable {
    
    /// 当前section的唯一标识符
    var identifier : String = UUID().uuidString
    
    /// 当前section的标记
    var mark : String?
    
    /// cell的数据信息
    var cellInfos  : [IGListCellInfo] = []
    
    required init(_ identifier : String?          = nil,
                  mark         : String?          = nil,
                  cellInfos    : [IGListCellInfo] = []) {
        
        if (identifier != nil) { self.identifier = identifier!}
        self.mark      = mark
        self.cellInfos = cellInfos
        super.init()
    }
    
    /// 可以使用默认值BaseIGListSectionController,或者重写使用新的控制器
    func getIGListSectionController() -> BaseIGListSectionController {
        
        return BaseIGListSectionController.init(self)
    }
    
    // MARK: ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        
        return identifier as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        
        guard let object = object as? BaseIGListSectionDataDiffable else {
            
            return false
        }
        
        return self.identifier == object.identifier
    }
}

