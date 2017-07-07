//
//  WithdrawalVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class WithdrawalVC: BaseTableViewController,UITextFieldDelegate {

    @IBOutlet var withDrawMoney: UILabel!
    //收款账户
    @IBOutlet var account: UILabel!
    @IBOutlet var inputMoney: UITextField!
    var accountMoney = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "提现"
        inputMoney.delegate = self
        let  navLeft = UIButton.init(type: .custom)
        navLeft.setTitle("提现记录", for: .normal)
        navLeft.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        inputMoney.becomeFirstResponder()
        navLeft.setTitleColor(UIColor.init(hexString: "333333"), for: .normal)
        navLeft.frame = CGRect.init(x: 0, y: 0, width: 60, height: 20)
        let right = UIBarButtonItem.init(customView: navLeft)
       
        navLeft.addTarget(self , action: #selector(selectDate), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = right
        getbankinfo()
        getwealth()
       
    }
    func  getbankinfo(){
        let model = BankCardListRequestModel()
        AppAPIHelper.user().bankcardList(requestModel: model, complete: { [weak self](result) in
            if let model =  result as? BankListModel{
               
                let dataModel = BankCardListRequestModel()
                dataModel.cardNo = model.cardNo
                AppAPIHelper.user().bankcardifo(requestModel: dataModel, complete: { [weak self](result) in
                    if let dataBank =  result as? BankInfo{
//                        self?.bankName.text = dataBank.bankName
//                        self?.cardType.text = dataBank.cardName
                             let index1 = model.cardNo.index(model.cardNo.startIndex,  offsetBy: model.cardNo.length()-3)
                            self?.account.text = dataBank.bankName + "(" + model.cardNo.substring(from: index1) + ")"
                    }
                    
                    }, error: { (error) in
                        
                })
//
               
            }
            
        }) { (error ) in
            self.didRequestError(error)
        }
    }
    func  getwealth(){
    
        self.getUserInfo { [weak self](result) in
            if let response = result{
                let object = response as! UserInfoModel
                self?.withDrawMoney.text = "可提现金额" + "¥" + String.init(format: "%.2f", object.balance)
                self?.accountMoney = object.balance
            }
        }
    }
    func selectDate(){
    
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithDrawaListVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //全部提现
    @IBAction func withDrawAll(_ sender: Any) {
        inputMoney.text = String.init(format: "%.2f", accountMoney)
    }
    //忘记密码
    @IBAction func forgotPwd(_ sender: Any) {
        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func withDraw(_ sender: Any) {
        
        if inputMoney.text != ""{
            
        if Double.init(inputMoney.text!)! > accountMoney{
            SVProgressHUD.showErrorMessage(ErrorMessage: "最多可提现" + String.init(format: "%.2f", accountMoney), ForDuration: 1, completion: nil)
         return
        }
            if Double.init(inputMoney.text!)! <= 0{
            SVProgressHUD.showErrorMessage(ErrorMessage: "提现金额大于0" , ForDuration: 1, completion: nil)
                return
            }
    
       
        
        let model = OrderInformation()
        model.orderStatus = " "
        model.orderInfomation = ""
        model.orderPrice  = ""
        
        //将值传给 sharedatemodel
        ShareDataModel.share().orderInfo = model
        let storyboard = UIStoryboard.init(name: "Order", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as!  UINavigationController
        
        
        let rootvc = controller.viewControllers[0] as! ContainPayVC
        
        
        rootvc.showAll = false
        rootvc.contOffset = true
        rootvc.resultBlock = { (result) in
            
            if result is String{
               
                SVProgressHUD.showSuccessMessage(SuccessMessage: "密码校验成功", ForDuration: 1, completion: { 
                    
                    controller.dismissController()
                   let requestmodel = WithDrawrequestModel()
                    requestmodel.price = Double.init(self.inputMoney.text!)!
                    
                    AppAPIHelper.user().withDraw(requestModel: requestmodel, complete: { (result) in
                        if let datamodel =  result as? WithDrawResultModel{
                            if datamodel.result == 1 {
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "提现成功", ForDuration: 1, completion: {
                                self.navigationController?.popViewController(animated: true)
                            })
                            }
                        }
                    }, error: { (error ) in
                        
                    })
                })
               
                
                
            }else{
              
            }
        }
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true, completion: nil)
       
        }
        else{
       SVProgressHUD.showErrorMessage(ErrorMessage: "请输入提现金额", ForDuration: 1, completion: nil)
        }

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let resultStr = textField.text?.replacingCharacters(in: (textField.text?.range(from: range))!, with: string)
        return resultStr!.isMoneyString()
    }


}
