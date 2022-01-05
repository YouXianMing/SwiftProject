//
//  BaseTableViewHeaderFooterView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

@objc protocol BaseTableViewHeaderFooterViewDelegate : NSObjectProtocol {
    
    func baseTableViewHeaderFooterView(_ headerFooterView: BaseTableViewHeaderFooterView?, event: Any?)
}

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    weak var delegate    : BaseTableViewHeaderFooterViewDelegate?
    weak var adapter     : TableViewHeaderFooterViewAdapter?
    weak var tableView   : UITableView?
    weak var controller  : UIViewController?
    var section          : Int?
    
    class func heightWithData(_ data : Any? = nil) -> CGFloat { return 0}
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeaderFooterView()
        buildSubviews()
    }
    
    /// 基本设置
    func setupHeaderFooterView() {
        
        if #available(iOS 14.0, *) { backgroundConfiguration = .clear()}
        contentView.backgroundColor = .white
    }
    
    /// 构建子views
    func buildSubviews() {}
    
    /// 加载数据
    func loadContent() {}
    
    /// HeaderFooterView将要显示(需要在tableView的代理里手动实现)
    func willDisplay(_ section : Int) {}
    
    /// HeaderFooterView已经结束显示(需要在tableView的代理里手动实现)
    func didEndDisplaying(_ section : Int) {}
    
    /// headerFooterView通知代理的事件(在headerFooterView内部的事件,通过主动调用该方法,将事件传递给代理)
    func headerFooterViewCallDelegateEvent(_ headerFooterView : BaseTableViewHeaderFooterView? = nil, data : Any? = nil) {
        
        if let objectDelegate = delegate,
            objectDelegate.responds(to: #selector(objectDelegate.baseTableViewHeaderFooterView(_:event:))) {
            
            objectDelegate.baseTableViewHeaderFooterView(headerFooterView ?? self, event: data ?? adapter?.data)
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// cell直接获取适配器对象
    class func adapter(_ reuseIdentifier : String? = nil,
                       data              : Any?    = nil,
                       height            : CGFloat = UITableView.automaticDimension,
                       info              : Any?    = nil) -> TableViewHeaderFooterViewAdapter {
        
        return TableViewHeaderFooterViewAdapter.init(reuseIdentifier : reuseIdentifier ?? "\(self.classForCoder())",
                                                     data            : data,
                                                     height          : height,
                                                     info            : info)
    }
    
    /// 注册到tableView
    class func registerTo(_ tableView : UITableView, reuseIdentifier : String? = nil) {
        
        tableView.register(self.classForCoder(),
                           forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? "\(self.classForCoder())")
    }
}

// MARK: extension UITableView

extension UITableView {
    
    func dequeueHeaderFooterViewAndLoad(_ adapter  : TableViewHeaderFooterViewAdapter?,
                                        section    : Int,
                                        tableView  : UITableView?                           = nil,
                                        delegate   : BaseTableViewHeaderFooterViewDelegate? = nil,
                                        controller : UIViewController?                      = nil) -> BaseTableViewHeaderFooterView? {
        
        if let headerFooterAdapter = adapter {
            
            let view = self.dequeueReusableHeaderFooterView(withIdentifier: headerFooterAdapter.reuseIdentifier!) as! BaseTableViewHeaderFooterView
            view.adapter    = headerFooterAdapter
            view.section    = section
            view.tableView  = tableView
            view.delegate   = delegate
            view.controller = controller
            view.loadContent()
            
            return view
            
        } else {
            
            return nil
        }
    }
}
