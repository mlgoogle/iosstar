//
//  SettingVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SettingVC: BaseTableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBOutlet var cache: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        title = "设置"
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        self.tableView.backgroundColor = UIColor.colorFromRGB(0xFAFAFA)
        let view = UIView.init()
        view.backgroundColor = UIColor.colorFromRGB(0xFAFAFA)
        self.tableView.tableFooterView = view
//        let number = fileSizeOfCache()
        cache.text =  "\(fileSizeOfCache())" + "M"
       
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        if section == 0 {
//            
//            return 21.0
//        } else {
//            return 0.01
//        }
//        
//    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 5 {
            
            logout()
            
            // userLogout()
            // _ = self.navigationController?.popToRootViewController(animated: true)
        }
        if indexPath.row == 3 {
            let story = UIStoryboard.init(name: "Login", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "ForgotPwdVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 0{
            let vc = BaseWebVC()
            vc.loadRequest = "http://www.baidu.com"
            vc.navtitle = "买卖规则"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2{
          clearCache()
          cache.text =  "\(fileSizeOfCache())" + "M"

        }
        if indexPath.row == 1{
            let vc = BaseWebVC()
            print(fileSizeOfCache())
            vc.loadRequest = "http://www.baidu.com"
            vc.navtitle = "关于我们"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - 注销账号
    func logout() {
        
        let alertController = UIAlertController(title: "提示", message: "你确定要退出吗？", preferredStyle:.alert)
        // 设置2个UIAlertAction
        let cancelAction = UIAlertAction(title: "取消", style:.cancel, handler: nil)
        let completeAction = UIAlertAction(title: "确定", style:.default) { (UIAlertAction) in
            // 退出
            self.userLogout()
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        // 添加
        alertController.addAction(cancelAction)
        alertController.addAction(completeAction)
        
        // 弹出
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
     
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
          
           
            let path = cachePath?.appending("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path!)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        
        return mm
    }
    func clearCache() {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    
                }
            }
        }
    }
}
