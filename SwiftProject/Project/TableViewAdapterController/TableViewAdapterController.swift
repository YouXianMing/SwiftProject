//
//  TableViewAdapterController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class TableViewAdapterController: NormalTitleViewController {
    
    fileprivate lazy var tableView : UITableView = {
        
        let tableView            = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.delegate       = self
        tableView.dataSource     = self
        if #available(iOS 11.0, *) { tableView.contentInsetAdjustmentBehavior = .never}
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0}
        
        FixedHeightCell.registerTo(tableView)
        AutoLayoutCell.registerTo(tableView)
        Section_1_Header.registerTo(tableView)
        Section_2_Header.registerTo(tableView)
        Section_1_Footer.registerTo(tableView)
        Section_2_Footer.registerTo(tableView)
        
        return tableView
    }()
    
    var sections : [TableViewSection] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in make.left.right.bottom.top.equalToSuperview()}
        
        do {
            let section = TableViewSection.init()
            sections.append(section)
            
            section.header = Section_1_Header.adapter(data: "Section_1_Header 手动布局", height: 30)
            section.footer = Section_1_Footer.adapter(data: "Section_1_Footer 手动布局", height: 30)
            section.adapters.append(FixedHeightCell.adapter(data: "FixedHeightCell 手动布局", height: 90))
            section.adapters.append(AutoLayoutCell.adapter(data: "AutoLayoutCell 自动布局"))
        }
        
        do {
            let section = TableViewSection.init()
            sections.append(section)
            
            section.header = Section_2_Header.adapter(data: "Section_2_Header 自动布局")
            section.footer = Section_2_Footer.adapter(data: "Section_2_Footer 自动布局")
            section.adapters.append(FixedHeightCell.adapter(data: "FixedHeightCell 手动布局", height: 90))
            section.adapters.append(AutoLayoutCell.adapter(data: "AutoLayoutCell 自动布局"))
        }
    }
}

extension TableViewAdapterController: UITableViewDelegate, UITableViewDataSource, BaseTableViewCellDelegate, BaseTableViewHeaderFooterViewDelegate {
    
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
                                            controller: self)
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
                                                        controller: self)
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
                                                        controller: self)
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
    
    func baseTableViewCell(_ cell: BaseTableViewCell?, event: Any?) {
        
    }
    
    // MARK: BaseTableViewHeaderFooterViewDelegate
    
    func baseTableViewHeaderFooterView(_ headerFooterView: BaseTableViewHeaderFooterView?, event: Any?) {
        
    }
}
