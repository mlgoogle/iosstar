//
//  TipBindCardVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/4.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
enum doTipClick{
    case doClose    //  关闭
    case doVail     //  去实名认证
  
    
}
class TipBindCardVC: UIViewController {
    var resultBlock: CompleteBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bindCard(_ sender: Any) {
        self.resultBlock!(doTipClick.doVail as AnyObject)
//        self.dismissController()
        
    }

    @IBAction func close(_ sender: Any) {
        self.resultBlock!(doTipClick.doClose as AnyObject)
    }
   
}
