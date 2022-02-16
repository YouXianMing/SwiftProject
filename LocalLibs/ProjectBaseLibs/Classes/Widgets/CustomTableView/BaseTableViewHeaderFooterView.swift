//
//  BaseTableViewHeaderFooterView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

@objc public protocol BaseTableViewHeaderFooterViewDelegate : NSObjectProtocol {
    
    func baseTableViewHeaderFooterView(_ headerFooterView: BaseTableViewHeaderFooterView?, event: Any?)
}

open class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    open weak var delegate    : BaseTableViewHeaderFooterViewDelegate?
    open weak var adapter     : TableViewHeaderFooterViewAdapter?
    open weak var tableView   : UITableView?
    open weak var controller  : UIViewController?
    open var section          : Int?
    
    open class func heightWithData(_ data : Any? = nil) -> CGFloat { return 0}
    
    public override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeaderFooterView()
        buildSubviews()
    }
    
    /// 基本设置
    open func setupHeaderFooterView() {
        
        if #available(iOS 14.0, *) { backgroundConfiguration = .clear()}
        contentView.backgroundColor = .white
    }
    
    /// 构建子views
    open func buildSubviews() {}
    
    /// 加载数据
    open func loadContent() {}
    
    /// HeaderFooterView将要显示(需要在tableView的代理里手动实现)
    open func willDisplay(_ section : Int) {}
    
    /// HeaderFooterView已经结束显示(需要在tableView的代理里手动实现)
    open func didEndDisplaying(_ section : Int) {}
    
    /// headerFooterView通知代理的事件(在headerFooterView内部的事件,通过主动调用该方法,将事件传递给代理)
    open func headerFooterViewCallDelegateEvent(_ headerFooterView : BaseTableViewHeaderFooterView? = nil, data : Any? = nil) {
        
        if let objectDelegate = delegate,
            objectDelegate.responds(to: #selector(objectDelegate.baseTableViewHeaderFooterView(_:event:))) {
            
            objectDelegate.baseTableViewHeaderFooterView(headerFooterView ?? self, event: data ?? adapter?.data)
        }
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// cell直接获取适配器对象
    open class func adapter(_ reuseIdentifier : String? = nil,
                       data              : Any?    = nil,
                       height            : CGFloat = UITableView.automaticDimension,
                       info              : Any?    = nil) -> TableViewHeaderFooterViewAdapter {
        
        return TableViewHeaderFooterViewAdapter.init(reuseIdentifier : reuseIdentifier ?? "\(self.classForCoder())",
                                                     data            : data,
                                                     height          : height,
                                                     info            : info)
    }
    
    /// 注册到tableView
    open class func registerTo(_ tableView : UITableView, reuseIdentifier : String? = nil) {
        
        tableView.register(self.classForCoder(),
                           forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? "\(self.classForCoder())")
    }
}

// MARK: extension UITableView

public extension UITableView {
    
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
