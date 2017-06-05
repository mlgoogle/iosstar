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
    }

    @IBAction func doVailiName(_ sender: Any) {
        if checkTextFieldEmpty([name,card]){
            
            AppAPIHelper.user().authentication(realname: name.text!, id_card: card.text!, complete: { (result) in
                if let model = result {
                    
                    let dic = model as! [String : AnyObject]
                    if dic["result"] as! Int  == 0 {
                        SVProgressHUD.showSuccessMessage(SuccessMessage: "实名认证成功", ForDuration: 1, completion: {
                            _ = self.navigationController?.popViewController(animated: true)
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
