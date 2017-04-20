//
//  HomeVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
      
        let str : NSString = "asdf1234"
        
        let pass : String = str.tokenByPassword()
        let btn = UIButton.init(type: .custom)
        btn.addTarget(self , action: #selector(popself), for: .touchUpInside)
        btn.frame = CGRect.init(x: 0, y: 0, width: 100, height: 200)
        self.view.addSubview(btn)
       
        NIMSDK.shared().loginManager.login("15306559323", token: pass as String) { (error) in
            if error == nil{
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    func popself(){
        let session = NIMSession.init("13569365932", type: .P2P)
        
        let vc = NTESSessionViewController.init(session: session)
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
