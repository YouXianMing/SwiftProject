//
//  CustomTableViewController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit
import ProjectBaseLibs

class CustomTableViewController: NormalTitleViewController {

    fileprivate lazy var customTableView : CustomTableView = {
        
        let tableView = CustomTableView.init(frame: CGRect.zero)
        
        ProjectHeaderInfoCell.registerTo(tableView.tableView)
        ProjectTipInfoCell.registerTo(tableView.tableView)
        ProjectPlansCell.registerTo(tableView.tableView)
        ProjectImageCell.registerTo(tableView.tableView)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        contentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
        // 添加tableView并设置布局
        contentView.addSubview(customTableView)
        customTableView.snp.makeConstraints { make in make.edges.equalToSuperview()}
        
        let section = TableViewSection.init()
        customTableView.sections.append(section)
        
        // 自动布局相关cell
        do {
         
            // 标题
            section.adapters.append(ProjectHeaderInfoCell.adapter())
            
            // 提示信息
            section.adapters.append(ProjectTipInfoCell.adapter(data: "Thanks For Signing With Eano! Please prepare the first stage materials as soon as possible so that we can start our project."))
            
            // Plans
            section.adapters.append(ProjectPlansCell.adapter(data: "$6000"))
        }
        
        // 手动布局相关cell
        do {
            
            section.adapters.append(ProjectImageCell.adapter(data: "https://images2015.cnblogs.com/blog/607542/201705/607542-20170519142114463-571277930.png",
                                                             height: ProjectImageCell.heightWithData()))
        }
    }
}
