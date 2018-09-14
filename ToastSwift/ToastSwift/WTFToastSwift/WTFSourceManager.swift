//
//  WTFSourceManager.swift
//  CooleadPowerSwift
//
//  Created by coolead on 2018/9/14.
//  Copyright © 2018年 coolead. All rights reserved.
//

import Foundation


class WTFSourceManager  {
    static func sourceBundle() -> Bundle {
        let path = Bundle.main.path(forResource: "WTFToast", ofType: "bundle")!
        return Bundle(path: path)!
    }
    
    static func sourceImage(name: String) -> UIImage?{
        let image = UIImage(named: name, in: sourceBundle(), compatibleWith: nil)
        return image
    }
}
