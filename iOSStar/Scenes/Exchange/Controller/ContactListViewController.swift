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
            self.navigationController?.popToRootViewController(animated: true)
            let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            present(controller!, animated: true, completion: nil)
            
            //            self.navigationController?.popViewController(animated: true)
            
        }else{
            
            
            let token = UserDefaults.standard.object(forKey: "tokenvalue") as! String
            let phone = UserDefaults.standard.object(forKey: "phone") as! String
            NIMSDK.shared().loginManager.login(phone, token: token) { (error) in
                
                if error == nil  {
                  
                    
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
        
        var phone = ""
        if ShareDataModel.share().phone != "" {
           phone = ShareDataModel.share().phone
        }else{
            phone = "15306559323"
        }
        let session = NIMSession("15306559323", type: .P2P)
        let vc = NTESSessionViewController(session: session)

        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
