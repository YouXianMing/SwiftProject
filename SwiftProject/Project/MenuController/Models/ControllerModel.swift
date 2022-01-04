//
//  ControllerModel.swift
//  ThirdLibsExample
//
//  Created by YouXianMing on 2022/1/1.
//

import UIKit

class ControllerModel: NSObject {

    var title           : String?
    var controllerClass : AnyClass?
    
     convenience init(title : String, controllerClass : AnyClass) {
        
        self.init()
        
        self.title           = title
        self.controllerClass = controllerClass
    }
}
