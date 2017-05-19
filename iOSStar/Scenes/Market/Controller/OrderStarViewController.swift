//
//  OrderStarViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class OrderType : UITableViewCell{
    
    @IBOutlet weak var orderAccount: UILabel!
    @IBOutlet weak var orderType: UILabel!
    
    @IBOutlet weak var inputType: UITextField!
    
}
class OrderStarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var inputPalace: UITextField!
    var orderTime: UILabel!
    var orderPalace: UILabel!
    var dataCity = Array<Dictionary<String, AnyObject>>()
    var selectRow = 0
    var selectComponent = 0
    @IBOutlet weak var inputType: UITextField!
    @IBOutlet weak var tableView: UITableView!
    //定义pickerView
    var datePicker = UIDatePicker()
    //定义显示下面的datePicker
    var dateToolBar = UIToolbar()
    //定义pickerView
    var pickView = UIPickerView()
    //定义显示下面的datePicker
    var myToolBar = UIToolbar()
    
    //发送验证码的btn
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "柳岩"
        initCity()
        initdatePicker()
        initpalace()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    func keyBoardWillShow(_ notification: Notification){
        tableView.scrollToRow(at: NSIndexPath.init(row: 4, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    //MARK: tableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 181
        }
        if indexPath.row == 1{
            return 197
        }
        if indexPath.row == 2{
            return 45
        }
        if indexPath.row == 3{
            return 45
        }
        if indexPath.row == 4{
            return 200
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BannerCell")
        if indexPath.row == 0{
            cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell")
            cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTime") as! OrderType
            orderTime = cell.orderAccount
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCity") as! OrderType
            cell.selectionStyle = .none
            orderPalace = cell.orderAccount
            return cell
        }
        if indexPath.row == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell")
            cell?.selectionStyle = .none
            return cell!
        }
        return cell!
        
    }
    func initCity(){
        let address : String =  Bundle.main.path(forResource: "City", ofType: "plist")!
        let dic =  NSDictionary.init(contentsOfFile: address) as! [String : Array<Any>]
        
        dataCity = dic["city"]! as! Array<Dictionary<String, AnyObject>> as Array<Dictionary<String, AnyObject>>
        print(dataCity)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            inputType.becomeFirstResponder()
            
        }
        if indexPath.row == 3{
            
            inputPalace.becomeFirstResponder()
            
        }
    }
    // MARK: initdata
    func initpalace(){
        
        pickView = UIPickerView.init()
        pickView.delegate = self
        
        pickView.dataSource = self
        
        myToolBar = UIToolbar.init(frame:  CGRect.init(x: 0, y: self.view.frame.size.height - self.myToolBar.frame.size.height - 44.0, width: self.view.frame.size.width, height: 44))
        
        inputPalace.inputView = pickView
        inputPalace.inputAccessoryView = myToolBar
        
        let sure : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 44))
        sure.setTitle("确定", for: .normal)
        let sureItem : UIBarButtonItem = UIBarButtonItem.init(customView: sure)
        sure.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let space : UIButton = UIButton.init(frame: CGRect.init(x: 40, y: 0, width: self.view.frame.size.width-140, height: 44))
        space.setTitle("", for: .normal)
        sure.addTarget(self, action: #selector(sureClick), for: .touchUpInside)
        let spaceItem : UIBarButtonItem = UIBarButtonItem.init(customView: space)
        let cancel : UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width-44, y: 0, width: 40, height: 44))
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let cancelItem : UIBarButtonItem = UIBarButtonItem.init(customView: cancel)
        myToolBar.setItems([sureItem,spaceItem,cancelItem], animated: true)
        
    }
    func sureClick(){
        
        let dic : Dictionary = dataCity[selectComponent]
        let name = dic["name"] as! String
        let arr : Array = (dic[name] as AnyObject) as! Array<AnyObject>
        let nameDic = arr[selectRow]["name"]
        orderPalace.text = nameDic as? String
        inputPalace.resignFirstResponder()
        selectRow = 0
        selectComponent = 0
        pickView.selectRow(selectComponent
            , inComponent: 0, animated: true)
        pickView.selectRow(0
            , inComponent: 1, animated: true)
      
    }
    func cancelClick(){
        selectRow = 0
        selectComponent = 0
        pickView.selectRow(0
            , inComponent: 0, animated: true)
        pickView.selectRow(0
            , inComponent: 1, animated: true)
    
        
        inputPalace.resignFirstResponder()
        
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
            pickerView.reloadComponent(1)
        }else{
            selectRow = row
        }
    }
    //MARK: initdatePicker
    func initdatePicker(){
        datePicker =  UIDatePicker.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 120))
        inputType.inputView = datePicker
        dateToolBar = UIToolbar.init(frame:  CGRect.init(x: 0, y: self.view.frame.size.height - self.dateToolBar.frame.size.height - 44.0, width: self.view.frame.size.width, height: 44))
        
        inputType.inputAccessoryView = dateToolBar
        
        let local = Locale.init(identifier: "zh_CN")
        datePicker.locale = local
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(dateValueChange(_:)), for: .valueChanged)
        let sure : UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 44))
        sure.setTitle("确定", for: .normal)
        let sureItem : UIBarButtonItem = UIBarButtonItem.init(customView: sure)
        sure.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let space : UIButton = UIButton.init(frame: CGRect.init(x: 40, y: 0, width: self.view.frame.size.width-140, height: 44))
        space.setTitle("", for: .normal)
        sure.addTarget(self, action: #selector(datesureClick), for: .touchUpInside)
        let spaceItem : UIBarButtonItem = UIBarButtonItem.init(customView: space)
        let cancel : UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width-44, y: 0, width: 40, height: 44))
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(datecancelClick), for: .touchUpInside)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        cancel.setTitleColor(UIColor.init(hexString: "666666"), for: .normal)
        let cancelItem : UIBarButtonItem = UIBarButtonItem.init(customView: cancel)
        dateToolBar.setItems([sureItem,spaceItem,cancelItem], animated: true)
        
    }
    //MARK: 时间改变值
    func dateValueChange(_ pickerView : AnyObject){
        let picker = pickerView as! UIDatePicker
        let time =    Date.yt_convertDateToStr(picker.date, format: "HH:mm")
        orderTime.text  = time
        
    }
    func datesureClick(){
        
        inputType.resignFirstResponder()
    }
    func datecancelClick(){
        inputType.resignFirstResponder()
    }
  
}
