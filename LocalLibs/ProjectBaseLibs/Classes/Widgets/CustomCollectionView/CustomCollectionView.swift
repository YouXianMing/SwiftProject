//
//  CustomCollectionView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/3.
//

import UIKit

public typealias CustomCollectionViewBlock = (_: UIView?, _ : Any?) -> Void

@objc public protocol CustomCollectionViewDelegate : NSObjectProtocol {
    
    /// 代理事件
    func customCollectionView(_ tableView: CustomCollectionView, eventView: UIView?, event: Any?)
}

open class CustomCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BaseCollectionViewCellDelegate, BaseCollectionReusableViewDelegate {
    
    // MARK: 属性
    
    /// sections数据
    open var sections : [CollectionViewSection] = []
    
    /// 控制器
    open weak var controller : UIViewController?
    
    /// 事件代理
    open weak var delegate : CustomCollectionViewDelegate?
    
    /// 事件block
    open var eventBlock : CustomCollectionViewBlock?
    
    /// 是否可以滑动
    open var canScroll : Bool {
        
        set(newVal) { collectionView.isScrollEnabled = newVal}
        get { return collectionView.isScrollEnabled}
    }
    
    // MARK: 只读属性
    
    /// collectionView的header是否使用sticky模式
    open var isHeaderSticky : Bool { get { return headerSticky}}
    
    /// collectionView的footer是否使用sticky模式
    open var isFooterSticky : Bool { get { return footerSticky}}
    
    /// collectionView
    open var collectionView : UICollectionView { get { return privateCollectionView!}}
    
    /// 获取collectionView的contentSize
    /// [注意] 获取contentSize时,会调用collectionView的reloadData方法,之后再调用layoutIfNeeded方法,开销比较大,建议在所有数据都加载完后调用此getter方法
    open var contentSize : CGSize {
        
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
    required public init(frame: CGRect, autoLayout : Bool = true, headerSticky : Bool = true, footerSticky : Bool = true) {
        
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
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        if (self.collectionViewUseAutolayout == false) { privateCollectionView!.frame = bounds}
    }
    
    // MARK: 公开方法
    
    /// collectionView重新加载数据
    open func reloadData() { privateCollectionView!.reloadData()}
    
    
    /// 添加block事件的方法
    /// - Parameter block: block对象
    open func addEventBlock(_ block : @escaping CustomCollectionViewBlock) {
        
        eventBlock = block
    }
    
    /// 构建collectionView,子类可以根据需要重写此方法进行collectionView的设置
    /// - Returns: UICollectionView对象
    open func buildCollectionView() -> UICollectionView {
        
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
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return sections.count
    }
    
    /// 获取section中的row的数量
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sections[section].adapters.count
    }
    
    /// 获取cell
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueCellAndLoad(sections[indexPath.section].adapters[indexPath.row],
                                                 indexPath: indexPath,
                                                 collectionView: collectionView,
                                                 delegate: self,
                                                 controller: controller)
    }
    
    /// 获取reusableView
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
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
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.baseCollectionViewSelectedEventWithIndexPath(indexPath)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    /// 获取cell的尺寸
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return sections[indexPath.section].adapters[indexPath.row].size
    }
    
    /// 获取section的内边距
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sections[section].inset
    }
    
    /// 获取section内元素的换行时的间距
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sections[section].minimumLineSpacing
    }
    
    /// 获取section内元素排列时的间距
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return sections[section].minimumInteritemSpacing
    }
    
    /// cell将要显示
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell is BaseCollectionViewCell { (cell as! BaseCollectionViewCell).willDisplay(indexPath)}
    }
    
    /// cell将要隐藏
    open func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell is BaseCollectionViewCell { (cell as! BaseCollectionViewCell).didEndDisplaying(indexPath)}
    }
    
    /// 获取header的尺寸
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return sections[section].header?.referenceSize ?? CGSize.zero
    }
    
    /// 获取footer的尺寸
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return sections[section].footer?.referenceSize ?? CGSize.zero
    }
    
    /// 将要显示supplementaryView
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        if view is BaseCollectionReusableView { (view as! BaseCollectionReusableView).willDisplay(indexPath)}
    }
    
    /// supplementaryView已经隐藏
    open func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
        if view is BaseCollectionReusableView { (view as! BaseCollectionReusableView).didEndDisplaying(indexPath)}
    }
    
    // MARK: BaseCollectionViewCellDelegate
    
    /// BaseCollectionViewCell的代理事件
    open func baseCollectionViewCell(_ cell: BaseCollectionViewCell?, event: Any?) {
        
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
    open func baseCollectionReusableView(_ headerFooterView: BaseCollectionReusableView?, event: Any?) {
        
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
