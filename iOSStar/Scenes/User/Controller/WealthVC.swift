//
//  wealthVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class HeaderCell: UITableViewCell {
    
    // 星享币
    @IBOutlet weak var balance: UILabel!
    // 持有市值
    @IBOutlet var market_cap: UILabel!
    // 可用余额
    @IBOutlet var total_amt: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var buyStarLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
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
        _ = navigationController?.popViewController(animated: true)
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
                
//                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "RechargeVC")
//                self.navigationController?.pushViewController(vc, animated: true)
//                return
                
                self.getUserrealmInfo { (result) in
                    if let model = result{
                        let object =  model as! [String : AnyObject]
                        
                        if object["realname"] as! String == ""{
                            let alertVc = AlertViewController()
                            alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                                titleLabelText: "您还没有身份验证",

                                                subTitleText: "您需要进行身份验证,\n之后才可以进行明星时间交易",
                                                completeButtonTitle: "开 始 验 证") {[weak alertVc] (completeButton) in
                                                    alertVc?.dismissAlertVc()

                                                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
                                                    self.navigationController?.pushViewController(vc, animated: true )
                                                    return
                            }
                           
                        }
                        else {
                            if self.needPwd == 0{
                                
//                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
//                                self.navigationController?.pushViewController(vc, animated: true )

                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "RechargeVC")
                                self.navigationController?.pushViewController(vc, animated: true)
                            }// 设置交易密码
                            else{
                                
                                let alertVc = AlertViewController()
                                alertVc.showAlertVc(imageName: "tangchuang_tongzhi",

                                                    titleLabelText: "开通支付",
                                                    subTitleText: "需要开通支付才能进行充值等后续操作。\n开通支付后，您可以求购明星时间，转让明星时间，\n和明星在‘星聊’中聊天，并且还能约见明星。",
                                                    completeButtonTitle: "我 知 道 了") {[weak alertVc] (completeButton) in
                                                        alertVc?.dismissAlertVc()

                                                        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC")
                                                        self.navigationController?.pushViewController(vc, animated: true )
                                                        return
                                }
                                

                            }
                          }
                        }
                    }
            }
            if indexPath.row == 1 {
                
                print("此处提现操作")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.0001
    }
}
