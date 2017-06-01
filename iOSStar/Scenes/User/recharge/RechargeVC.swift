//
//  RechargeVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class RechargeVC: BaseTableViewController ,WXApiDelegate,UITextFieldDelegate{
    
    
    var selectTypeHeight = CGFloat.init(140)
    //选中支付方式银行卡号
    @IBOutlet weak var payTypeNumber: UILabel!
    //选中支付的银行
    @IBOutlet weak var payTypeName: UILabel!
    //输入金额
    @IBOutlet weak var inputMoney: UITextField!
    //选中支付方式的图片
    var selectBtn : Bool = false
    @IBOutlet weak var payTypeImg: UIImageView!
    var  payView : SelectPayType!
    var rechargeMoney : Double = 0.00
    var  bgview : UIView!
    var  paytype  = Int()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(paysuccess(_:)), name: Notification.Name(rawValue:AppConst.WechatPay.WechatKeyErrorCode), object: nil)
        title = "充值"
        inputMoney.addTarget(self , action: #selector(valueChange(_:)), for: .valueChanged)
        inputMoney.delegate = self
        loadview()
        
    }
    //MARK:去充值
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
    //MARK:键盘编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if selectBtn == true {
            let vi :UIButton =  self.view.viewWithTag(Int.init(rechargeMoney)) as! UIButton
            vi.backgroundColor = UIColor.white
            vi.setTitleColor(UIColor.init(hexString: "FB9938"), for: .normal)
            selectBtn = false
        }else{
            
        }
    }
    func valueChange(_ textFile : UITextField){
        rechargeMoney = Double.init(textFile.text!)!
    }
    //MARK:去充值
    @IBAction func doRecharge(_ sender: Any) {
        SVProgressHUD.show(withStatus: "加载中")
        AppAPIHelper.user().weixinpay(title: "余额充值", price: rechargeMoney, complete: { (result) in
            
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
             print(error)
        }
        
    }
    //MARK:选择充值金额
    @IBAction func chooseRechargeMoney(_ sender: Any) {
        if selectBtn == false{
            selectBtn = true
            inputMoney.text = ""
            rechargeMoney = 0.0
        }
        inputMoney.resignFirstResponder()
        let btn = sender as! UIButton
        if rechargeMoney != 0.0{
            let vi :UIButton =  self.view.viewWithTag(Int.init(rechargeMoney)) as! UIButton
            vi.backgroundColor = UIColor.white
            vi.setTitleColor(UIColor.init(hexString: "FB9938"), for: .normal)
            rechargeMoney = Double.init(btn.tag)
            btn.backgroundColor = UIColor.init(hexString: "FB9938")
            btn.setTitleColor(UIColor.white, for: .normal)
            rechargeMoney = Double.init(btn.tag)
            
        }else{
            btn.backgroundColor = UIColor.init(hexString: "FB9938")
            btn.setTitleColor(UIColor.white, for: .normal)
            rechargeMoney = Double.init(btn.tag)
            
        }
    }
    
    //MARK:tableView datasource
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
                self.payView.frame = CGRect.init(x: 0, y: tableView.frame.size.height - self.selectTypeHeight, width: tableView.frame.size.width, height: self.selectTypeHeight)
            })
        }
    }
    //MARK:loadview添加支付方式的view
    func loadview(){
        bgview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))
        bgview.backgroundColor = UIColor.clear
        tableView.addSubview(bgview)
        payView =  Bundle.main.loadNibNamed("SelectPayType", owner: nil, options: nil)?.last as? SelectPayType
        payView.frame = CGRect.init(x: 0, y: tableView.frame.size.height + 500, width: tableView.frame.size.width, height: 200)
        payView.resultBlock = {[weak self](result) in
            
            self?.tableView.isScrollEnabled = true
            let object = result
            if object is Int {
                self?.tableView.sendSubview(toBack: (self?.bgview)!)
                UIView.animate(withDuration: 0.25, animations: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.payView.frame = CGRect.init(x: 0, y: ((self?.tableView.frame.size.height)! + (self?.selectTypeHeight)!), width: (self?.tableView.frame.size.width)!, height: (self?.selectTypeHeight)!)
                    })
                }, completion: { (result ) in
                    self?.payView.frame = CGRect.init(x: 0, y: ((self?.tableView.frame.size.height)! + 500), width: (self?.tableView.frame.size.width)!, height: (self?.selectTypeHeight)!)
                })
            }else{
                let model  = result as! SelectPayTypeModel
                self?.payTypeName.text = model.id == 0 ? "微信" : "支付宝"
                
                self?.paytype = model.id
                self?.payTypeImg.image = UIImage.init(named: model.img)
            }
        }
        tableView.sendSubview(toBack: bgview)
        bgview.addSubview(payView)
        
    }
    
    
}
