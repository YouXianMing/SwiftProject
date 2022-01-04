//
//  PlaceholderImageViewController.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2021/12/30.
//

import UIKit

class PlaceholderImageViewController: NormalTitleViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "PlaceholderImageView"

        do {
            
            let view_1         = PlaceholderImageView.labelType()
            view_1.frame       = CGRect(x: 0, y: 100, width: 200, height: 100)
            view_1.contentMode = .scaleAspectFit
            view_1.urlString   = "https://upload-images.jianshu.io/upload_images/13277235-84bf1a3ee48b1260"
            contentView.addSubview(view_1)
        }
        
        do {
            
            let view_2         = PlaceholderImageView.imageType()
            view_2.frame       = CGRect(x: 0, y: 200, width: 300, height: 300)
            view_2.contentMode = .scaleAspectFit
            view_2.urlString   = "https://upload-images.jianshu.io/upload_images/13277235-84bf1a3ee48b1260"
            contentView.addSubview(view_2)
        }
        
        do {
            
            let view_3         = PlaceholderImageView.tilesType()
            view_3.contentMode = .scaleAspectFit
            view_3.urlString   = "https://upload-images.jianshu.io/upload_images/13277235-84bf1a3ee48b1260"
            contentView.addSubview(view_3)
            
            view_3.snp.makeConstraints { make in
                
                make.left.right.top.equalToSuperview()
                make.height.equalTo(100)
            }
        }
    }
}
