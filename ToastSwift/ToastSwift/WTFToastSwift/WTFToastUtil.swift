//
//  WTFToastUtil.swift
//  CooleadPowerSwift
//
//  Created by JsutCompThin on 2018/9/13.
//  Copyright © 2018年 JustCopmThin. All rights reserved.
//

import UIKit

class WTFToastUtil: Operation {
    private var _executing = false
    private var _finished = false
    
    override open var isExecuting: Bool {
        get {
            return _executing;
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            self._executing = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
   override open var isFinished: Bool {
        get{
            return self._finished
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            self._finished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    var textToastView = WTFTextToast()
    
    var textMessage : String? {
        get{
            return textToastView.text
        }
        set {
            textToastView.text = newValue
        }
    }
    
    var imageToastView = WTFImageToastView()
    var imageMessage : String? {
        get {
            return imageToastView.text
        }
        set {
            imageToastView.text = newValue
        }
    }
    
    var animationFromValue: CGFloat = 1
    var superComponent: UIView = UIView()
    var showSuccessToast: Bool?  // nil 不展示带图片的toast  true和false都展示imageToastView
    var duration: CGFloat = 2.5  // 默认展示2秒
    var position = ToastPosition.middle
    
    init(message : String?  , onView : UIView? = nil, success : Bool? , duration: CGFloat? , position : ToastPosition? = .middle) {
        superComponent = onView ?? ( (UIApplication.shared).keyWindow ?? UIView() )
        showSuccessToast = success
        self.duration = duration ?? 2.5
        self.position = position ?? ToastPosition.middle
        
        super.init()
        if self.showSuccessToast == nil {
            self.textMessage = message ?? ""
            self.textToastView.position = self.position
        } else {
            self.imageMessage = message ?? ""
            self.imageToastView.position = self.position
        }
        
        WTFToastManager.shared.add(self)
    }
    
    override func start() {
        let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
        guard isRunnable else {
            return
        }
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                [weak self] in self?.start()
            }
            return
        }
        main()
    }
    
    override func cancel() {
        super.cancel()
        self.dismiss()
    }
    
    override func main() {
        isExecuting = true
        
        DispatchQueue.main.async {
            
            if self.showSuccessToast == nil {
                
                self.textToastView.titleLabel.textColor = WTFToastManager.shared.texColor
                self.textToastView.titleLabel.font = WTFToastManager.shared.textFont
                self.textToastView.backgroundColor = WTFToastManager.shared.bgColor
                self.textToastView.layer.cornerRadius = WTFToastManager.shared.cornerRadius
                
                self.textToastView .setNeedsLayout()
                self.superComponent.addSubview(self.textToastView)
            } else {
                self.imageToastView.titleLabel.textColor = WTFToastManager.shared.texColor
                self.imageToastView.titleLabel.font = WTFToastManager.shared.textFont
                self.imageToastView.backgroundColor = WTFToastManager.shared.bgColor
                self.imageToastView.layer.cornerRadius = WTFToastManager.shared.cornerRadius
                
                self.imageToastView .setNeedsLayout()
                self.superComponent.addSubview(self.imageToastView)
                
                if self.showSuccessToast == true {
                    self.imageToastView.iconView.image = WTFToastManager.shared.successImage
                } else {
                    self.imageToastView.iconView.image = WTFToastManager.shared.errorImage
                }
            }
            
            let shakeAnimation = CABasicAnimation.init(keyPath: "transform.scale")
            shakeAnimation.duration = 0.2
            shakeAnimation.fromValue = self.animationFromValue
            shakeAnimation.toValue = 1.1
            shakeAnimation.autoreverses = true
            shakeAnimation.delegate = self
            
            if self.showSuccessToast == nil {
                self.textToastView.layer.add(shakeAnimation, forKey: nil)
            } else {
                self.imageToastView.layer.add(shakeAnimation, forKey: nil)
            }
        }
    }
}


extension WTFToastUtil : CAAnimationDelegate{
    func animationDidStop(_ animation :CAAnimation, finished flag : Bool)  {
        if flag {
            UIView.animate(withDuration: 0.5, delay: TimeInterval(self.duration), options: UIViewAnimationOptions.allowUserInteraction, animations: {
                if self.showSuccessToast == nil {
                    self.textToastView.alpha = 0
                } else {
                    self.imageToastView.alpha = 0
                }
            }) { (finish) in
                self.dismiss()
            }
        }
    }
    
    func dismiss()  {
        textToastView.removeFromSuperview()
        imageToastView.removeFromSuperview()
        finish()
    }
    
    func finish()  {
        self.isExecuting = false
        self.isFinished = true
        
        if WTFToastManager.shared.supportQuene == false {
            WTFToastManager.shared.cancelAll()
        }
    }
}
