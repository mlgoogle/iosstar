//
//  BindingBankCardVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class BindingBankCardVC: UITableViewController {
    
    //持卡人姓名
    @IBOutlet var name: UITextField!
    //银行卡号
    @IBOutlet var cardNum: UITextField!
    //手机号
    @IBOutlet var phone: UITextField!
    //验证码
    @IBOutlet var vaildCode: UITextField!
    //定时器
    var openProvince = ""
    var openCityStr = ""
    @IBOutlet var openCity: UITextField!
    private var timer: Timer?
    //时间戳
    private var codeTime = 60
    //时间戳
    var timeStamp =  ""
    //token
    var vToken = ""
    
    // cityPickerView
    var cityPickerView = UIPickerView()
    
    // cityToolBar
    var cityToolBar = UIToolbar()
    
    //  cityList
    var dataCity = Array<Dictionary<String, AnyObject>>()
    
    // cityPickerView选择的row (省份)
    var selectRow = 0
    
    // cityPickerView选择的Componentow (市)
    var selectComponent = 0
    //发送验证码
    @IBOutlet var SendCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init()
        initCity()
        initCityPickerView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 获取cityData
    func initCity() {
        
        let address : String =  Bundle.main.path(forResource: "City", ofType: "plist")!
        
        let dic =  NSDictionary.init(contentsOfFile: address) as! [String : Array<Any>]
        
        dataCity = dic["city"]! as! Array<Dictionary<String, AnyObject>> as Array<Dictionary<String, AnyObject>>
        
        // // print(dataCity)
    }
    
    
    // cityPickerView
    func initCityPickerView(){
        
        cityPickerView = UIPickerView.init()
        
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        
        cityToolBar = UIToolbar.init(frame:  CGRect.init(x: 0,
                                                         y: self.view.frame.size.height - self.cityToolBar.frame.size.height - 44.0,
                                                         width: self.view.frame.size.width,
                                                         height: 44))
        
        openCity.inputView = cityPickerView
        openCity.inputAccessoryView = cityToolBar
        // 确定按钮
        let sure : UIButton = UIButton.init(frame: CGRect.init(x: 0,
                                                               y: 0,
                                                               width: 40,
                                                               height: 44))
        sure.setTitle("确定", for: .normal)
        sure.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        sure.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        let sureItem : UIBarButtonItem = UIBarButtonItem.init(customView: sure)
        
        let space : UIButton = UIButton.init(frame: CGRect.init(x: 40, y: 0, width: self.view.frame.size.width-140, height: 44))
        space.setTitle("", for: .normal)
        let spaceItem : UIBarButtonItem = UIBarButtonItem.init(customView: space)
        
        // 取消按钮
        let cancel : UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width-44,
                                                                 y: 0,
                                                                 width: 40,
                                                                 height: 44))
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let cancelItem : UIBarButtonItem = UIBarButtonItem.init(customView: cancel)
        
        cityToolBar.setItems([sureItem,spaceItem,cancelItem], animated: true)
    }
    @IBAction func sendCode(_ sender: Any) {
        
        if !isTelNumber(num: phone.text!) {
        SVProgressHUD.showErrorMessage(ErrorMessage: "请输入正确的手机号", ForDuration: 2, completion: nil)
            return 
        }
        if checkTextFieldEmpty([phone]) && isTelNumber(num: phone.text!) {
            let sendVerificationCodeRequestModel = SendVerificationCodeRequestModel()
            sendVerificationCodeRequestModel.phone = (self.phone.text!)
            sendVerificationCodeRequestModel.type = 3
            AppAPIHelper.login().SendVerificationCode(model: sendVerificationCodeRequestModel, complete: { [weak self] (result) in
                SVProgressHUD.dismiss()
                self?.SendCode.isEnabled = true
                if let response = result {
                    if response["result"] as! Int == 1 {
                        self?.timer = Timer.scheduledTimer(timeInterval: 1,target:self!,selector: #selector(self?.updatecodeBtnTitle),userInfo: nil,repeats: true)
                        self?.timeStamp = String.init(format: "%ld", response["timeStamp"] as!  Int)
                        self?.vToken = String.init(format: "%@", response["vToken"] as! String)
                    }else{
                     SVProgressHUD.showErrorMessage(ErrorMessage: "验证码获取失败", ForDuration: 2, completion: nil)
                    }
                }
                }, error: { (error) in
                    self.didRequestError(error)
                    
                    self.SendCode.isEnabled = true
            })
        }
    }
    //MARK:-   更新秒数
    func updatecodeBtnTitle() {
        if codeTime == 0 {
            SendCode.isEnabled = true
            SendCode.setTitle("重新发送", for: .normal)
            codeTime = 60
            timer?.invalidate()
            SendCode.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal)
            SendCode.backgroundColor = UIColor(hexString: AppConst.Color.orange)
            return
        }
        SendCode.isEnabled = false
        codeTime = codeTime - 1
        let title: String = "\(codeTime)秒重新发送"
        SendCode.setTitle(title, for: .normal)
        SendCode.setTitleColor(UIColor.init(hexString: "000000"), for: .normal)
        SendCode.backgroundColor = UIColor(hexString: "ECECEC")
    }
    @IBAction func bingCard(_ sender: Any) {
        
        if  checkTextFieldEmpty([phone,cardNum,name,openCity,vaildCode]){
            let string = "yd1742653sd" + self.timeStamp + self.vaildCode.text! + self.phone.text!
            if string.md5_string() != self.vToken{
                SVProgressHUD.showErrorMessage(ErrorMessage: "验证码错误", ForDuration: 1.0, completion: nil)
                return
            }
            let model = BindCardListRequestModel()
            model.bankUsername = name.text!
            model.account = cardNum.text!
            model.prov = openProvince
            model.city = openCityStr
            AppAPIHelper.user().bindcard(requestModel: model, complete: { [weak self](result) in
                SVProgressHUD.showSuccessMessage(SuccessMessage: "绑定成功", ForDuration: 1, completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
                }, error: { (error) in
                    self.didRequestError(error)
            })
        }
    }
}
extension BindingBankCardVC : UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    // city确定按钮事件
    func sureClick(){
        
        let dic : Dictionary = dataCity[selectComponent]
        
         openProvince =    dataCity[selectComponent]["name"] as! String
        if let name = dic["name"] as? String{
            if  let arr : Array = (dic[name] as AnyObject) as? Array<AnyObject> {
                if let nameDic = arr[selectRow]["name"] {
                    if nameDic != nil {
                        openCityStr = nameDic as! String
                        openCity.text = openProvince + "  " + openCityStr
                    }
                    
                    openCity.resignFirstResponder()
                    selectRow = 0
                    selectComponent = 0
                    cityPickerView.selectRow(selectComponent, inComponent: 0, animated: true)
                    cityPickerView.selectRow(0, inComponent: 1, animated: true)
                }
            }
        }
    }
    func cancelClick(){
        selectRow = 0
        selectComponent = 0
        cityPickerView.selectRow(0
            , inComponent: 0, animated: true)
        cityPickerView.selectRow(0
            , inComponent: 1, animated: true)
        
        
        openCity.resignFirstResponder()
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return dataCity.count
            
        }else{
            
            let dic : Dictionary = dataCity[selectComponent]
            let name = dic["name"] as! String
            let arr : Array = dic[name] as! Array<AnyObject>
            return  arr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return  dataCity[row]["name"] as? String
            
        }else{
            
            let dic : Dictionary = dataCity[selectComponent]
            let name = dic["name"] as! String
            let arr : Array = (dic[name] as AnyObject) as! Array<AnyObject>
            let nameDic = arr[row]["name"]
            return nameDic as? String
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0{
            
            selectComponent = row
            
            openProvince =    dataCity[row]["name"] as! String
            pickerView.reloadComponent(1)
            
        }else{
            
            selectRow = row
            
        }
    }
    
}
