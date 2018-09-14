//
//  WTFScreenTool.swift
//  CooleadPowerSwift
//
//  Created by coolead on 2018/9/13.
//  Copyright © 2018年 coolead. All rights reserved.
//

import UIKit

typealias WTFScreenToolsClosure = (UIDeviceOrientation)->()

class WTFScreenTool: NSObject {
    static let share = WTFScreenTool()
    var screenClousure : WTFScreenToolsClosure?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func receiveNotification() {
        let orient = UIDevice.current.orientation
        
        guard self.screenClousure != nil else {
            return
        }
        
        switch orient {
        case .portrait:
             self.screenClousure!(.portrait)
            break
        case .portraitUpsideDown :
            self.screenClousure!(.portraitUpsideDown)
            break
        case .landscapeLeft :
            self.screenClousure!(.landscapeLeft)
            break
        case .landscapeRight :
            self.screenClousure!(.landscapeRight)
            break
        default:
            break
        }
    }
}
