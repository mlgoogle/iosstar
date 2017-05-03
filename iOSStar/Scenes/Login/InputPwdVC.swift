//
//  InputPwdVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class InputPwdVC: UITableViewController {

    @IBOutlet weak var againPwdTF: UITextField!
    @IBOutlet weak var inputPwdTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    @IBAction func doRegist(_ sender: Any) {
        
        if checkTextFieldEmpty([againPwdTF,inputPwdTF]) {
            
            let param: [String: Any] = [SocketConst.Key.name_value:  ShareDataModel.share().phone,
                                        SocketConst.Key.accid_value:  ShareDataModel.share().phone,]
            let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
            
            BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
                
                let datadic = result as? Dictionary<String,String>
                if let _ = datadic {
                 
                    UserDefaults.standard.set(ShareDataModel.share().phone, forKey: "phone")
                    UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
                     self.dismissController()
                    
                }
                return ()
            }) { (error) -> ()? in
                
                return
            }
            
        }
      
    }

  

}
