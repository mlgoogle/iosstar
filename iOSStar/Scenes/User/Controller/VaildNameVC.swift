//
//  VaildNameVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import  SVProgressHUD
class VaildNameVC:  BaseTableViewController {

    @IBOutlet var selectBtn: UIButton!
    //身份证号
    @IBOutlet weak var card: UITextField!
    //姓名
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var commitButton: UIButton!
    
    var needPwd : Int = 2
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"
        selectBtn.isSelected = true
        commitButton.backgroundColor = UIColor(hexString: AppConst.Color.main)
        self.getUserInfo { (result) in
            if let response = result{
                let object = response as! UserInfoModel
                self.needPwd = object.is_setpwd
            }
        }
        
        
    }

    @IBAction func selectClick(_ sender: Any) {
        selectBtn.isSelected = !selectBtn.isSelected
    }
    @IBAction func doVailiName(_ sender: Any) {
        if checkTextFieldEmpty([name,card]){
            self.name.resignFirstResponder()
            self.card.resignFirstResponder()
            if selectBtn.isSelected == false{
                SVProgressHUD.showErrorMessage(ErrorMessage: "您尚未勾选《免责声明》，请选择", ForDuration: 2.0, completion: nil)
                return
            }

        
                SVProgressHUD.show(withStatus: "加载中")
                let requestModel = AuthenticationRequestModel()
            requestModel.realname = name.text!
            requestModel.id_card = card.text!
            AppAPIHelper.user().authentication(requestModel: requestModel, complete: { (result) in
                if let dic = result as?  [String : AnyObject] {
                    
                      SVProgressHUD.dismiss()
                    if let result = dic["result"] as? Int {
                        if result == 0 {
                            SVProgressHUD.showSuccessMessage(SuccessMessage: "实名认证成功", ForDuration: 2.0, completion: {
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                        }else{
                           SVProgressHUD.showErrorMessage(ErrorMessage: "实名认证失败", ForDuration: 2.0, completion: nil)
                        }
                    }
                }
            }, error: { (error) in
                
            })

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
}
