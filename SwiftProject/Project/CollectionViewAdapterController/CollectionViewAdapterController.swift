//
//  CollectionViewAdapterController.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class CollectionViewAdapterController: NormalTitleViewController {

    fileprivate lazy var layout : UICollectionViewFlowLayout = {
        
        let layout               = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 此处设置后可以支持自动布局
        return layout
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let collectionView             = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate        = self
        collectionView.dataSource      = self
        return collectionView
    }()
    
    var sections : [CollectionViewSection] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in make.left.right.top.bottom.equalToSuperview()}
        
        CollectionViewFixedSizeCell.registerTo(collectionView)
        CollectionViewAutolayoutCell.registerTo(collectionView)
         CollectionViewHeader.headerRegisterTo(collectionView)
        CollectionViewFooter.footerRegisterTo(collectionView)
        
        do {
            let section = CollectionViewSection.init()
            section.minimumLineSpacing = 10
            section.minimumInteritemSpacing = 10
            section.inset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
            
            section.header = CollectionViewHeader.headerAdapter(data: "Hello", referenceSize: CGSize(width: Screen.width, height: 70))
            section.footer = CollectionViewFooter.footerAdapter(data: "Hello", referenceSize: CGSize(width: Screen.width, height: 70))
            
            section.adapters.append(CollectionViewFixedSizeCell.adapter(data: nil, size: CGSize(width: 50, height: 100)))
            section.adapters.append(CollectionViewFixedSizeCell.adapter(data: nil, size: CGSize(width: 50, height: 70)))
            section.adapters.append(CollectionViewFixedSizeCell.adapter(data: nil, size: CGSize(width: 50, height: 100)))
            section.adapters.append(CollectionViewFixedSizeCell.adapter(data: nil, size: CGSize(width: 50, height: 100)))
            section.adapters.append(CollectionViewAutolayoutCell.adapter(data: nil))
            sections.append(section)
        }
        
        collectionView.reloadData()
    }
}

extension CollectionViewAdapterController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BaseCollectionViewCellDelegate, BaseCollectionReusableViewDelegate {
    
    
    // MARK: UICollectionViewDataSource
    
    /// 获取section数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
    
        return sections.count
    }
    
    /// 获取section中的row的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sections[section].adapters.count
    }
    
    /// 获取cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueCellAndLoad(sections[indexPath.section].adapters[indexPath.row],
                                                 indexPath: indexPath,
                                                 collectionView: collectionView,
                                                 delegate: self,
                                                 controller: self)
    }
    
    /// 获取reusableView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let section = sections[indexPath.section]
        var adapter : CollectionReusableViewAdapter?
        
        if (kind == UICollectionView.elementKindSectionHeader && section.header?.reuseIdentifier != nil) {
           
            adapter = section.header
            
        } else if (kind == UICollectionView.elementKindSectionFooter && section.footer?.reuseIdentifier != nil) {
            
            adapter = section.footer
        }
        
        return collectionView.dequeueReusableViewAndLoad(adapter,
                                                         indexPath: indexPath,
                                                         collectionView: collectionView,
                                                         delegate: self,
                                                         controller: self)
    }
    
    // MARK: UICollectionViewDelegate
    
    /// cell的点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.baseCollectionViewSelectedEventWithIndexPath(indexPath)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    /// 获取cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return sections[indexPath.section].adapters[indexPath.row].size
    }
    
    /// 获取section的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sections[section].inset
    }
    
    /// 获取section内元素的换行时的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sections[section].minimumLineSpacing
    }
    
    /// 获取section内元素排列时的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return sections[section].minimumInteritemSpacing
    }
    
    /// cell将要显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell is BaseCollectionViewCell { (cell as! BaseCollectionViewCell).willDisplay(indexPath)}
    }
    
    /// cell将要隐藏
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell is BaseCollectionViewCell { (cell as! BaseCollectionViewCell).didEndDisplaying(indexPath)}
    }
    
    /// 获取header的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return sections[section].header?.referenceSize ?? CGSize.zero
    }
    
    /// 获取footer的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return sections[section].footer?.referenceSize ?? CGSize.zero
    }
    
    // MARK: BaseCollectionViewCellDelegate
    
    func baseCollectionViewCell(_ cell: BaseCollectionViewCell?, event: Any?) {
        
    }
    
    // MARK: BaseCollectionReusableViewDelegate
    func baseCollectionReusableView(_ headerFooterView: BaseCollectionReusableView?, event: Any?) {
        
    }
}
