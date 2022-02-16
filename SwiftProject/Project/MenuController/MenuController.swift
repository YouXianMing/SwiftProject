//
//  MenuController.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit
import ProjectBaseLibs

class MenuController: NormalTitleViewController {
    
    override class func isNavigationControllerRootController() -> Bool { return true}
    
    override func setup() {
        
        title               = "菜单"
        backButton.isHidden = true
    }
    
    fileprivate lazy var customTableView : CustomTableView = {
        
        let tableView = CustomTableView.init(frame: CGRect.zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        func modelWith(_ controllerClass : AnyClass, title : String) -> ControllerModel {
            
            return ControllerModel.init(title: title, controllerClass: controllerClass)
        }
        
        // 注册cell+注册header
        HomeMenuCell.registerTo(customTableView.tableView)
        HomeMenuHeader.registerTo(customTableView.tableView)
        
        // 常规内容
        do {
            
            let models = [
                modelWith(CustomTableViewController.classForCoder(),       title: "CustomTableViewController"),
                modelWith(CustomCollectionViewController.classForCoder(),  title: "CustomCollectionViewController"),
                modelWith(TableViewAdapterController.classForCoder(),      title: "TableViewAdapterController"),
                modelWith(CollectionViewAdapterController.classForCoder(), title: "CollectionViewAdapterController"),
                modelWith(PlaceholderImageViewController.classForCoder(),  title: "PlaceholderImageViewController")
            ]
            
            let section = TableViewSection.init()
            section.header = HomeMenuHeader.adapter(data: "常规内容")
            models.forEach { model in section.adapters.append(HomeMenuCell.adapter(data: model))}
            customTableView.sections.append(section)
        }
        
        // 第三方库使用
        do {
            
            let models = [
                modelWith(IGListKitController.classForCoder(), title: "IGListKitController"),
            ]
            
            let section = TableViewSection.init()
            section.header = HomeMenuHeader.adapter(data: "第三方库使用")
            models.forEach { model in section.adapters.append(HomeMenuCell.adapter(data: model))}
            customTableView.sections.append(section)
        }
        
        // 添加tableView并设置布局
        contentView.addSubview(customTableView)
        customTableView.snp.makeConstraints { make in make.left.right.bottom.top.equalToSuperview()}
        customTableView.reloadData()
        
        // 事件回调
        customTableView.addEventBlock { [weak self] view, event in
            
            // cell事件
            if let _ = view as? HomeMenuCell, let model = event as? ControllerModel  {
                
                let metaType     = model.controllerClass.self as! LayoutBaseViewController.Type
                let controller   = metaType.init()
                controller.title = model.title
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
