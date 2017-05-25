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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
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
    fileprivate var inputViewWidth:CGFloat!
    fileprivate var textField:UITextField!
    fileprivate var passheight:CGFloat!
    fileprivate var inputViewX:CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doSetPass.setTitle(setPass == false ? "下一步" :"确定", for: .normal)
        title = "设置交易密码"
        initUI()

       
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
        
      
            let line:UIView = UIView(frame: CGRect(x: 30 + CGFloat(i) * 10 + (( kScreenWidth - 110) / 6.0) * CGFloat(i),y: 40, width: ((kScreenWidth - 110) / 6.0) ,height:  ((kScreenWidth - 110) / 6.0)))
            line.backgroundColor = UIColor.clear
            line.alpha = 1
            line.layer.borderWidth = 1
            line.layer.cornerRadius = 3
            line.layer.borderColor = UIColor.gray.cgColor
            view.addSubview(line)
           
           
            let circleLabel:UILabel =  UILabel(frame: CGRect(x: line.frame.size.width / 2.0 - 5 ,y:  line.frame.size.width / 2.0 - 5,width: 10,height: 10))
           
            circleLabel.backgroundColor = UIColor.black
            circleLabel.layer.cornerRadius = 5
            circleLabel.layer.masksToBounds = true
            circleLabel.isHidden = true
            pwdCircleArr.append(circleLabel)
             line.addSubview(circleLabel)
        }
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100)
        btn.addTarget(self, action: #selector(showboard(_:)), for: .touchUpInside)
        view.addSubview(btn)
    }
      //Mark: 显示键盘
    @IBAction func showboard(_ sender: Any) {
        if showKeyBoard == true
        {
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
        showKeyBoard = !showKeyBoard
    }
   
    //Mark: 点击下一步
    @IBAction func doSetPass(_ sender: Any) {
        
        if setPass == true{
        }else{
            if passString.length() == 6{
                let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC") as! TradePassWordVC
                vc .setPass = true
                self.navigationController?.pushViewController(vc, animated: true )
            }else{
             SVProgressHUD.showErrorMessage(ErrorMessage: "密码需要6位", ForDuration: 1, completion: { 
                
             })
            }
           
        }
   
    
    }
     //Mark: 输入变成点
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField.text?.characters.count > 5 && string.characters.count > 0){
            return false
        }
        
        var password : String
        if string.characters.count <= 0 {
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
        }
        return true;
    }
    
    func setCircleShow(_ count:NSInteger){
        for circle in pwdCircleArr {
            circle.isHidden = true;
        }
        for i in 0 ..< count {
            pwdCircleArr[i].isHidden = false
        }
    }
 


}
