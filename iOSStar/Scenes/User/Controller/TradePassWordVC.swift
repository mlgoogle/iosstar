//
//  TradePassWordVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
class TradePassWordVC: UIViewController ,UITextFieldDelegate{

    var setPass = false
    var showKeyBoard : Bool = false
    var passString : String = ""
    @IBOutlet weak var doSetPass: UIButton!
    fileprivate var pwdCircleArr = [UILabel]()
    fileprivate var textField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doSetPass.setTitle(setPass == false ? "下一步" :"确定", for: .normal)
        title = setPass == true ? "请确认交易密码" :  "设置交易密码"
         self.doSetPass.backgroundColor = UIColor.gray
        initUI()
        
        // navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backClick"), style: .done, target: self, action: #selector(leftButtonItemClick(_ :)))
        
    }
    
    func leftButtonItemClick(_ sender : Any) {
        
        if title == "设置交易密码"  {
            //print("设置交易密码")
//            ShareDataModel.share().isReturnBackClick = true;
            UserDefaults.standard.set(true, forKey: "isReturnBackClick")
            _ = self.navigationController?.popViewController(animated: true)
            
        } else {
             //print("点击了请确认交易密码")
            for controller in (self.navigationController?.viewControllers)!{
                if controller.isKind(of: WealthVC.self){
//                self.navigationController?.popToRootViewController(animated: true)
               _ = self.navigationController?.popToViewController(controller, animated: true)
                }
            }
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func initUI(){

        textField = UITextField(frame: CGRect(x: 0,y: 60, width: view.frame.size.width, height: 35))
        textField.delegate = self
        textField.isHidden = true
        textField.keyboardType = UIKeyboardType.numberPad
        view.addSubview(textField!)
        textField.backgroundColor = UIColor.red
        textField.becomeFirstResponder()
        
        
        for i in 0  ..< 6 {
        
      
            let line:UIView = UIView(frame: CGRect(x: 30 + CGFloat(i) * 10 + (( kScreenWidth - 110) / 6.0) * CGFloat(i),y: 120, width: ((kScreenWidth - 110) / 6.0) ,height:  ((kScreenWidth - 110) / 6.0)))
            line.backgroundColor = UIColor.clear
            line.alpha = 1
            line.layer.borderWidth = 1
            line.layer.cornerRadius = 3
            line.layer.borderColor = UIColor.gray.cgColor
            view.addSubview(line)
           
           
            let circleLabel:UILabel =  UILabel(frame: CGRect(x: 0 ,y:  0,width: ((kScreenWidth - 110) / 6.0),height: ((kScreenWidth - 110) / 6.0)))
            
            circleLabel.textAlignment = .center
            circleLabel.text = "﹡"
            circleLabel.font = UIFont.systemFont(ofSize: 17)
            circleLabel.layer.masksToBounds = true
            circleLabel.isHidden = true
            pwdCircleArr.append(circleLabel)
            line.addSubview(circleLabel)
        }
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150)
        btn.addTarget(self, action: #selector(showboard(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
      // MARK:  显示键盘
    @IBAction func showboard(_ sender: Any) {
        if showKeyBoard == true
        {
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
        showKeyBoard = !showKeyBoard
    }
   
    // MARK:  点击下一步
    @IBAction func doSetPass(_ sender: Any) {
        
        let phoneNum = (UserDefaults.standard.object(forKey: "phone") as! String)
        
        //  来判断是否请求接口设置交易密码
        if setPass == true{
            if passString.length() == 6{
                if ShareDataModel.share().wechatUserInfo["passString"] != passString{
                 SVProgressHUD.showErrorMessage(ErrorMessage: "两次密码输入不一致", ForDuration: 2.0, completion: {})
                    return
                }
            }
            let requsetModel = ResetPassWdModel()
            requsetModel.phone = phoneNum
            requsetModel.pwd = passString.md5_string()
            requsetModel.timestamp = 1
            requsetModel.type = 0
            AppAPIHelper.user().resetPassWd(requestModel:requsetModel , complete: { (result) in
                
                if let dic = result as? [String : AnyObject] {
                    if let status = dic["status"] as? Int {
                        if status == 0 {
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "设置成功", ForDuration: 2.0, completion: {
                                for controller  in (self.navigationController?.viewControllers)!{
                                    if controller.isKind(of: OrderStarViewController.self) {
                                        _ = OrderStarViewController()
                                        _ = self.navigationController?.popToViewController(controller, animated: true)
                                    } else {
                                        _ = self.navigationController?.popToRootViewController(animated: true)
                                    }
                                }
                            })
                        }
                    }
                }else{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "设置失败", ForDuration: 2.0, completion: nil)
                }
        }) { (error) in
            
        }
//            AppAPIHelper.user().ResetPassWd(timestamp: 1, vCode: " ", vToken: " ", pwd: passString.md5_string()  , type: 0, phone: phoneNum, complete: { (result) in
//              
//                if let model = result {
//                    
//                    // //print("=========\(String(describing: result))")
//                    
//                    let dic = model as! [String : AnyObject]
//                    if dic["status"] as! Int  == 0 {
//                      SVProgressHUD.showSuccessMessage(SuccessMessage: "设置成功", ForDuration: 2.0, completion: {
//                        for controller  in (self.navigationController?.viewControllers)!{
//                            if controller.isKind(of: OrderStarViewController.self) {
//                                let orderVc = OrderStarViewController()
//                                self.navigationController?.popToViewController(controller, animated: true)
//                            } else {
//                                self.navigationController?.popToRootViewController(animated: true)
//                            }
//                        }
//                      })
//                    }else{
//                        SVProgressHUD.showErrorMessage(ErrorMessage: "设置失败", ForDuration: 2.0, completion: nil)
//                    }
//                    
//                }
//            }) { (error) in
//                
//            }
//            
            
        }else{
              //   来判断密码长度
            if passString.length() == 6{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC") as! TradePassWordVC
                vc .setPass = true
                ShareDataModel.share().wechatUserInfo["passString"] = passString
                self.navigationController?.pushViewController(vc, animated: true )
            }else{
               SVProgressHUD.showErrorMessage(ErrorMessage: "密码需要6位", ForDuration: 2.0, completion: {})
            }
           
        }
   
    
    }
     //Mark: 输入变成点
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.characters.count > 5 && string.characters.count > 0){
            return false
        }
        
        var password : String
        if string.characters.count <= 0 && textField.text?.length() != 0{
            
            let index = textField.text?.characters.index((textField.text?.endIndex)!, offsetBy: -1)
            password = textField.text!.substring(to: index!)
        }
        else {
            password = textField.text! + string
            
        }
        passString = ""
        self.doSetPass.backgroundColor = UIColor.gray
        self .setCircleShow(password.characters.count)
        
        if(password.characters.count == 6){
           passString = password
           self.doSetPass.backgroundColor =    UIColor(hexString: AppConst.Color.main)
          
        }
        return true;
    }
    
    func setCircleShow(_ count:NSInteger){
        for circle in pwdCircleArr {
           
            let supView = circle.superview
            supView?.layer.borderColor = UIColor.gray.cgColor
            supView?.layer.borderWidth = 1
            circle.isHidden = true;
            
        }
        for i in 0 ..< count {
            pwdCircleArr[i].isHidden = false
            let view = pwdCircleArr[i]
            let supView = view.superview
            supView?.layer.borderColor = UIColor(hexString: AppConst.Color.main).cgColor
            supView?.layer.borderWidth = 2
//            let vie =  pwdCircleArr[i].sup
        }
    }



}
