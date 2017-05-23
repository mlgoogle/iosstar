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
        
        
        AppAPIHelper.friend().reducetime(phone: "", starcode: "reducetime", complete: { (result)  in
            
        }) { (error) in
        }
        if isbool == false{
         super.send(message)
        }else{
            
            super.send(message)
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
