//
//  ContactListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ContactListViewController: BaseCustomPageListTableViewController, OEZTableViewDelegate, NIMConversationManagerDelegate ,NIMLoginManagerDelegate{
    
    @IBOutlet var nodaView: UIView!
    // 网络请求判断是否实名认证
    var setRealm : Bool = false
    var dataList = [StarInfoModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "名人通讯录"
        nodaView.isHidden = true
        tableView.backgroundColor = UIColor.clear
        onlogin()
    }
    
    func onlogin(){
        NIMSDK.shared().conversationManager.add(self)
        NIMSDK.shared().loginManager.add(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didRequest(0)
    }
    
    override func didRequest(_ pageIndex: Int) {
        let requestModel = StarMailListRequestModel()
        requestModel.status = 1
        requestModel.startPos = (pageIndex - 1) * 10
        
        AppAPIHelper.user().requestStarMailList(requestModel: requestModel, complete: { [weak self](result) in
            if  let model  = result as? StarListModel{
                let unreadCountDic = self?.getUnreadDic()
                for info in model.depositsinfo!{
                    if let unreadCount = unreadCountDic?[info.faccid]{
                        info.unreadCount = unreadCount
                    }
                }
                self?.didRequestComplete( model.depositsinfo as AnyObject)
                if self?.dataSource?.count == 0{
                    self?.nodaView.isHidden = false
                }else{
                    self?.nodaView.isHidden = true
                    self?.nodaView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
                }
                self?.tableView.reloadData()
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
    
    func getUnreadDic() ->  [String: Int]{
        var sessionIdDic: [String: Int] = [:]
        if let sessions = NIMSDK.shared().conversationManager.allRecentSessions(){
            for session in sessions{
                if let sessionId = session.session?.sessionId{
                    sessionIdDic[sessionId] = session.unreadCount
                }
            }
        }
        return sessionIdDic
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let starInfoModel = self.dataSource?[indexPath.row] as! StarInfoModel
        let session = NIMSession(starInfoModel.faccid, type: .P2P)
        let vc = YDSSessionViewController.init(session: session)
        vc?.starcode = starInfoModel.starcode
        vc?.starname = starInfoModel.starname
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        if action == 3 {
            // // print((data as AnyObject).description)
            let starInfoModel = data as! StarInfoModel
            let session = NIMSession(starInfoModel.faccid, type: .P2P)
            let vc = YDSSessionViewController.init(session: session)
            vc?.starcode = starInfoModel.starcode
            vc?.starname = starInfoModel.starname
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        didRequest(0)
    }
    func onKick(_ code: NIMKickReason, clientType: NIMLoginClientType) {
        userLogout()
    }
}


