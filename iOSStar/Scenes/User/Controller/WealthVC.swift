//
//  wealthVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class HeaderCell: UITableViewCell {
    
    @IBOutlet var bgView: UIView!
    // 星享币
    @IBOutlet weak var balance: UILabel!
    // 持有市值
    @IBOutlet var market_cap: UILabel!
    // 可用余额
    @IBOutlet var total_amt: UILabel!
    // 昵称
    @IBOutlet weak var nickNameLabel: UILabel!
    // 已购明细数量
    @IBOutlet weak var buyStarLabel: UILabel!
    // Icon
    @IBOutlet weak var iconImageView: UIImageView!
}

class WealthVC: UIViewController,UITableViewDelegate,UITableViewDataSource,CustomeAlertViewDelegate {
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.getUserInfo { (result) in
            if let response = result{
                let object = response as! UserInfoModel
                self.balance?.text =  String.init(format: "%.2f", object.balance)
                self.market_cap?.text = String.init(format: "%.2f", object.market_cap)
                self.total_amt?.text = String.init(format: "%.2f", object.total_amt)
                self.needPwd = object.is_setpwd
            }
        }
    }
    @IBAction func doBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    //MARK: tableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 225 : 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        if indexPath.section == 0{
            market_cap = cell.market_cap
            market_cap?.textColor = UIColor.init(hexString: AppConst.Color.orange)
            total_amt?.textColor = UIColor.init(hexString: AppConst.Color.orange)
            total_amt = cell.total_amt
            balance = cell.balance
            cell.bgView.backgroundColor = UIColor.init(hexString: AppConst.Color.orange)
            return cell
        }
        if indexPath.section == 1{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RechareCell")
                return cell!
            }
            //            if indexPath.row == 1{
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawCell")
            //                return cell!
            //            }
            //            return cell
            
        }
        
        if indexPath.section == 2{
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "WithDrawCell")
                return cell!
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                
                if self.needPwd == 1{
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
                else{
                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "RechargeVC")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        if indexPath.section == 2 {
        //WithdrawalVC
            
            if self.needPwd == 1{
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
            else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithdrawalVC")
                self.navigationController?.pushViewController(vc!, animated: true)
            }

           
        }
    }
    
    //                let alertVc = AlertViewController()
    //                self.getUserRealmInfo { (result) in
    //                    if let model = result{
    //                        let object =  model as! [String : AnyObject]
    //
    //                        if object["realname"] as! String == ""{
    //                            alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
    //                                                titleLabelText: "您还没有身份验证",
    //
    //                                                subTitleText: "您需要进行身份验证,\n之后才可以进行明星时间交易",
    //                                                completeButtonTitle: "开 始 验 证") {[weak alertVc] (completeButton) in
    //                                                    alertVc?.dismissAlertVc()
    //
    //                                                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
    //                                                    self.navigationController?.pushViewController(vc, animated: true )
    //                                                    return
    //                            }
    //
    //                        }
    //                        else {
    //                            if self.needPwd == 0{
    //
    ////                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
    ////                                self.navigationController?.pushViewController(vc, animated: true )
    //
    //                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "RechargeVC")
    //                                self.navigationController?.pushViewController(vc, animated: true)
    //                            }// 设置交易密码
    //                            // else if ShareDataModel.share().isReturnBackClick == false {
    //                            else if (UserDefaults.standard.bool(forKey: "isReturnBackClick") == false) {
    //
    ////
    //                                }
    //
    //                            }
    //                            else {
    //                                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC")
    //                                self.navigationController?.pushViewController(vc, animated: true )
    //
    //                            }
    //                          }
    //                        }
    //                    }
    //            }
    //            if indexPath.row == 1 {
    //
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 10 : 0.0001
    }
    @IBAction func showAlert(_ sender: Any) {
        
        let customer : CustomeShowBankView = CustomeShowBankView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 40))
        customer.delegate = self
        tableView.isScrollEnabled = false
        self.view.addSubview(customer)
    }
    func didSelectMonth(index:Int){
        if index == 1{
        //
            let model = BankCardListRequestModel()
            AppAPIHelper.user().bankcardList(requestModel: model, complete: { [weak self](result) in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "BankCardVC")
                self?.navigationController?.pushViewController(vc!, animated: true)
            }) { [weak self](error ) in
                let alertVc = AlertViewController()
                alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                                                                    titleLabelText: "您还没有绑定银行卡",
                
                                                                subTitleText: "您需要银行卡进行明星时间交易",
                                                                completeButtonTitle: "开 始 绑 定") {[weak alertVc] (completeButton) in
                                                                    alertVc?.dismissAlertVc()
                
                                                                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "BindingBankCardVC")
                                                                    self?.navigationController?.pushViewController(vc, animated: true )
                                                                    return
                                            }

            }
          
        }
        if index == 0{
            //
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoneyDetailList")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
