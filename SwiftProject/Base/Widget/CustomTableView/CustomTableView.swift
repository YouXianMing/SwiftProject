//
//  CustomTableView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

typealias CustomTableViewEventBlock = (_: UIView?, _ : Any?) -> Void

@objc protocol CustomTableViewDelegate : NSObjectProtocol {
    
    /// 代理事件
    func customTableView(_ tableView: CustomTableView, eventView: UIView?, event: Any?)
}

class CustomTableView: UIView, UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate, BaseTableViewHeaderFooterViewDelegate {
    
    // MARK: 属性
    
    /// sections数据
    var sections : [TableViewSection] = []
    
    /// 控制器
    weak var controller : UIViewController?
    
    /// 事件代理
    weak var delegate : CustomTableViewDelegate?
    
    /// 事件block
    var eventBlock : CustomTableViewEventBlock?
    
    /// 是否可以滑动
    var canScroll : Bool {
        
        set(newVal) { tableView.isScrollEnabled = newVal}
        get { return tableView.isScrollEnabled}
    }
    
    // MARK: 只读属性
    
    /// tableView的header与footer是否使用sticky模式
    var isSticky : Bool { get { return sticky}}
    
    /// tableView
    var tableView : UITableView { get { return privateTableView!}}
    
    /// 获取tableView的contentSize
    /// [注意] 获取contentSize时,会调用tableView的reloadData方法,之后再调用layoutIfNeeded方法,开销比较大,建议在所有数据都加载完后调用此getter方法
    var contentSize : CGSize {
        
        get {
            
            tableView.reloadData()
            tableView.layoutIfNeeded()
            return tableView.contentSize
        }
    }
    
    // MARK: 私有属性
    
    /// tableView是否使用自动布局
    fileprivate var tableViewUseAutolayout = true
    
    /// tableView的header与footer是否使用sticky模式
    fileprivate var sticky = true
    
    /// tableView的对象
    fileprivate var privateTableView : UITableView?
    
    // MARK: 系统方法
    
    required init(frame: CGRect, autoLayout : Bool = true, sticky : Bool = true) {
        
        super.init(frame: frame)
        
        self.tableViewUseAutolayout = autoLayout
        self.sticky              = sticky
        
        privateTableView = buildTableView()
        addSubview(privateTableView!)
        
        if (tableViewUseAutolayout == true) {
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint   = tableView.leftAnchor.constraint(equalTo: self.leftAnchor)
            let rightConstraint  = tableView.rightAnchor.constraint(equalTo: self.rightAnchor)
            let topConstraint    = tableView.topAnchor.constraint(equalTo: self.topAnchor)
            let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            self.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        if (self.tableViewUseAutolayout == false) { privateTableView!.frame = bounds}
    }
    
    // MARK: 公开方法
    
    /// tableView重新加载数据
    func reloadData() { privateTableView!.reloadData()}
    
    
    /// 添加block事件的方法
    /// - Parameter block: block对象
    func addEventBlock(_ block : @escaping CustomTableViewEventBlock) {
        
        eventBlock = block
    }
    
    /// 构建tableView,子类可以根据需要重写此方法进行tableView的设置
    /// - Returns: UITableView对象
    func buildTableView() -> UITableView {
        
        let tableView             = UITableView(frame: CGRect.zero, style: isSticky ? .plain : .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle  = .none
        tableView.delegate        = self
        tableView.dataSource      = self
        if #available(iOS 11.0, *) { tableView.contentInsetAdjustmentBehavior = .never}
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0}
        
        return tableView
    }
    
    // MARK: UITableViewDataSource
    
    /// 获取section数量
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    /// 获取section中的row的数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].adapters.count
    }
    
    /// 获取cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueCellAndLoad(sections[indexPath.section].adapters[indexPath.row],
                                            indexPath: indexPath,
                                            tableView: tableView,
                                            delegate: self,
                                            controller: controller)
    }
    
    // MARK: UITableViewDelegate
    
    /// 获取cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return sections[indexPath.section].adapters[indexPath.row].height
    }
    
    /// cell的点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.baseTableViewCellSelectedEventWithIndexPath(indexPath)
    }
    
    /// cell将要显示
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is BaseTableViewCell { (cell as! BaseTableViewCell).willDisplay(indexPath)}
    }
    
    /// cell已经隐藏
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is BaseTableViewCell { (cell as! BaseTableViewCell).didEndDisplaying(indexPath)}
    }
    
    /// 获取header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return tableView.dequeueHeaderFooterViewAndLoad(sections[section].header,
                                                        section: section,
                                                        tableView: tableView,
                                                        delegate: self,
                                                        controller: controller)
    }
    
    /// 获取header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sections[section].header?.height ?? 0
    }
    
    /// header将要显示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if view is BaseTableViewHeaderFooterView { (view as! BaseTableViewHeaderFooterView).willDisplay(section)}
    }
    
    /// header将要隐藏
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if view is BaseTableViewHeaderFooterView { (view as! BaseTableViewHeaderFooterView).didEndDisplaying(section)}
    }
    
    /// 获取footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return tableView.dequeueHeaderFooterViewAndLoad(sections[section].footer,
                                                        section: section,
                                                        tableView: tableView,
                                                        delegate: self,
                                                        controller: controller)
    }
    
    /// 获取footer的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return sections[section].footer?.height ?? 0
    }
    
    /// footer将要显示
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if view is BaseTableViewHeaderFooterView { (view as! BaseTableViewHeaderFooterView).willDisplay(section)}
    }
    
    /// footer将要隐藏
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
        if view is BaseTableViewHeaderFooterView { (view as! BaseTableViewHeaderFooterView).didEndDisplaying(section)}
    }
    
    // MARK: BaseTableViewCellDelegate
    
    /// BaseTableViewCell的代理事件
    func baseTableViewCell(_ cell: BaseTableViewCell?, event: Any?) {
        
        // block事件
        if let block = eventBlock { block(cell, event)}
        
        // 代理事件
        if let eventDelegate = delegate,
           eventDelegate.responds(to: #selector(eventDelegate.customTableView(_:eventView:event:))) {
            
            eventDelegate.customTableView(self, eventView: cell, event: event)
        }
    }
    
    // MARK: BaseTableViewHeaderFooterViewDelegate
    
    /// BaseTableViewHeaderFooterView的代理事件
    func baseTableViewHeaderFooterView(_ headerFooterView: BaseTableViewHeaderFooterView?, event: Any?) {
        
        // block事件
        if let block = eventBlock { block(headerFooterView, event)}
        
        // 代理事件
        if let eventDelegate = delegate,
            eventDelegate.responds(to: #selector(eventDelegate.customTableView(_:eventView:event:))) {
            
            eventDelegate.customTableView(self, eventView: headerFooterView, event: event)
        }
    }
    
    // MARK: 析构方法
    
    deinit { print("♨️ '\(String(describing: self.classForCoder))' is released.")}
}
