//
//  NormalTitleViewController.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2021/12/31.
//

import UIKit

class NormalTitleViewController: LayoutBaseViewController {

    /// titleContentView
    lazy var titleContentView : UIView = { return UIView()}()
    
    /// 返回按钮
    lazy var backButton : UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("返回", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.blue.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(self, action: #selector(popEvent), for: .touchUpInside)
        
        return button
    }()
    
    /// 标题
    lazy var titleLabel : UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor     = .black
        
        return label
    }()
    
    /// 线条
    lazy var line : UIView = {
        
        let line = UIView()
        line.backgroundColor = .gray.withAlphaComponent(0.15)
        return line
    }()
    
    override var title: String? {
        
        set(newVal) {
            
            super.title     = newVal
            titleLabel.text = newVal
        }
        
        get { return super.title}
    }
    
    override func buildBaseViews() {
        
        super.buildBaseViews()
        
        if (Self.baseViewsUseAutoLayout()) {
            
            titleView.addSubview(titleContentView)
            titleContentView.snp.makeConstraints { make in
                
                make.left.right.bottom.equalToSuperview()
                make.top.equalToSuperview().offset(Screen.statusBarHeight)
            }
            
            titleContentView.addSubview(backButton)
            backButton.snp.makeConstraints { make in
                
                make.left.bottom.top.equalToSuperview()
                make.width.equalTo(70)
            }
            
            titleContentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                
                make.top.bottom.equalToSuperview()
                make.left.equalToSuperview().offset(70)
                make.right.equalToSuperview().offset(-70)
            }
            
            titleContentView.addSubview(line)
            line.snp.makeConstraints { make in
                
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
            
        } else {
            
            titleView.addSubview(titleContentView)
            titleContentView.addSubview(backButton)
            titleContentView.addSubview(titleLabel)
            titleContentView.addSubview(line)
            
            titleContentView.frame = CGRect(x: 0, y: Screen.statusBarHeight, width: Screen.width, height: titleView.height - Screen.statusBarHeight)
            backButton.frame       = CGRect(x: 0, y: 0, width: 70, height: titleContentView.height)
            titleLabel.frame       = CGRect(x: 70, y: 0, width: titleContentView.width - 70 * 2, height: titleContentView.height)
            line.frame             = CGRect(x: 0, y: titleContentView.height - 1, width: Screen.width, height: 1)
        }
    }
}
