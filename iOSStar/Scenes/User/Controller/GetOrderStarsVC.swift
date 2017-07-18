//
//  GetOrderStarsVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

class GetOrderStarsVC: BaseCustomPageListTableViewController,OEZTableViewDelegate {
    @IBOutlet var nodaView: UIView!
    //选中 当前选择的cell
    var seleNumber = 10000000
    //当前未选择的cell
    var unseleNumber = 10000000
    var domeet = true
    @IBOutlet var ownSecond: UIButton!
    @IBOutlet var orderStatus: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         ownSecond.backgroundColor = UIColor.init(hexString: "333333")
         title = "我预约的明星"
        self.nodaView.isHidden = true
       
    }
    override func isSections() -> Bool {
        return true
    }
    override func didRequest(_ pageIndex: Int) {
        
        if pageIndex == 1{
            self.dataSource?.removeAll()
            self.tableView.reloadData()
        }
        //约见的明细
        if domeet{
            let requestModel = StarMailListRequestModel()
            requestModel.status = 1
            requestModel.startPos = (pageIndex - 1) * 10
           
            AppAPIHelper.user().requestStarMailList(requestModel: requestModel, complete: { (result) in
                let Model : StarListModel = result as! StarListModel
                self.didRequestComplete( Model.depositsinfo as AnyObject)
                self.tableView.reloadData()
                if (self.dataSource?.count == 0){
                    self.nodaView.isHidden = false
                }else{
                    self.nodaView.isHidden = true
                }
            }) { (error ) in
                
                
                self.didRequestComplete(nil)
                if (self.dataSource?.count == nil || self.dataSource?.count == 0){
                    self.nodaView.isHidden = false
                }else{
                    self.nodaView.isHidden = true
                }
            }
        }
       //约见的情况
        else{
            let requestModel = StarMailOrderListRequestModel()
            requestModel.pos = (pageIndex - 1) * 10
            AppAPIHelper.user().requestOrderStarMailList(requestModel: requestModel, complete: { (result) in
                let Model  = result as! OrderStarListModel
                self.didRequestComplete( Model.list as AnyObject)
                self.tableView.reloadData()
                if (self.dataSource?.count == 0){
                    self.nodaView.isHidden = false
                }else{
                    self.nodaView.isHidden = true
                }
            }) { (error ) in
                self.didRequestComplete(nil)
                if (self.dataSource?.count == nil  || self.dataSource?.count == 0){
                    self.nodaView.isHidden = false
                }else{
                    self.nodaView.isHidden = true
                }
            }
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if domeet{
            if seleNumber == indexPath.section{
                return 160
            }
            if unseleNumber == indexPath.section{
                return 65
            }
          return 65
        }
        
        return 65
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
  
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource?.count  == nil ? 0 : (self.dataSource?.count)!
    }
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetOrderStarsVCCell") as! GetOrderStarsVCCell
        if domeet{
            let model = self.dataSource?[indexPath.section] as! StarInfoModel
            cell.update(model)
            cell.chatButton.transform = CGAffineTransform(rotationAngle: CGFloat(0));
            if seleNumber == indexPath.section{
            cell.chatButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
            }
            if unseleNumber == indexPath.section{
            cell.chatButton.transform = CGAffineTransform(rotationAngle: CGFloat(0));
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell") as! ContactListCell
            let model = self.dataSource?[indexPath.section] as! OrderStarListInfoModel
                    cell.update(model)
            cell.chatButton.isUserInteractionEnabled = false
            return cell
        }
    }
   func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
        //约见
        if action == 4 {
         let model = self.dataSource?[indexPath.section] as! StarInfoModel
         let modeldata = StarSortListModel()
            modeldata.name = model.starname
            modeldata.symbol = model.starcode
            let story = UIStoryboard.init(name: "Market", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "OrderStarViewController") as! OrderStarViewController
            vc.starInfo = modeldata
            self.navigationController?.pushViewController(vc, animated: true)
            return
       }
        //聊天
        if action == 5 {
            let model = self.dataSource?[indexPath.section] as! StarInfoModel
            let session = NIMSession( model.faccid, type: .P2P)
            let vc = YDSSessionViewController(session: session)
            vc?.starcode = model.starcode
            self.navigationController?.pushViewController(vc!, animated: true)
            self.tableView.reloadSections(IndexSet(integer: unseleNumber), with: .fade)
            return
        }
        if unseleNumber != 10000000{
             self.tableView.reloadSections(IndexSet(integer: unseleNumber), with: .fade)
        }
        if seleNumber == indexPath.section{
             unseleNumber = seleNumber
           
            seleNumber = 10000000
            self.tableView.reloadSections(IndexSet(integer: unseleNumber), with: .fade)
            unseleNumber = 10000000
        }else{
            seleNumber = indexPath.section
            self.tableView.reloadSections(IndexSet(integer: seleNumber), with: .fade)
            
            unseleNumber = indexPath.section
        }
        
    }
     // MARK: -button点击事件
     //选中的状态
    @IBAction func orderStatus(_ sender: Any) {
        domeet = false
        seleNumber = 10000000
         unseleNumber = 10000000
         self.nodaView.isHidden = false
         self.tableView.reloadData()
        self.didRequest(1)
        ownSecond.backgroundColor = UIColor.clear
        orderStatus.backgroundColor = UIColor.init(hexString: "333333")
    }
    @IBAction func ownSecondInside(_ sender: Any) {
         domeet = true
         seleNumber = 10000000
         unseleNumber = 10000000
         self.nodaView.isHidden = false
         self.tableView.reloadData()
         self.didRequest(1)
        orderStatus.backgroundColor = UIColor.clear
        ownSecond.backgroundColor = UIColor.init(hexString: "333333")
    }


}
