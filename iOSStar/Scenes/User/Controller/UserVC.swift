//
//  UserVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet var version: UILabel!
    
}

class UserVC: BaseCustomTableViewController  {

    // 资产总额
    var  account : UILabel?
    
    // 昵称
    var  nickNameLabel : UILabel?
    // 名字数组
    var titltArry = [""]
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        titltArry = ["我的钱包","我预约的明星","客服中心","常见问题","通用设置"]
        self.tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccessNotice), name: Notification.Name(rawValue:AppConst.loginSuccessNotice), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        LoginSuccessNotice()
    }
    
    func LoginSuccessNotice() {
        
        self.getUserInfo { (result) in
            
            if let response = result{
                
                let model =   response as! UserInfoModel
                
                self.account?.text =  String.init(format: "%.2f", model.balance)
                self.nickNameLabel?.text = UserDefaults.standard.object(forKey: "phone") as? String
            }
            
        }
        
    }
    
    // MARK: Table view data source
     override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1 : (section == 1 ? 5 : (section == 2 ? 1 : (section == 3 ? 1 : 3 ) ))
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 20 : (section == 3 ? 20 : 0.001)
      
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return  0.01
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 260: 44
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        if indexPath.section == 0{
          
            account = cell.balance
            nickNameLabel = cell.nicknameLabel
           return cell
        }else if indexPath.section == 2{
            
          let cell  = tableView.dequeueReusableCell(withIdentifier: "recommandCell")
            
            return cell!
        }else if indexPath.section == 3{
            
            let cell  = tableView.dequeueReusableCell(withIdentifier: "versionCode") as! TitleCell
            
            cell.contentView.backgroundColor = UIColor.clear
             cell.version.text = "版本号" + " " + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!
            return cell
        }
        else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "titleCell") as! TitleCell
            cell.titleLb.text = titltArry[indexPath.row]
            return cell
        }
      

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            //进入个人中心
            if indexPath.row == 0{
              let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "UserInfoVC")
              self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        if indexPath.section == 1{
        
            //GetOrderStarsVC 我的钱包
            if indexPath.row == 0{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "WealthVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //GetOrderStarsVC 预约明星列表
            if indexPath.row == 1{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "GetOrderStarsVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //CustomerServiceVC
            if indexPath.row == 2{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "CustomerServiceVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //CustomerServiceVC 客服中心
            if indexPath.row == 3{
                let vc = BaseWebVC()
                vc.loadRequest = "http://www.baidu.com"
                vc.navtitle = "常见问题"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 4 {
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "SettingVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        if indexPath.section == 2{
        
            showAlertView()
        }
        
    }
    //MARK: 输入邀请码
    func showAlertView(){
    
        let alertview : UIAlertController = UIAlertController.init(title: "请输入邀请码", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alertview.addTextField { (textField: UITextField!) in
                    textField.placeholder  = "请输入邀请码"
                    textField.keyboardType = .numberPad
                }
                let alertViewAction: UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
        
                    let string  = alertview.textFields?[0].text
        
                    if isTelNumber(num: string!){
        
                    }
                })
                let alertViewCancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                alertview.addAction(alertViewAction)
                alertview.addAction(alertViewCancelAction)
                self.present(alertview, animated:true , completion: nil)
    }
   
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi : UIView = UIView.init()
        vi.backgroundColor = UIColor.clear
        
        return vi
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vi : UIView = UIView.init()

        vi.backgroundColor = UIColor.clear
       return vi
    }
   
}
