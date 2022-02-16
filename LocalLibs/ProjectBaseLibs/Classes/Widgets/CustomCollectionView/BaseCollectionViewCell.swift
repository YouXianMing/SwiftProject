//
//  BaseCollectionViewCell.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

@objc public protocol BaseCollectionViewCellDelegate : NSObjectProtocol {
    
    func baseCollectionViewCell(_ cell: BaseCollectionViewCell?, event: Any?)
}

open class BaseCollectionViewCell: UICollectionViewCell {
    
    open weak var delegate       : BaseCollectionViewCellDelegate?
    open weak var adapter        : CollectionViewCellAdapter?
    open weak var collectionView : UICollectionView?
    open weak var controller     : UIViewController?
    open var      indexPath      : IndexPath?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupCell()
        buildSubviews()
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// 基本设置
    open func setupCell() {}
    
    /// 构建子views
    open func buildSubviews() {}
    
    /// 加载数据
    open func loadContent() {}
    
    /// cell的回调事件(在collectionView上点击到了具体的cell的点击事件,传到了cell的内部)
    open func cellSelectedEvent() {}
    
    /// cell将要显示(需要在collectionView的代理里手动实现)
    open func willDisplay(_ indexPath : IndexPath) {}
    
    /// cell已经结束显示(需要在collectionView的代理里手动实现)
    open func didEndDisplaying(_ indexPath : IndexPath) {}
    
    /// cell通知代理的事件(在cell内部的事件,通过主动调用该方法,将事件传递给代理)
    open func cellCallDelegateEvent(_ cell : BaseCollectionViewCell? = nil, data : Any? = nil) {
        
        if let objectDelegate = delegate, objectDelegate.responds(to: #selector(objectDelegate.baseCollectionViewCell(_:event:))) {
            
            objectDelegate.baseCollectionViewCell(cell ?? self, event: data ?? adapter?.data)
        }
    }
    
    open class func sizeWithData(_ data : Any? = nil) -> CGSize { return CGSize.zero}
    
    /// cell直接获取适配器对象
    open class func adapter(_ reuseIdentifier : String? = nil,
                            data              : Any?    = nil,
                            size              : CGSize  = CGSize.zero,
                            info              : Any?    = nil) -> CollectionViewCellAdapter {
        
        return CollectionViewCellAdapter.init(reuseIdentifier : reuseIdentifier ?? "\(self.classForCoder())",
                                              data            : data,
                                              size            : size,
                                              info            : info)
    }
    
    /// 注册到collectionView
    open class func registerTo(_ collectionView : UICollectionView, reuseIdentifier : String? = nil) {
        
        collectionView.register(self.classForCoder(),
                                forCellWithReuseIdentifier: reuseIdentifier ?? "\(self.classForCoder())")
    }
}

// MARK: extension UICollectionView

public extension UICollectionView {
    
    func dequeueCellAndLoad(_ adapter      : CollectionViewCellAdapter,
                            indexPath      : IndexPath,
                            collectionView : UICollectionView?               = nil,
                            delegate       : BaseCollectionViewCellDelegate? = nil,
                            controller     : UIViewController?               = nil) -> BaseCollectionViewCell {
        
        let cell         = self.dequeueReusableCell(withReuseIdentifier: adapter.reuseIdentifier!, for: indexPath) as! BaseCollectionViewCell
        cell.adapter        = adapter
        cell.indexPath      = indexPath
        cell.collectionView = collectionView
        cell.delegate       = delegate
        cell.controller     = controller
        cell.loadContent()
        
        return cell
    }
    
    func baseCollectionViewSelectedEventWithIndexPath(_ indexPath : IndexPath) {
        
        let cell = self.cellForItem(at: indexPath) as! BaseCollectionViewCell
        
        // 检测cell的类型是否为BaseCollectionViewCell类型
        guard cell.isKind(of: BaseCollectionViewCell.classForCoder()) == true else {
            
            return
        }
        
        cell.cellSelectedEvent()
    }
}
