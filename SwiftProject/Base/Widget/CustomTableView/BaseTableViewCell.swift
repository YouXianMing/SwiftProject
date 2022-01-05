//
//  BaseTableViewCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

@objc protocol BaseTableViewCellDelegate : NSObjectProtocol {
    
    func baseTableViewCell(_ cell: BaseTableViewCell?, event: Any?)
}

class BaseTableViewCell: UITableViewCell {
    
    weak var delegate    : BaseTableViewCellDelegate?
    weak var adapter     : TableViewCellAdapter?
    weak var tableView   : UITableView?
    weak var controller  : UIViewController?
    var      indexPath   : IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
        self.buildSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// 基本设置
    func setupCell() { self.selectionStyle = .none}
    
    /// 构建子views
    func buildSubviews() {}
    
    /// 加载数据
    func loadContent() {}
    
    /// cell的回调事件(在tableView上点击到了具体的cell的点击事件,传到了cell的内部)
    func cellSelectedEvent() {}
    
    /// cell将要显示(需要在tableView的代理里手动实现)
    func willDisplay(_ indexPath : IndexPath) {}
    
    /// cell已经结束显示(需要在tableView的代理里手动实现)
    func didEndDisplaying(_ indexPath : IndexPath) {}
    
    /// cell通知代理的事件(在cell内部的事件,通过主动调用该方法,将事件传递给代理)
    func cellCallDelegateEvent(_ cell : BaseTableViewCell? = nil, data : Any? = nil) {
        
        if let objectDelegate = delegate,
            objectDelegate.responds(to: #selector(objectDelegate.baseTableViewCell(_:event:))) {
            
            objectDelegate.baseTableViewCell(cell ?? self, event: data ?? adapter?.data)
        }
    }
    
    class func heightWithData(_ data : Any? = nil) -> CGFloat { return 0}
    
    /// cell直接获取适配器对象
    class func adapter(_ reuseIdentifier : String? = nil,
                       data              : Any?    = nil,
                       height            : CGFloat = UITableView.automaticDimension,
                       info              : Any?    = nil) -> TableViewCellAdapter {
        
        return TableViewCellAdapter.init(reuseIdentifier : reuseIdentifier ?? "\(self.classForCoder())",
                                         data            : data,
                                         height          : height,
                                         info            : info)
    }
    
    /// 注册到tableView
    class func registerTo(_ tableView : UITableView, reuseIdentifier : String? = nil) {
        
        tableView.register(self.classForCoder(),
                           forCellReuseIdentifier: reuseIdentifier ?? "\(self.classForCoder())")
    }
    
    func updateWithNewCellHeight(_ height : CGFloat, animated : Bool = true) {
        
        guard tableView != nil && adapter != nil else {
            
            return
        }
        
        if animated {
            
            adapter?.height = height
            if #available(iOS 11.0, *) {
                
                tableView?.performBatchUpdates(nil, completion: nil)
                
            } else {
                
                tableView?.beginUpdates()
                tableView?.endUpdates()
            }
            
        } else {
            
            adapter?.height = height
            tableView?.reloadData()
        }
    }
}


// MARK: extension UITableView

extension UITableView {
    
    func dequeueCellAndLoad(_ adapter  : TableViewCellAdapter,
                            indexPath  : IndexPath,
                            tableView  : UITableView?               = nil,
                            delegate   : BaseTableViewCellDelegate? = nil,
                            controller : UIViewController?          = nil) -> BaseTableViewCell {
        
        let cell         = self.dequeueReusableCell(withIdentifier: adapter.reuseIdentifier!) as! BaseTableViewCell
        cell.adapter     = adapter
        cell.indexPath   = indexPath
        cell.tableView   = tableView
        cell.delegate    = delegate
        cell.controller  = controller
        cell.loadContent()
        
        return cell
    }
    
    func baseTableViewCellSelectedEventWithIndexPath(_ indexPath : IndexPath) {
        
        let cell = self.cellForRow(at: indexPath) as! BaseTableViewCell
        
        // 检测cell的类型是否为BaseTableViewCell类型
        guard cell.isKind(of: BaseTableViewCell.classForCoder()) == true else {
            
            return
        }
        
        cell.cellSelectedEvent()
    }
}
