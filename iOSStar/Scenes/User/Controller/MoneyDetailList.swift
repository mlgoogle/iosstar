//
//  MoneyDetailList.swift
//  iOSStar
//
//  Created by sum on 2017/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class MoneyDetailListCell: OEZTableViewCell {
    

    @IBOutlet weak var weekLb: UILabel!            // 姓名LbstatusLb
    @IBOutlet weak var timeLb: UILabel!            // 时间Lb
    @IBOutlet weak var moneyCountLb: UILabel!      // 充值金额Lb
    @IBOutlet weak var statusLb: UILabel!          // 状态Lb
    @IBOutlet weak var minuteLb: UILabel!          // 分秒
    @IBOutlet weak var bankLogo: UIImageView!      // 银行卡图片
    @IBOutlet weak var withDrawto: UILabel!        // 提现至
    override func update(_ data: Any!) {
        
        // print(data)
        
        let model = data as! Model
        self.moneyCountLb.text = "+" + " "  + String.init(format: "%.2f", model.amount)
        let timestr : Int = Date.stringToTimeStamp(stringTime: model.depositTime)
        self.withDrawto.text = model.depositType == 1 ? "微信支付" :"银行卡"
        self.weekLb.text = Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "yyyy")
        self.statusLb.text = model.status == 1 ? "处理中" : (model.status == 2 ?  "充值成功":  "充值失败")
        self.timeLb.text =  Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "MM-dd")
        self.minuteLb.text =  Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "HH:mm:ss")
        
    }
        //        BankLogoColor.share().checkLocalBank(string: model.ba)
      

}

class MoneyDetailList: BaseCustomPageListTableViewController {
    
    var contentoffset = CGFloat()
    var navLeft : UIButton?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "资金明细"
        navLeft = UIButton.init(type: .custom)
        
        navLeft?.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let right = UIBarButtonItem.init(customView: navLeft!)
        
        navLeft?.addTarget(self , action: #selector(selectDate), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = right
        navLeft?.setImage(UIImage.init(named: "calendar@2x"), for: .normal)
        ShareDataModel.share().addObserver(self, forKeyPath: "selectMonth", options: .new, context: nil)
    }
    
    override func didRequest(_ pageIndex : Int) {

        
        AppAPIHelper.user().creditlist(status: 0, pos: Int32((pageIndex - 1) * 10), count: 10, complete: { (result) in
            if let object = result {
              let model : RechargeListModel = object as! RechargeListModel
              self.didRequestComplete(model.depositsinfo as AnyObject)
            }
          
        }) { (error ) in
            
            SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 0.5, completion: {
            })
              self.didRequestComplete(nil)
        }
       

    }
    //MARK-
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "selectMonth" {
            
            if let selectMonth = change? [NSKeyValueChangeKey.newKey] as? String {
                navLeft?.isEnabled = true
                self.tableView.isScrollEnabled = true
                if selectMonth != "1000000" {
                    //                    monthLb.text = "2017年" + " " + "\(selectMonth)" + "月"
                }
            }
        }
    }
    deinit {
        ShareDataModel.share().removeObserver(self, forKeyPath: "selectMonth", context: nil)
    }
    // MARK: - Table view data source
    
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc  = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResultVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectDate(){
        
        navLeft?.isEnabled = false
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: -35, width: self.view.frame.size.width, height: self.view.frame.size.height + 40))
        tableView.isScrollEnabled = false
        self.view.addSubview(customer)
    }
    
    
    
}
