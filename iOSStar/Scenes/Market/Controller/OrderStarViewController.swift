//
//  OrderStarViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class OrderType : UITableViewCell{



}
class OrderStarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
   


    @IBOutlet weak var tableView: UITableView!
    //定义pickerView
    var datePicker = UIDatePicker()
    //定义显示下面的datePicker
    var dateToolBar = UIToolbar()
    //发送验证码的btn
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "柳岩"
       
        initdatePicker()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        

        // Do any additional setup after loading the view.
    }
    func keyBoardWillShow(_ notification: Notification){
    
//        tableView.
       
        tableView.scrollToRow(at: NSIndexPath.init(row: 4, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
              let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTime")
              cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCity")
                cell?.selectionStyle = .none
            return cell!
        }
        if indexPath.row == 4{
            
                 let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbackCell")
            //FeedbackCell
                cell?.selectionStyle = .none
            return cell!
        }
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
        UIView.animate(withDuration: 0.25, animations: { 
            self.dateToolBar.frame = CGRect.init(x: 0, y: self.view.frame.size.height - 120, width:  self.view.frame.size.width, height: 120)
        })
        }
    }
    // MARK: -initdatePicker
    func initdatePicker(){
        
        datePicker =  UIDatePicker.init(frame: CGRect.init(x: 0, y:self.view.frame.size.height , width: self.view.frame.size.width, height: 120))
//        timeTF.inputView = datePicker
        dateToolBar = UIToolbar.init(frame:  CGRect.init(x: 0, y: self.view.frame.size.height - self.dateToolBar.frame.size.height - 44.0, width: self.view.frame.size.width, height: 44))
        
       
        
        let local = Locale.init(identifier: "zh_CN")
        datePicker.locale = local
        datePicker.datePickerMode = .time
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
    
    func datesureClick(){
    }
    func datecancelClick(){
    }
   

}
