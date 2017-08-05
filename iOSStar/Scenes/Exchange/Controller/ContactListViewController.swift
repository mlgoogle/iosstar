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
        
        if NIMSDK.shared().conversationManager.allUnreadCount() != 0 {
            if NIMSDK.shared().conversationManager.allUnreadCount() >= 99 {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem(title: "99+", target: self, action: #selector(self.unReadCountClick))
            } else {
                let strCount = String.init(format: "%d", NIMSDK.shared().conversationManager.allUnreadCount())
                self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem(title: strCount, target: nil, action: #selector(self.unReadCountClick))
            }
        }
    }

//    }
//       self.doYunxin { (resut) in
//           }
    
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
                    self.nodaView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
                }
                self.tableView.reloadData()
            }
        }) { (error) in
            self.didRequestComplete(nil)
            if self.dataSource?.count == nil{
                self.nodaView.isHidden = false
            }else{
                self.nodaView.isHidden = true
                self.nodaView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
            }
        }


    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //StarInfoModel
        let starInfoModel = self.dataSource?[indexPath.row] as! StarInfoModel
        let session = NIMSession(starInfoModel.faccid, type: .P2P)
        let vc = YDSSessionViewController.init(session: session)
        vc?.starcode = starInfoModel.starcode
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        if action == 3 {
            // print((data as AnyObject).description)
            let starInfoModel = data as! StarInfoModel
            let session = NIMSession(starInfoModel.faccid, type: .P2P)
            let vc = YDSSessionViewController.init(session: session)
            vc?.starcode = starInfoModel.starcode
            vc?.starname = starInfoModel.starname
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}


