//
//  YDSSessionViewController.swift
//  iOSStar
//
//  Created by sum on 2017/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class YDSSessionViewController: NIMSessionViewController {
    var isbool : Bool = false
    var starcode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(hexString: "FAFAFA")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.creatRightBarButtonItem(title: "星聊须知", target: self, action: #selector(rightButtonClick))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ShareDataModel.share().voiceSwitch = true
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ShareDataModel.share().voiceSwitch = false
    }
    
    func rightButtonClick() {
        let vc = BaseWebVC()
        vc.loadRequest = "http://122.144.169.219:3389/talk"
        vc.navtitle = "星聊须知"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func send(_ message: NIMMessage!) {

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
}
