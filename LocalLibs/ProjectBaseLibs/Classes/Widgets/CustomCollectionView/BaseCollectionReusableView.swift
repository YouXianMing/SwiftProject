//
//  BaseCollectionReusableView.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

@objc public protocol BaseCollectionReusableViewDelegate : NSObjectProtocol {
    
    func baseCollectionReusableView(_ headerFooterView: BaseCollectionReusableView?, event: Any?)
}

open class BaseCollectionReusableView: UICollectionReusableView {
    
    open weak var delegate       : BaseCollectionReusableViewDelegate?
    open weak var adapter        : CollectionReusableViewAdapter?
    open weak var collectionView : UICollectionView?
    open weak var controller     : UIViewController?
    open var indexPath           : IndexPath?
    
    open class func sizeWithData(_ data : Any? = nil) -> CGSize { return CGSize.zero}
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupReusableView()
        buildSubviews()
    }
    
    /// 基本设置
    open func setupReusableView() {}
    
    /// 构建子views
    open func buildSubviews() {}
    
    /// 加载数据
    open func loadContent() {}
    
    /// reusableView将要显示(需要在collectionView的代理里手动实现)
    open func willDisplay(_ indexPath : IndexPath) {}
    
    /// reusableView已经结束显示(需要在collectionView的代理里手动实现)
    open func didEndDisplaying(_ indexPath : IndexPath) {}
    
    /// reusableView通知代理的事件(在reusableView内部的事件,通过主动调用该方法,将事件传递给代理)
    open func collectionReusableViewCallDelegateEvent(_ reusableView : BaseCollectionReusableView? = nil, data : Any? = nil) {
        
        if let objectDelegate = delegate,
           objectDelegate.responds(to: #selector(objectDelegate.baseCollectionReusableView(_:event:))) {
            
            objectDelegate.baseCollectionReusableView(reusableView ?? self, event: data ?? adapter?.data)
        }
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    /// cell直接获取适配器对象
    open class func adapter(_ reuseIdentifier : String? = nil,
                            elementKind       : String,
                            data              : Any?    = nil,
                            referenceSize     : CGSize,
                            info              : Any?    = nil) -> CollectionReusableViewAdapter {
        
        return CollectionReusableViewAdapter.init(reuseIdentifier : reuseIdentifier ?? "\(self.classForCoder())",
                                                  elementKind     : elementKind,
                                                  data            : data,
                                                  referenceSize   : referenceSize,
                                                  info            : info)
    }
    
    open class func headerAdapter(_ reuseIdentifier : String? = nil,
                                  data              : Any?    = nil,
                                  referenceSize     : CGSize,
                                  info              : Any?    = nil) -> CollectionReusableViewAdapter {
        
        return adapter(reuseIdentifier,
                       elementKind: UICollectionView.elementKindSectionHeader,
                       data: data,
                       referenceSize: referenceSize,
                       info: info)
    }
    
    open class func footerAdapter(_ reuseIdentifier : String? = nil,
                                  data              : Any?    = nil,
                                  referenceSize     : CGSize,
                                  info              : Any?    = nil) -> CollectionReusableViewAdapter {
        
        return adapter(reuseIdentifier,
                       elementKind: UICollectionView.elementKindSectionFooter,
                       data: data,
                       referenceSize: referenceSize,
                       info: info)
    }
    
    /// 注册到collectionView
    open class func registerTo(_ collectionView           : UICollectionView,
                               reuseIdentifier            : String? = nil,
                               forSupplementaryViewOfKind : String) {
        
        collectionView.register(self.classForCoder(),
                                forSupplementaryViewOfKind: forSupplementaryViewOfKind,
                                withReuseIdentifier: reuseIdentifier ?? "\(self.classForCoder())")
    }
    
    /// 注册到collectionView
    open class func headerRegisterTo(_ collectionView : UICollectionView, reuseIdentifier : String? = nil) {
        
        registerTo(collectionView,
                   reuseIdentifier: reuseIdentifier,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    /// 注册到collectionView
    open class func footerRegisterTo(_ collectionView : UICollectionView, reuseIdentifier : String? = nil) {
        
        registerTo(collectionView,
                   reuseIdentifier: reuseIdentifier,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
    }
}

// MARK: extension UICollectionView

public extension UICollectionView {
    
    func dequeueReusableViewAndLoad(_ adapter      : CollectionReusableViewAdapter?,
                                    indexPath      : IndexPath,
                                    collectionView : UICollectionView?                   = nil,
                                    delegate       : BaseCollectionReusableViewDelegate? = nil,
                                    controller     : UIViewController?                   = nil) -> BaseCollectionReusableView {
        
        if let adapter = adapter {
            
            let view = self.dequeueReusableSupplementaryView(ofKind: adapter.elementKind!,
                                                             withReuseIdentifier: adapter.reuseIdentifier!,
                                                             for: indexPath) as! BaseCollectionReusableView
            view.adapter        = adapter
            view.indexPath      = indexPath
            view.collectionView = collectionView
            view.delegate       = delegate
            view.controller     = controller
            view.loadContent()
            return view
            
        } else {
            
            return BaseCollectionReusableView()
        }
    }
}
