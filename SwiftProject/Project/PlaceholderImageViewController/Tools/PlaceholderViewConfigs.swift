//
//  PlaceholderViewConfigs.swift
//  SwiftProject
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit
import ProjectBaseLibs

/// label类型的占位图
class LabelTypePlaceholderViewConfig : BasePlaceholderViewConfig {
    
    override func placeholderViewStartAdjust(_ placeholderView: UIView) {
        
        if let label = placeholderView as? UILabel {
            
            label.backgroundColor = .gray
            label.text            = "Eano"
            label.textColor       = .white
            label.textAlignment   = .center
            label.font            = UIFont.systemFont(ofSize: 50, weight: .light)
        }
    }
}

/// 图片类型的占位图
class ImageTypeTypePlaceholderViewConfig : BasePlaceholderViewConfig {
    
    override func placeholderViewStartAdjust(_ placeholderView: UIView) {
        
        if let imageView = placeholderView as? UIImageView {
            
            imageView.image = UIImage(named: "placeHolder")
        }
    }
}

/// 贴纸类型的占位图
class TileImageTypeTypePlaceholderViewConfig : BasePlaceholderViewConfig {
    
    override func placeholderViewStartAdjust(_ placeholderView: UIView) {
        
        if let imageView = placeholderView as? UIImageView {
            
            imageView.image = UIImage(named: "placeHolder")?.resizableImage(withCapInsets: .zero, resizingMode: .tile)
        }
    }
}

extension PlaceholderImageView {
    
    /// 默认给定的墙纸类型
    class func tilesType() -> ImagePlaceholderImageView {
        
        return ImagePlaceholderImageView.init(config: TileImageTypeTypePlaceholderViewConfig())
    }
    
    /// 默认给定的图片类型
    class func imageType() -> ImagePlaceholderImageView {
        
        return ImagePlaceholderImageView.init(config: ImageTypeTypePlaceholderViewConfig())
    }
    
    /// 默认给定的图片类型
    class func labelType() -> LabelPlaceholderImageView {
        
        return LabelPlaceholderImageView.init(config: LabelTypePlaceholderViewConfig())
    }
}
