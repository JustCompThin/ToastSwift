//
//  WTFImageToastView.swift
//  CooleadPowerSwift
//
//  Created by coolead on 2018/9/13.
//  Copyright © 2018年 coolead. All rights reserved.
//

import UIKit

class WTFImageToastView: WTFTextToast {

    lazy var iconView : UIImageView = {
        let icon = UIImageView.init(frame: CGRect.zero)
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.iconView)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let currentFrame = frame
        frame = CGRect(x: currentFrame.origin.x - 30, y: currentFrame.origin.y, width: currentFrame.width + 30, height: currentFrame.height)
        titleLabel.frame = CGRect(x: 45, y: 15, width: currentFrame.width - 30, height: currentFrame.height - 30)
        iconView.frame = CGRect.init(x: 2 + 14, y: 0.5*(self.frame.height - 20), width: 20, height:  20)
    }
}
