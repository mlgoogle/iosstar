//
//  YDSSessionViewController.swift
//  iOSStar
//
//  Created by sum on 2017/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class YDSSessionViewController: NTESSessionViewController {

    var isbool : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.backgroundColor = UIColor.init(hexString: "FAFAFA")
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //- (void)sendMessage:(NIMMessage *)message
    
    override func send(_ message: NIMMessage!) {
        
        // 消息类型 message.messageType
        // self.starcode
        
        super.send(message)

        if let phone = UserDefaults.standard.object(forKey: "phone") as? String {
          
            let requestModel = ReduceTimeModel()
            requestModel.starcode = starcode
            requestModel.phone = phone
            requestModel.deduct_amount = 1
            AppAPIHelper.user().reduceTime(requestModel: requestModel, complete: { (response) in
                super.send(message)

            }, error: { (error) in
                super.send(message)
                
            })

        }
        

       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
