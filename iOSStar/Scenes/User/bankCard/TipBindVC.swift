//
//  TipBindVC.swift
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
class TipBindVC: UIViewController {
    var resultBlock: CompleteBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func bindCard(_ sender: Any) {
        self.resultBlock!(doTipClick.doVail as AnyObject)
        
    }

    @IBAction func close(_ sender: Any) {
        self.resultBlock!(doTipClick.doClose as AnyObject)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissController()
    }
   
}
