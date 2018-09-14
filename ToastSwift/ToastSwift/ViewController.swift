//
//  ViewController.swift
//  ToastSwift
//
//  Created by JsutCompThin on 2018/9/14.
//  Copyright © 2018年 JustCopmThin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var source = [
            "成功, 无消息内容, 默认时长",
            "成功, 有消息内容, 默认时长",
            "成功, 有消息内容, 延时5秒",
            "失败, 无消息内容, 默认时长2.5秒",
            "失败, 有消息内容, 默认时长2.5秒",
            "失败, 有消息内容, 延时5秒",
            "成功, 消息内容很长很长, 长啊长, 长啊长, 长长长长长长长长长长长长长长"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView .register(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "reuseCell")
    }
    

}

extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        cell.textLabel?.text = source[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            WTFToast.showSuccess()
        case 1:
            WTFToast.showSuccess(message: source[indexPath.row])
        case 2:
            WTFToast.showSuccess(message: source[indexPath.row], delay: 5)
        case 3:
            WTFToast.showError()
        case 4:
            WTFToast.showError(message: source[indexPath.row])
        case 5:
            WTFToast.showError(message: source[indexPath.row], delay: 5)
        case 6:
            WTFToast.showSuccess(message: source[indexPath.row])
        default:
            break
        }
    }
}

