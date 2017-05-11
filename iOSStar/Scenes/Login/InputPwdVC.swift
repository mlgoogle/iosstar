//
//  InputPwdVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class InputPwdVC: UITableViewController {

    @IBOutlet weak var againPwdTF: UITextField!
    @IBOutlet weak var inputPwdTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    @IBAction func doRegist(_ sender: Any) {
        
        //MARK:- 去注册
        if  ShareDataModel.share().isweichaLogin == true{
            
            let param: [String: Any] = [SocketConst.Key.pwd: againPwdTF.text! ,
                                        SocketConst.Key.phone: ShareDataModel.share().phone,
                                        SocketConst.Key.memberId: "1001",
                                        SocketConst.Key.agentId: "186681261",
                                        SocketConst.Key.recommend: "3tewe",
                                        SocketConst.Key.code: ShareDataModel.share().codeToeken,]

            
            
            let packet :SocketDataPacket = SocketDataPacket.init(opcode: .register, dict:  param as [String : AnyObject])
            BaseSocketAPI.shared().startRequest(packet, complete: { (resule) -> ()? in
                
                
                return ()
                
            }) { (error) -> ()? in
                SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 0.5, completion: {
                    
                })
                return ()
                
            }

        
        
        }
    }

  

}
//SVProgressHUD.show(withStatus: "注册中")
//if checkTextFieldEmpty([againPwdTF,inputPwdTF]) {
//    
//    let param: [String: Any] = [SocketConst.Key.name_value:  ShareDataModel.share().phone,
//                                SocketConst.Key.accid_value:  ShareDataModel.share().phone,]
//    let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
//    
//    BaseSocketAPI.shared().startRequest(packet, complete: { (result) -> ()? in
//        
//        SVProgressHUD.showSuccess(withStatus: "注册成功")
//        let datadic = result as? Dictionary<String,String>
//        if let _ = datadic {
//            
//            UserDefaults.standard.set(ShareDataModel.share().phone, forKey: "phone")
//            UserDefaults.standard.set((datadic?["token_value"])!, forKey: "tokenvalue")
//            UserDefaults.standard.synchronize()
//            self.dismissController()
//            
//        }
//        return ()
//    }) { (error) -> ()? in
//        
//        return
//    }
//    
//}
