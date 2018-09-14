//
//  WTFTextToast.swift
//  CooleadPowerSwift
//
//  Created by JsutCompThin on 2018/9/13.
//  Copyright © 2018年 JustCopmThin. All rights reserved.
//

import UIKit

class WTFTextToast: UIView {
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    open var text :String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var position = ToastPosition.middle
    var keyboardHeight : CGFloat = 0
    
    var superWidth = kScreenWidth
    var superHeight = kScreenHeight
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        WTFScreenTool.share.screenClousure = { [weak self](orientation) in
            self?.setNeedsLayout()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(aNotification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension WTFTextToast {
    @objc func keyboardWillShow(aNotification: Notification) {
        let userInfo = aNotification.userInfo
        guard let info = userInfo else {
            return
        }
        
        let aValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue
        let keyboardFrame = aValue?.cgRectValue
        self.keyboardHeight = keyboardFrame?.size.height ?? 0
        self.setNeedsLayout()
    }

    @objc func keyboardWillHide(aNotification: Notification) {
        self.keyboardHeight = 0
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        superWidth = self.superview?.frame.size.width ?? kScreenWidth
        superHeight = self.superview?.frame.size.height ?? kScreenHeight
        
        let constraintSize = CGSize(width: superWidth - 50, height: CGFloat.greatestFiniteMagnitude)
        let textLabelSize = titleLabel.sizeThatFits(constraintSize)
        titleLabel.preferredMaxLayoutWidth = superWidth - 50
        
        var postionY = superHeight * 0.5
        if self.position == .top {
            postionY = 100
        }
        
        if self.position == .middle {
            postionY = (superHeight - textLabelSize.height) * 0.5
            
            if (keyboardHeight > 0 ) {
                postionY = superHeight - keyboardHeight - textLabelSize.height - 30
            }
        }
        
        if  self.position == .bottom {
            postionY = superHeight - 100 - textLabelSize.height
            
            if keyboardHeight > 0 {
                postionY = superHeight - keyboardHeight - textLabelSize.height - 30
            }
        }
        
        frame = CGRect.init(x: (superWidth - textLabelSize.width - 30) * 0.5, y: postionY, width: textLabelSize.width + 30, height: textLabelSize.height + 30)
        titleLabel.frame = CGRect(x: 15, y: 15, width: textLabelSize.width, height: textLabelSize.height)
    }
}
