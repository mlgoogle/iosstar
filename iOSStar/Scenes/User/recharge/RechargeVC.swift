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
    var   rechargeMoney : Double = 0.00
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
        inputMoney.delegate = self
        inputMoney.keyboardType = .decimalPad
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        loadview()
        
    }
    //MARK:微信充值成功回调充值
    func paysuccess(_ notice: NSNotification) {
        if let errorCode: Int = notice.object as? Int{
            //            var code = Int()
            if errorCode == 0 {
//                SVProgressHUD.showError(withStatus: "充值成功")
                SVProgressHUD.showSuccess(withStatus: "充值成功")
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
             rechargeMoney = 0.0
        }else{
            
        }
    }
    func textFieldDidChange(_ textFile : NSNotification) {
        
        if inputMoney.text != "" {
            if Double.init(inputMoney.text!)! > 50000 {
                SVProgressHUD.showError(withStatus: "金额不能大于50000")
                inputMoney.text = ""
                return
            }
           rechargeMoney = Double.init(inputMoney.text!)!
        }
     
    }
    
    //MARK:去充值
    @IBAction func doRecharge(_ sender: Any) {
        //微信充值
        print(rechargeMoney)
        if rechargeMoney == 0.0 {
        SVProgressHUD.showErrorMessage(ErrorMessage: "请输入充值金额", ForDuration: 0.5, completion: {
           
        })
             return
        }
        if paytype == 0 {
           doWeiXinPay()
        }else{
           doAliPay()
        }
        
       
        
    }
   
    func weixinpay(){
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - 支付处理
extension RechargeVC {
    
    fileprivate func doAliPay() {
        
        let order = Order()
        
        // 需要APPID and privateKey
        let appID = "APPID"
        let privateKey = ""
        
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = "alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = "utf-8";
        
        // NOTE: 当前时间点
        // let formatter = DateFormatter()
        // formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // order.timestamp = formatter.string(from: NSDate() as Date)
        
        // NOTE: 支付版本
        order.version = "1.0";
        
        // NOTE: sign_type 根据商户设置的私钥来决定
        order.sign_type = privateKey
        
        
        order.biz_content = BizContent()
        // NOTE: 商品数据
        order.biz_content.body = "我是测试数据" // 标题
        order.biz_content.subject = "1"
        // 订单ID（由商家自行制定）
        order.biz_content.out_trade_no = "1273218732168376218312"
        // 超时时间设置
        order.biz_content.timeout_express = "30m"
        // 商品价格
        order.biz_content.total_amount = "0.01"
        
        print(order.biz_content.description)
        
        //将商品信息拼接成字符串
        //            NSString *orderInfo = [order orderInfoEncoded:NO];
        //            NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        let orderInfo = order.orderInfoEncoded(false)
        let orderInfoEncoded = order.orderInfoEncoded(true)
        
        print("orderSpec = \(String(describing: orderInfo))")
        print("orderSpec = \(orderInfo)")
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        let signer = RSADataSigner(privateKey: privateKey)
        
        let signedString = signer?.sign(orderInfo, withRSA2: true)
        
        // 应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        let appScheme = "AliPayScheme"
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        let orderString = "\(orderInfoEncoded)&sign=\"\(signedString)\"&sign_type=\"RSA\""
        
        print("orderString == \(orderString)")
        
        // NOTE: 调用支付结果开始支付
        AlipaySDK.defaultService().payOrder(orderString, fromScheme: appScheme, callback: { (resultDic) in
            print("resultDic =\(resultDic)")
        })
    }
    
    
    fileprivate func doWeiXinPay() {
    
        SVProgressHUD.show(withStatus: "加载中")
        AppAPIHelper.user().weixinpay(title: "余额充值",
                                      price: 0.01,
                                      complete: { (result) in
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
}
