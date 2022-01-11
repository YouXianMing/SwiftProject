//
//  CustomCollectionView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit

typealias CustomCollectionViewBlock = (_: UIView?, _ : Any?) -> Void

@objc protocol CustomCollectionViewDelegate : NSObjectProtocol {
    
    /// 代理事件
    func customCollectionView(_ tableView: CustomCollectionView, eventView: UIView?, event: Any?)
}

class CustomCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BaseCollectionViewCellDelegate, BaseCollectionReusableViewDelegate {
    
    // MARK: 属性
    
    /// sections数据
    var sections : [CollectionViewSection] = []
    
    /// 控制器
    weak var controller : UIViewController?
    
    /// 事件代理
    weak var delegate : CustomCollectionViewDelegate?
    
    /// 事件block
    var eventBlock : CustomCollectionViewBlock?
    
    /// 是否可以滑动
    var canScroll : Bool {
        
        set(newVal) { collectionView.isScrollEnabled = newVal}
        get { return collectionView.isScrollEnabled}
    }
    
    // MARK: 只读属性
    
    /// collectionView的header是否使用sticky模式
    var isHeaderSticky : Bool { get { return headerSticky}}
    
    /// collectionView的footer是否使用sticky模式
    var isFooterSticky : Bool { get { return footerSticky}}
    
    /// collectionView
    var collectionView : UICollectionView { get { return privateCollectionView!}}
    
    /// 获取collectionView的contentSize
    /// [注意] 获取contentSize时,会调用collectionView的reloadData方法,之后再调用layoutIfNeeded方法,开销比较大,建议在所有数据都加载完后调用此getter方法
    var contentSize : CGSize {
        
        get {
            
            collectionView.reloadData()
            collectionView.layoutIfNeeded()
            return collectionView.contentSize
        }
    }
    
    // MARK: 私有属性
    
    /// collectionView是否使用自动布局
    fileprivate var collectionViewUseAutolayout = true
    
    /// collectionView的header是否使用sticky模式
    fileprivate var headerSticky = true
    
    /// collectionView的footer是否使用sticky模式
    fileprivate var footerSticky = true
    
    /// collectionView的对象
    fileprivate var privateCollectionView : UICollectionView?
    
    // MARK: 系统方法
    
    /// 生成CustomCollectionView
    /// - Parameters:
    ///   - frame: Frame值
    ///   - autoLayout: CollectionView是否使用AutoLayout,默认为true
    ///   - headerSticky: header是否使用sticky模式,默认为true
    ///   - footerSticky: footer是否使用sticky模式,默认为true
    required init(frame: CGRect, autoLayout : Bool = true, headerSticky : Bool = true, footerSticky : Bool = true) {
        
        super.init(frame: frame)
        
        self.collectionViewUseAutolayout = autoLayout
        self.headerSticky                = headerSticky
        self.footerSticky                = footerSticky
        
        privateCollectionView = buildCollectionView()
        addSubview(privateCollectionView!)
        
        if (collectionViewUseAutolayout == true) {
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint   = collectionView.leftAnchor.constraint(equalTo: self.leftAnchor)
            let rightConstraint  = collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
            let topConstraint    = collectionView.topAnchor.constraint(equalTo: self.topAnchor)
            let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            self.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        if (self.collectionViewUseAutolayout == false) { privateCollectionView!.frame = bounds}
    }
    
    // MARK: 公开方法
    
    /// collectionView重新加载数据
    func reloadData() { privateCollectionView!.reloadData()}
    
    
    /// 添加block事件的方法
    /// - Parameter block: block对象
    func addEventBlock(_ block : @escaping CustomCollectionViewBlock) {
        
        eventBlock = block
    }
    
    /// 构建collectionView,子类可以根据需要重写此方法进行collectionView的设置
    /// - Returns: UICollectionView对象
    func buildCollectionView() -> UICollectionView {
        
        let layout               = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 此处设置后,cell可以支持自动布局
        layout.sectionHeadersPinToVisibleBounds = isHeaderSticky
        layout.sectionFootersPinToVisibleBounds = isFooterSticky
        
        let collectionView             = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate        = self
        collectionView.dataSource      = self
        return collectionView
    }
    
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
                                                 controller: controller)
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
                                                         controller: controller)
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
    
    /// 将要显示supplementaryView
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if view is BaseCollectionReusableView { (view as! BaseCollectionReusableView).willDisplay(indexPath)}
    }
    
    /// supplementaryView已经隐藏
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if view is BaseCollectionReusableView { (view as! BaseCollectionReusableView).didEndDisplaying(indexPath)}
    }
    
    // MARK: BaseCollectionViewCellDelegate
    
    /// BaseCollectionViewCell的代理事件
    func baseCollectionViewCell(_ cell: BaseCollectionViewCell?, event: Any?) {
        
        // block事件
        if let block = eventBlock { block(cell, event)}
        
        // 代理事件
        if let eventDelegate = delegate,
           eventDelegate.responds(to: #selector(eventDelegate.customCollectionView(_:eventView:event:))) {
            
            eventDelegate.customCollectionView(self, eventView: cell, event: event)
        }
    }
    
    // MARK: BaseCollectionReusableViewDelegate
    
    /// BaseCollectionReusableView的代理事件
    func baseCollectionReusableView(_ headerFooterView: BaseCollectionReusableView?, event: Any?) {
        
        // block事件
        if let block = eventBlock { block(headerFooterView, event)}
        
        // 代理事件
        if let eventDelegate = delegate,
           eventDelegate.responds(to: #selector(eventDelegate.customCollectionView(_:eventView:event:))) {
            
            eventDelegate.customCollectionView(self, eventView: headerFooterView, event: event)
        }
    }
    
    // MARK: 析构方法
    
    deinit { print("♨️ '\(String(describing: self.classForCoder))' is released.")}
}
