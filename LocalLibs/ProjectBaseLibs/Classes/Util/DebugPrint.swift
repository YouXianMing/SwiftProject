//
//  DebugPrint.swift
//  SwiftProject
//
//  Created by YouXianMing on 2022/1/10.
//
//  https://newbedev.com/how-to-print-out-the-method-name-and-line-number-in-swift
//

import Foundation

public enum AppPrintLevel {
    case verbose
    case info
    case warning
    case error
}

/// print增强版
/// - Parameters:
///   - items: 打印的对象
///   - level: 打印级别,默认为info
///   - file: 所在文件
///   - funcName: 函数名字(只有level为verbose时有)
///   - line: print所在行
///   - column: print所在列(只有level为verbose时有)
public func appPrint(_ items  : Any,
                     level    : AppPrintLevel = .info,
                     file     : String        = #file,
                     funcName : String        = #function,
                     line     : Int           = #line,
                     column   : Int           = #column) {
    
#if DEBUG
    
    let className = file.components(separatedBy: "/").last
    var debugInfo = ""
    
    switch level {
        
    case .verbose:
        
        let d         = Date()
        let df        = DateFormatter()
        df.dateFormat = "y-MM-dd H:mm:ss.SSS"
        debugInfo     = "[🛠 \(className ?? "") \(line):\(column) \(funcName) \(df.string(from: d))]:"
        
    case .info:
        
        debugInfo = "[\(className ?? "") \(line)]:"
        
    case .warning:
        
        debugInfo = "[⚠️ \(className ?? "") \(line)]:"
        
    case .error:
        
        debugInfo = "[❌ \(className ?? "") \(line)]:"
    }
    
    print("\(debugInfo)\(items)")
    
#endif
}

/// debugPrint增强版
/// - Parameters:
///   - items: 打印的对象
///   - level: 打印级别,默认为info
///   - file: 所在文件
///   - funcName: 函数名字(只有level为verbose时有)
///   - line: print所在行
///   - column: print所在列(只有level为verbose时有)
public func appDebugPrint(_ items  : Any,
                          level    : AppPrintLevel = .info,
                          file     : String        = #file,
                          funcName : String        = #function,
                          line     : Int           = #line,
                          column   : Int           = #column) {
    
#if DEBUG
    
    let className = file.components(separatedBy: "/").last
    var debugInfo = ""
    
    switch level {
        
    case .verbose:
        
        let d         = Date()
        let df        = DateFormatter()
        df.dateFormat = "y-MM-dd H:mm:ss.SSS"
        debugInfo     = "[🛠 \(className ?? "") \(line):\(column) \(funcName) \(df.string(from: d))]:"
        
    case .info:
        
        debugInfo = "[\(className ?? "") \(line)]:"
        
    case .warning:
        
        debugInfo = "[⚠️ \(className ?? "") \(line)]:"
        
    case .error:
        
        debugInfo = "[❌ \(className ?? "") \(line)]:"
    }
    
    debugPrint("\(debugInfo)\(items)")
    
#endif
}
