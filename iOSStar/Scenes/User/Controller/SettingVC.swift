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
    override func viewDidLoad() {
        super.viewDidLoad()
  
        title = "设置"
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        self.tableView.backgroundColor = UIColor.colorFromRGB(0xFAFAFA)
        let view = UIView.init()
        view.backgroundColor = UIColor.colorFromRGB(0xFAFAFA)
        self.tableView.tableFooterView = view
       
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
        if indexPath.row == 1{
            let vc = BaseWebVC()
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
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
