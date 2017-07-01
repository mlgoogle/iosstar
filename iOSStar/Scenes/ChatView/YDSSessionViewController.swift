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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatRightBarButtonItem(title: "星聊须知", target: self, action: #selector(rightButtonClick))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ShareDataModel.share().voiceSwitch = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ShareDataModel.share().voiceSwitch = false
    }
    
    func rightButtonClick() {
        
//        print("点击了右边的按钮吧")
        let vc = BaseWebVC()
        vc.loadRequest = "http://122.144.169.219:3389/talk"
        vc.navtitle = "星聊须知"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //- (void)sendMessage:(NIMMessage *)message
    
    override func send(_ message: NIMMessage!) {
        
        // 消息类型 message.messageType
        // self.starcode
        
//        super.send(message)

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
