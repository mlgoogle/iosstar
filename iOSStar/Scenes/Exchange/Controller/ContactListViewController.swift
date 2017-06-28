//
//  ContactListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ContactListViewController: BaseCustomPageListTableViewController, OEZTableViewDelegate {
    
    @IBOutlet var nodaView: UIView!
    // 网络请求判断是否实名认证
    var setRealm : Bool = false
    var dataList = [StarInfoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "名人通讯录"
        nodaView.isHidden = true
        onlogin()
    }
    
    func onlogin(){
        
       self.doYunxin { (resut) in
        
        if NIMSDK.shared().conversationManager.allUnreadCount() != 0 {
            if NIMSDK.shared().conversationManager.allUnreadCount() >= 99 {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem(title: "99+", target: self, action: #selector(self.unReadCountClick))
            } else {
                let strCount = String.init(format: "%d", NIMSDK.shared().conversationManager.allUnreadCount())
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem(title: strCount, target: nil, action: #selector(self.unReadCountClick))
                }
            }
        }
    }
    
    func unReadCountClick () {
        
    }
    
    override func didRequest(_ pageIndex: Int) {
        let requestModel = StarMailListRequestModel()
        requestModel.status = 1
        requestModel.startPos = (pageIndex - 1) * 10
        
        AppAPIHelper.user().requestStarMailList(requestModel: requestModel, complete: { (result) in
            if  let Model  = result as? StarListModel{
                self.didRequestComplete( Model.depositsinfo as AnyObject)
                if self.dataSource?.count == 0{
                    self.nodaView.isHidden = false
                }else{
                    self.nodaView.isHidden = true
                }
            }
        }) { (error) in
            self.didRequestComplete(nil)
            if self.dataSource?.count == nil{
                self.nodaView.isHidden = false
            }else{
                self.nodaView.isHidden = true
            }
        }


    }
    override func   LoginSuccess(){
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//        if setRealm == false {
//            self.getUserRealmInfo { (result) in
//                if let model = result{
//                    let object =  model as! [String : AnyObject]
//                    let alertVc = AlertViewController()
//                    if object["realname"] as! String == ""{
//                        
//                        alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
//                                            titleLabelText: "您还没有身份验证",
//                                            
//                                            subTitleText: "您需要进行身份验证,\n之后才可以进行明星时间交易",
//                                            
//                                            completeButtonTitle: "开 始 验 证") {[weak alertVc] (completeButton) in
//                                                alertVc?.dismissAlertVc()
//                                                
//                                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
//                                                self.navigationController?.pushViewController(vc, animated: true )
//                                                return
//                        }
//                        
//                    }else{
//                        self.setRealm = true
//                        let model = self.dataSource?[indexPath.row] as! StarInfoModel
//                        let session = NIMSession(model.accid, type: .P2P)
//                        print(model.accid)
//                        let vc = YDSSessionViewController(session: session)
//                        vc?.starcode = model.starcode
//                        self.navigationController?.pushViewController(vc!, animated: true)
//                    }
//                }
//            }
//        }
//        else{
        
//            let model = self.dataSource?[indexPath.row] as! StarInfoModel
//            let session = NIMSession(model.accid, type: .P2P)
//            print(model.accid)
//            let vc = YDSSessionViewController(session: session)
//            vc?.starcode = model.starcode
//            self.navigationController?.pushViewController(vc!, animated: true)
            
//        }
        
    
        //StarInfoModel
        let starInfoModel = self.dataSource?[indexPath.row] as! StarInfoModel
        let session = NIMSession(starInfoModel.faccid, type: .P2P)
        let vc = YDSSessionViewController(session: session)
        vc?.starcode = starInfoModel.starcode
        self.navigationController?.pushViewController(vc!, animated: true)
      

    }
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        
        if action == 3 {
            // print((data as AnyObject).description)
            let starInfoModel = data as! StarInfoModel
            let session = NIMSession(starInfoModel.faccid, type: .P2P)
            let vc = YDSSessionViewController(session: session)
            vc?.starcode = starInfoModel.starcode
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as! ContactListCell
//        
//        cell.update(dataSource?[indexPath.row])
//        return cell
//    }
    


}

//extension ContactListViewController: {
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
//        //StarInfoModel
//        let model = dataList[indexPath.row] 
//        
//        let session = NIMSession(model.faccid, type: .P2P)
//        let vc = NTESSessionViewController(session: session)
//        self.navigationController?.pushViewController(vc!, animated: true)
//        
////        let session = NIMSession("13569365931", type: .P2P)
////        let vc = NTESSessionViewController(session: session)
////        
////        self.navigationController?.pushViewController(vc!, animated: true)
//
////        let alertview : UIAlertController = UIAlertController.init(title: "请输入对方手机号", message: "对方手机号", preferredStyle: UIAlertControllerStyle.alert)
////        alertview.addTextField { (textField: UITextField!) in
////            textField.placeholder  = "请输入对方手机号"
////        }
////        let alertViewAction: UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
////            
////            let string  = alertview.textFields?[0].text
////            
////            if isTelNumber(num: string!){
////                
////                let session = NIMSession(string!, type: .P2P)
////                let vc = NTESSessionViewController(session: session)
////                
////                self.navigationController?.pushViewController(vc!, animated: true)
////            }
////            
////            
////            
////        })
////        let alertViewCancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
////        alertview.addAction(alertViewAction)
////        alertview.addAction(alertViewCancelAction)
////        self.present(alertview, animated:true , completion: nil)
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath) as! ContactListCell
//        
//        cell.update(dataList[indexPath.row])
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataList.count
//    }
//    
//}
