//
//  ContactListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "名人通讯录"
        
        onlogin()
    }
    
    func onlogin(){
        
        if  UserDefaults.standard.object(forKey: "tokenvalue") == nil{
             _ = navigationController?.popToRootViewController(animated: true)
            let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            present(controller!, animated: true, completion: nil)
            
        }else{
            
            
            let token = UserDefaults.standard.object(forKey: "tokenvalue") as! String
            let phone = UserDefaults.standard.object(forKey: "phone") as! String
         
            NIMSDK.shared().loginManager.login(phone, token: token) { (error) in
                
                if error == nil  {
                  
                    print(1222)
                    
                }else{
                    
                }
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ContactListViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let session = NIMSession("13569365931", type: .P2P)
//        let vc = NTESSessionViewController(session: session)
//        
//        self.navigationController?.pushViewController(vc!, animated: true)

        let alertview : UIAlertController = UIAlertController.init(title: "请输入对方手机号", message: "对方手机号", preferredStyle: UIAlertControllerStyle.alert)
        alertview.addTextField { (textField: UITextField!) in
            textField.placeholder  = "请输入对方手机号"
        }
        let alertViewAction: UIAlertAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            
            let string  = alertview.textFields?[0].text
            
            if isTelNumber(num: string!){
                
                let session = NIMSession(string!, type: .P2P)
                let vc = NTESSessionViewController(session: session)
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            
            
        })
        let alertViewCancelAction: UIAlertAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        alertview.addAction(alertViewAction)
        alertview.addAction(alertViewCancelAction)
        self.present(alertview, animated:true , completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
