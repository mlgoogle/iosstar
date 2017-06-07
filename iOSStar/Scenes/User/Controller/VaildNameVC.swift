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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "实名认证"
        selectBtn.isSelected = true
    }

    @IBAction func selectClick(_ sender: Any) {
        selectBtn.isSelected = !selectBtn.isSelected
    }
    @IBAction func doVailiName(_ sender: Any) {
        if checkTextFieldEmpty([name,card]){
            
            if selectBtn.isSelected == false{
                SVProgressHUD.showErrorMessage(ErrorMessage: "请先同意免责声明", ForDuration: 1, completion: {
                   
                    
                })
            }
            AppAPIHelper.user().authentication(realname: name.text!, id_card: card.text!, complete: { (result) in
                if let model = result {
                    
                    let dic = model as! [String : AnyObject]
                    if dic["result"] as! Int  == 0 {
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "实名认证成功", ForDuration: 1, completion: {
                            
                            let alertVc = AlertViewController()
                            alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                                
                                                titleLabelText: "你还没有开通支付",
                                                subTitleText: "开通支付之后才可以进行交易",
                                                completeButtonTitle: "我 知 道 了") { (completeButton) in
                                                    alertVc.dismissAlertVc()
                                                    
                                                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "TradePassWordVC")
                                                    self.navigationController?.pushViewController(vc, animated: true )
                                                    return
                            }
//                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }else{
                        SVProgressHUD.showErrorMessage(ErrorMessage: "实名认证失败", ForDuration: 1, completion: {
                            _ = self.navigationController?.popViewController(animated: true)

                        })

                    }
                    
                }
            }) { (error ) in
                
            }

        }
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   
}
