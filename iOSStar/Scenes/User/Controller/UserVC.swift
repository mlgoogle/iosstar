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

class UserVC: BaseCustomTableViewController ,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate {
    
    var sessionUnreadCount : Int = 0
    // 资产总额
    var  account : UILabel?
    // 昵称
    var  nickNameLabel : UILabel?
    // 累计收益
    var  Accumulated : UILabel?
    // 成功邀请
    var invitation : UILabel?
    // icon
    var iconImageView : UIImageView?
    // 已购明星数量
    var buyStarCountLabel : UILabel?
    var PromotionUrl = ""
    // 名字数组
    var titltArry = [""]
    //messagebtn
    @IBOutlet var message: UIButton!
    var responseData: UserInfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        titltArry = ["我的钱包","我约的明星","客服中心","常见问题","通用设置"]
        titltArry = ["交易明细","我的钱包","我预约的明星","客服中心","通用设置"]
        self.tableView.reloadData()
        
        LoginYunxin()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccess(_:)), name: Notification.Name(rawValue:AppConst.loginSuccess), object: nil)
        NIMSDK.shared().systemNotificationManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginNotice), name: Notification.Name(rawValue:AppConst.loginSuccessNotice), object: nil)
        
        
        
        AppAPIHelper.user().configRequest(param_code: "PROMOTION_URL", complete: { (response) in
            if let model = response as? ConfigReusltValue {
                self.PromotionUrl = model.param_value
            }
            
        }) { (error) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        LoginSuccessNotice()
    }
    func LoginNotice(){
        
        AppAPIHelper.user().configRequest(param_code: "PROMOTION_URL", complete: { (response) in
            if let model = response as? ConfigReusltValue {
                self.PromotionUrl = model.param_value
            }
            
        }) { (error) in
            
        }
        self.LoginYunxin()
        LoginSuccessNotice()
        
    }
    // MARK:- 已购明星数量
    func LoginSuccessNotice() {
        
        NIMSDK.shared().systemNotificationManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
        AppAPIHelper.user().requestBuyStarCount(complete: { (result) in
            
            if let model = result {
                let objectModle = model as! [String : Int]
                if objectModle["amount"] != 0{
                    self.buyStarCountLabel?.text = String.init(format:"%d",objectModle["amount"]!)
                } else {
                    self.buyStarCountLabel?.text = "0"
                }
            }
            
        }) { (error) in
            
        }
        
        let model = CommissionModelequestModel()
        
        AppAPIHelper.user().getcommission(requestModel: model, complete: { (result) in
            if let model = result {
                let objectModle = model as! CommissionModel
                if  objectModle.result == 1{
                    self.Accumulated?.text = "\(objectModle.total_amount)"
                    self.invitation?.text = "\(objectModle.total_num)"
                } else {
                    
                }
            }
            
        }) { (errro) in
            
        }
        
        
        updateUserInfo()
    }
    
    func updateUserInfo() {
        getUserInfo { (result) in
            if let response = result{
                
                let model =   response as! UserInfoModel
                
                self.responseData = model
                self.account?.text =  String.init(format: "%.2f", model.balance)
                if model.nick_name == "" {
                    let nameUid = StarUserModel.getCurrentUser()?.userinfo?.id
                    let stringUid = String.init(format: "%d", nameUid!)
                    self.nickNameLabel?.text = "星享时光用户" + stringUid
                } else  {
                    self.nickNameLabel?.text = model.nick_name
                }
                UserDefaults.standard.setValue(model.head_url, forKeyPath: "head_url")
                self.iconImageView?.kf.setImage(with: URL(string: model.head_url), placeholder: UIImage(named:"avatar_team"), options: nil, progressBlock: nil, completionHandler: nil)
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    //MARK:- Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1 : (section == 1 ? 5 : (section == 2 ? 1 : (section == 3 ? 1 : 3 ) ))
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 10 : (section == 3 ? 10 : (section == 1 ? 10 : 0.0001))
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  0.01
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 340: 40
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        if indexPath.section == 0{
            account = cell.balance
            nickNameLabel = cell.nickNameLabel
            iconImageView = cell.iconImageView
            buyStarCountLabel = cell.buyStarLabel
            message = cell.message
            cell.doinvite.addTarget(self, action: #selector(showQrcode), for: .touchUpInside)
            refreshSessionBadge()
            invitation =    cell.total_num
            Accumulated =    cell.total_amount
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
    func showQrcode(){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "QrcodeVC") as? QrcodeVC
        vc?.modalPresentationStyle = .custom
        vc?.urlStr = PromotionUrl
        vc?.modalTransitionStyle = .crossDissolve
        present(vc!, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            //进入个人中心
            if indexPath.row == 0{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "UserInfoVC")
                // (UserInfoVC as! vc).us = self.responseData
                let userInfoVc = vc as! UserInfoVC
                userInfoVc.userInfoData = self.responseData
                self.navigationController?.pushViewController(userInfoVc, animated: true)
            }
            
        }
        //AllOrderViewController
        if indexPath.section == 1{
            if indexPath.row == 0{
                
                let vc = UIStoryboard.init(name: "Deal", bundle: nil).instantiateViewController(withIdentifier: "DealDetailViewController") as! DealDetailViewController
                vc.showNav  = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            //GetOrderStarsVC 我的钱包
            if indexPath.row == 1{
                
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "WealthVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            //GetOrderStarsVC 预约明星列表
            if indexPath.row == 2{
                
                toReservationStar()
                
            }
            //CustomerServiceVC
            if indexPath.row == 3{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "CustomerServiceVC")
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
    
    // MARK:- 我预约的明星
    func toReservationStar() {
        
        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "GetOrderStarsVC")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- 输入邀请码
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
    
    @IBAction func pushMessage(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Exchange", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ExchangeViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension UserVC{
    func LoginSuccess(_ LoginSuccess : NSNotification){
        
        NIMSDK.shared().systemNotificationManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
        
        print("未读消息条数====\(self.sessionUnreadCount)")
        self.refreshSessionBadge()
    }
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
        //       self.tabBar.showshowBadgeOnItemIndex(index: 2)
        self.sessionUnreadCount = totalUnreadCount
        self.refreshSessionBadge()
    }
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        self.sessionUnreadCount = totalUnreadCount
        self.refreshSessionBadge()
        //         self.tabBar.showshowBadgeOnItemIndex(index: 2)
    }
    
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        // self.tabBar.hideBadgeOnItemIndex(index: 2)
        self.sessionUnreadCount = totalUnreadCount;
        self.refreshSessionBadge()
        
    }
    
    func allMessagesDeleted() {
        // self.tabBar.hideBadgeOnItemIndex(index: 2)
        self.sessionUnreadCount = 0
        self.refreshSessionBadge()
    }
    func refreshSessionBadge() {
        if self.sessionUnreadCount == 0 {
            self.message.setImage(UIImage.init(named: "messagenotip"), for: .normal)
        } else {
            self.message.setImage(UIImage.init(named: "messagetip"), for: .normal)
        }
    }
    
    func LoginYunxin(){
        
        //        SVProgressHUD.showErrorMessage(ErrorMessage: "失败", ForDuration: 2.0, completion: nil)
        if checkLogin(){
            let registerWYIMRequestModel = RegisterWYIMRequestModel()
            registerWYIMRequestModel.name_value = UserDefaults.standard.object(forKey: "phone") as? String  ?? "123"
            registerWYIMRequestModel.phone = UserDefaults.standard.object(forKey: "phone") as? String ?? "123"
            registerWYIMRequestModel.uid = Int(StarUserModel.getCurrentUser()?.id ?? 0)
            
            print( "====  \(registerWYIMRequestModel)" )
            
            AppAPIHelper.login().registWYIM(model: registerWYIMRequestModel, complete: { (result) in
                if let datadic = result as? Dictionary<String,String> {
                    
                    let phone = UserDefaults.standard.object(forKey: "phone") as! String
                    let token = (datadic["token_value"]!)
                    
                    NIMSDK.shared().loginManager.login(phone, token: token, completion: { (error) in
                        if (error == nil) {
                            
                            NIMSDK.shared().systemNotificationManager.add(self)
                            NIMSDK.shared().conversationManager.add(self)
                            self.sessionUnreadCount = NIMSDK.shared().conversationManager.allUnreadCount()
                            
                            print("未读消息条数====\(self.sessionUnreadCount)")
                        }
                    })
                }
            }) { (error) in
                
            }
        }
    }
}
