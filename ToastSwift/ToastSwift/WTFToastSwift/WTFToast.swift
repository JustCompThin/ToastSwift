//
//  WTFToast.swift
//  CooleadPowerSwift
//
//  Created by JsutCompThin on 2018/9/13.
//  Copyright © 2018年 JustCopmThin. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

public enum ToastPosition {
    case top
    case middle
    case bottom
}

public class WTFToast: NSObject {
    static func show(message : String , onView : UIView? = nil, success : Bool? = nil , duration: CGFloat? = nil, position : ToastPosition? = .middle){
        _ = WTFToastUtil.init(message: message, onView: onView, success: success, duration: duration, position: position)
    }
    
    static func showError(){
        _ = WTFToastUtil.init(message: nil, success: false, duration: nil)
    }
    
    static func showError(message : String) {
        _ = WTFToastUtil.init(message: message, success: false, duration: nil)
    }
    
    static func showError(delay: CGFloat) {
        _ = WTFToastUtil.init(message: nil, success: false, duration: delay)
    }
    
    static func showError(message :String , delay : CGFloat) {
        _ = WTFToastUtil.init(message: message , success: false, duration: delay)
    }
    
    static func showSuccess(){
        _ = WTFToastUtil.init(message: nil, success: true, duration: nil)
    }
    
    static func showSuccess(message : String) {
        _ = WTFToastUtil.init(message: message, success: true, duration: nil)
    }
    
    static func showSuccess(delay: CGFloat) {
        _ = WTFToastUtil.init(message: nil, success: true, duration: delay)
    }
    
    static func showSuccess(message :String , delay : CGFloat) {
        _ = WTFToastUtil.init(message: message , success: true, duration: delay)
    }
}
