//
//  WTFToastManager.swift
//  CooleadPowerSwift
//
//  Created by JsutCompThin on 2018/9/14.
//  Copyright © 2018年 JustCopmThin. All rights reserved.
//

import UIKit

public class WTFToastManager {
    public static let shared = WTFToastManager()
    
    public var successImage = WTFSourceManager.sourceImage(name: "wtf_success")!
    public var errorImage = WTFSourceManager.sourceImage(name: "wtf_error")!
    
    public var bgColor = UIColor.white
    public var texColor = UIColor.black
    public var textFont = UIFont.systemFont(ofSize: 16)
    public var cornerRadius : CGFloat = 5
    public var supportQuene : Bool = true
    
    private let quene : OperationQueue = {
        let quene = OperationQueue()
        quene.maxConcurrentOperationCount = 1
        return quene
    }()
    
    public func resetProps(){
        self.commonStatus()
    }
    
    func commonStatus() -> Void {
        bgColor = UIColor.white
        textFont = UIFont.systemFont(ofSize: 16)
        texColor = UIColor.black
        cornerRadius = 5
        supportQuene = true
        
        successImage = WTFSourceManager.sourceImage(name: "wtf_success")!
        errorImage = WTFSourceManager.sourceImage(name: "wtf_error")!
    }
    
    func add(_ toast : WTFToastUtil) -> Void {
        quene.addOperation(toast)
    }
    
    func cancelAll() -> Void {
        quene.cancelAllOperations()
    }
}
