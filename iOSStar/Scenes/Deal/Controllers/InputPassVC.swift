//
//  InputPassVC.swift
//  iOSStar
//
//  Created by sum on 2017/6/13.
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
class  InputPassVC: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var contentView: UIView!
    var resultBlock: CompleteBlock?
    var passString : String = ""
    var showKeyBoard : Bool = false
    fileprivate var pwdCircleArr = [UILabel]()
     var textField:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "请输入交易密码"
        initUI()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func initUI(){
        
        textField = UITextField(frame: CGRect(x: 0,y: 60, width: view.frame.size.width, height: 35))
        textField.delegate = self
        textField.isHidden = true
        textField.keyboardType = UIKeyboardType.phonePad
        view.addSubview(textField!)
        textField.backgroundColor = UIColor.red
        switch showKeyBoard {
        case true:
            textField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        for i in 0  ..< 6 {
            let line:UIView = UIView(frame: CGRect(x: 40 + CGFloat(i) * 10 + (( kScreenWidth - 120) / 6.0) * CGFloat(i),y: 60, width: ((kScreenWidth - 120) / 6.0) ,height:  ((kScreenWidth - 120) / 6.0)))
            line.backgroundColor = UIColor.clear
            line.alpha = 1
            line.layer.borderWidth = 1
            line.layer.cornerRadius = 3
            line.layer.borderColor = UIColor.gray.cgColor
            contentView.addSubview(line)
            
            
            let circleLabel:UILabel =  UILabel(frame: CGRect(x: 0 ,y:  0,width: ((kScreenWidth - 120) / 6.0),height: ((kScreenWidth - 110) / 6.0)))
            
            circleLabel.textAlignment = .center
            circleLabel.text = "﹡"
            circleLabel.font = UIFont.systemFont(ofSize: 17)
            circleLabel.layer.masksToBounds = true
            circleLabel.isHidden = true
            pwdCircleArr.append(circleLabel)
            line.addSubview(circleLabel)
        }
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: kScreenWidth - 80, y: 120, width: 80, height: 30)
        btn.setTitle("忘记密码", for: .normal)
        btn.titleLabel?.font  = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(btn)
        btn.setTitleColor(UIColor.init(hexString: AppConst.Color.orange), for: .normal)
        btn.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)
        

       
    }
  
    func forgotPass(){
        if showKeyBoard{
            let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
         resultBlock?(doStateClick.doResetPwd as AnyObject)
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
      
        self .setCircleShow(password.characters.count)
        
        if(password.characters.count == 6){
            passString = password
           
            AppAPIHelper.dealAPI().checkPayPass(paypwd: passString.md5_string(), complete: { (result) in
                if let object = result {
                
                    let dic = object as! [String : AnyObject]
                    if dic["result"] as! Int == 1{
                     SVProgressHUD.showErrorMessage(ErrorMessage: "密码校验成功", ForDuration: 0.23, completion: { 
                        self.resultBlock?("123" as AnyObject)
                     })
                    }else{
                    
//                        textField.becomeFirstResponder()
                        SVProgressHUD.showErrorMessage(ErrorMessage: "密码输入错误", ForDuration: 1, completion: {
                             textField.becomeFirstResponder()
                            textField.text = ""
                            self.passString = ""
                            self.setCircleShow(0)
                            
                        })
                    }
                }
            }, error: { (errror) in
                
            })
//            resultBlock?(passString as AnyObject)
            
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
            supView?.layer.borderColor = UIColor(hexString: "FB9938").cgColor
            supView?.layer.borderWidth = 2
            //            let vie =  pwdCircleArr[i].sup
        }
    }
    @IBAction func back(_ sender: Any) {
        
        resultBlock?(doStateClick.close as AnyObject)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.becomeFirstResponder()
//        view.endEditing(false)
    }
    
    
}


