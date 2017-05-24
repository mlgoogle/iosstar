//
//  RechargeVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class RechargeVC: UITableViewController ,WXApiDelegate{

    @IBOutlet weak var inputMoney: UITextField!
    var  payView : SelectPayType!
    var rechargeMoney : Double = 0.00
    var  bgview : UIView!
    var  paytype  = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(paysuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        title = "充值"
    
//        tableView.isScrollEnabled = false
        loadview()
       
    }
    func paysuccess(_ notice: NSNotification) {
        if let errorCode: Int = notice.object as? Int{
            //            var code = Int()
            if errorCode == 0 {
                 SVProgressHUD.showError(withStatus: "充值成功")
                return
                
            }
            else if errorCode == -4{
                SVProgressHUD.showError(withStatus: "支付失败")
                return
            }
            else   if errorCode == -2{
                SVProgressHUD.showError(withStatus: "用户中途取消")
                return
            }
        }
    }
    @IBAction func doRecharge(_ sender: Any) {
        
        AppAPIHelper.friend().weixinpay(title: "余额充值", price: 0.01, complete: { (result) in
            SVProgressHUD.dismiss()
                        if let object = result {
                            let request : PayReq = PayReq()
                            let str : String = object["timestamp"] as! String!
//                            ShareModel.share().shareData["rid"] =  object["rid"] as! String!
                            request.timeStamp = UInt32(str)!
                            request.sign = object["sign"] as! String!
                            request.package = object["package"] as! String!
                            request.nonceStr = object["noncestr"] as! String!
                            request.partnerId = object["partnerid"] as! String!
                            request.prepayId = object["prepayid"] as! String!
                            WXApi.send(request)
                        }
                       
        }) { (error ) in
            
        }

    }

    @IBAction func chooseRechargeMoney(_ sender: Any) {
        
        
        let btn = sender as! UIButton
        if rechargeMoney != 0.0{
            let vi :UIButton =  self.view.viewWithTag(Int.init(rechargeMoney)) as! UIButton
            vi.backgroundColor = UIColor.white
            vi.setTitleColor(UIColor.init(hexString: "FB9938"), for: .normal)
           rechargeMoney = Double.init(btn.tag)
           btn.backgroundColor = UIColor.init(hexString: "FB9938")
           btn.setTitleColor(UIColor.white, for: .normal)
            
        }else{
            btn.backgroundColor = UIColor.init(hexString: "FB9938")
            btn.setTitleColor(UIColor.white, for: .normal)
            rechargeMoney = Double.init(btn.tag)

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 10
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0.001 : 10
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
        
           inputMoney.resignFirstResponder()
            tableView.isScrollEnabled = false
            tableView.bringSubview(toFront: bgview)
            UIView.animate(withDuration: 0.4, animations: {
                self.payView.frame = CGRect.init(x: 0, y: tableView.frame.size.height - 198, width: tableView.frame.size.width, height: 200)
            })
        }
    }

    func loadview(){
        
        bgview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))
        bgview.backgroundColor = UIColor.clear
        tableView.addSubview(bgview)
        payView =  Bundle.main.loadNibNamed("SelectPayType", owner: nil, options: nil)?.last as? SelectPayType
        payView.frame = CGRect.init(x: 0, y: tableView.frame.size.height + 500, width: tableView.frame.size.width, height: 200)
        payView.resultBlock = {[weak self](result) in
             let code = result as! Int
           self?.tableView.isScrollEnabled = true
                if code == 1000{
                    self?.tableView.sendSubview(toBack: (self?.bgview)!)
                   UIView.animate(withDuration: 0.25, animations: { 
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.payView.frame = CGRect.init(x: 0, y: ((self?.tableView.frame.size.height)! + 198), width: (self?.tableView.frame.size.width)!, height: 200)
                    })
                   }, completion: { (result ) in
                      self?.payView.frame = CGRect.init(x: 0, y: ((self?.tableView.frame.size.height)! + 500), width: (self?.tableView.frame.size.width)!, height: 200)
                   })
                    
                }else{
            
                    self?.paytype = code
            }
        }
          tableView.sendSubview(toBack: bgview)
          bgview.addSubview(payView)
        
      }
    

}
