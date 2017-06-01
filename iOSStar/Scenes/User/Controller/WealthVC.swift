//
//  wealthVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class HeaderCell: UITableViewCell {
    
    
    @IBOutlet weak var balance: UILabel!
    @IBOutlet var market_cap: UILabel!
    
    @IBOutlet var total_amt: UILabel!
}
class WealthVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var needPwd : Int = 2
    var setPwd : Bool = true
    var  market_cap : UILabel?
    var total_amt : UILabel?
    var balance : UILabel?
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView.init()
        view.backgroundColor = UIColor.clear
        title = "我的资产"
        self.tableView.tableFooterView = view
        //        self.getUserInfo { (result) in
        //
        //        }
        //        self.getUserrealmInfo { (result) in
        //            if let model = result{
        //                let object =  model as! [String : AnyObject]
        //
        //                if object["realname"] as! String == ""{
        //                self.setPwd = true
        //                }
        //            }
        //
        //        }
        //
        
        //        self.getUserInfo { (result) in
        //
        //            if let response = result{
        //                let object = response as! [String : AnyObject]
        //                self.balance?.text =  String.init(format: "%.2f", object["balance"] as! CVarArg)
        //                self.market_cap?.text = String.init(format: "%.2f", object["total_amt"] as! CVarArg)
        //                self.total_amt?.text = String.init(format: "%.2f", object["total_amt"] as! CVarArg)
        //                self.setPwd = object["is_setpwd"] as Int
        //
        //            }
        //
        //        }
    }
    func requestData() {
        AppAPIHelper.user().accountMoney(complete: { (result) in
            
        }) { (error ) in
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.getUserInfo { (result) in
            
            if let response = result{
                let object = response as! [String : AnyObject]
                self.balance?.text =  String.init(format: "%.2f", object["balance"] as! Double)
                self.market_cap?.text = String.init(format: "%.2f", object["total_amt"] as! Double)
                self.total_amt?.text = String.init(format: "%.2f", object["total_amt"] as! Double)
                self.needPwd = object["is_setpwd"] as! Int
                
            }
            
        }
    }
    @IBAction func doBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: tableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 280 : 44
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        if indexPath.section == 0{
            market_cap = cell.market_cap
            total_amt = cell.total_amt
            balance = cell.balance
            
            return cell
        }
        if indexPath.section == 1{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RechareCell")
                return cell!
            }
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawCell")
                return cell!
            }
            return cell
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
         
            if indexPath.row == 0{
                self.getUserrealmInfo { (result) in
                    if let model = result{
                        let object =  model as! [String : AnyObject]
                        
                        if object["realname"] as! String == ""{
                            let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "StatementVC")
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        else {
                            if self.needPwd == 0{
                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "RechargeVC")
                                self.navigationController?.pushViewController(vc, animated: true)
                            }// 设置交易密码
                            else{
                                
                                let alertVc = AlertViewController()
                                alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                                    titleLabelText: "还没有设置交易密码",
                                                    subTitleText: "去设置才可以进行交易",
                                                    completeButtonTitle: "确定") { (completeButton) in
                                                        alertVc.dismissAlertVc()
                                                        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC")
                                                        self.navigationController?.pushViewController(vc, animated: true )
                                                        return
                                }
                                

                            }
                        }
                        }
                    }
               
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.0001
    }
}
