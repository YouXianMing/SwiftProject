//
//  ImagePlaceholderImageView.swift
//  BasePlaceholderViewConfig
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit
import Kingfisher

class ImagePlaceholderImageView: PlaceholderImageView {
    
    // MARK: 私有属性
    
    /// 图片url字符串
    fileprivate var imageURLStr : String?
    
    /// imageView
    fileprivate lazy var contentImageView : UIImageView = {
        
        return UIImageView()
    }()
    
    /// 图片类型的占位图
    fileprivate lazy var imagePlaceholderView : UIImageView = {
        
        return UIImageView()
    }()
    
    // MARK: 系统方法重写
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        addSubview(placeholderView)
        addSubview(contentImageView)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        placeholderView.frame  = bounds
        contentImageView.frame = bounds
        config?.superviewDidLayoutSubviews(placeholderView)
    }
    
    
    override var contentMode: UIView.ContentMode {
        
        set(newVal) {
            
            super.contentMode            = newVal
            contentImageView.contentMode = newVal
        }
        
        get { return super.contentMode}
    }
    
    // MARK: 重写父类方法
    
    override var placeholderView: UIView { get { return imagePlaceholderView}}
    
    override var urlString: String? {
        
        get { return imageURLStr}
        
        set(newVal) {
                        
            // 设置新值
            imageURLStr = newVal
            
            contentImageView.alpha = 0
            if (placeholderImageNeedHide == true) { placeholderView.alpha = 1}
            
            contentImageView.kf.setImage(with: URL(string: imageURLStr ?? "")) { [weak self] result in
                
                if let strongSelf = self {
                    
                    switch result {
                        
                    case .success(let value):
                        
                        // 读取图片加载的类型
                        switch value.cacheType {
                            
                        case .memory:
                            
                            // 内存中读取的图片不做动画
                            strongSelf.contentImageView.alpha = 1
                            if (strongSelf.placeholderImageNeedHide == true) { strongSelf.placeholderView.alpha  = 0}
                            
                            
                        case .disk:
                            fallthrough
                        case .none:
                            
                            // 硬盘或者下载下来的图片做动画效果
                            UIView.animate(withDuration: 0.15) {
                                
                                strongSelf.contentImageView.alpha = 1
                                if (strongSelf.placeholderImageNeedHide == true) { strongSelf.placeholderView.alpha  = 0}
                            }
                        }
                        
                    case .failure(_):
                        
                        strongSelf.placeholderView.alpha = 1
                    }
                }
            }
        }
    }
}
