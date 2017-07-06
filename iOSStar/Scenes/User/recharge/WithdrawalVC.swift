//
//  WithdrawalVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class WithdrawalVC: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "提现"
        let  navLeft = UIButton.init(type: .custom)
        navLeft.setTitle("提现记录", for: .normal)
        navLeft.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        navLeft.setTitleColor(UIColor.init(hexString: "333333"), for: .normal)
        navLeft.frame = CGRect.init(x: 0, y: 0, width: 60, height: 20)
        let right = UIBarButtonItem.init(customView: navLeft)
       
        navLeft.addTarget(self , action: #selector(selectDate), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = right
       
    }
    func selectDate(){
    
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "WithDrawaListVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //全部提现
    @IBAction func withDrawAll(_ sender: Any) {
    }
    //忘记密码
    @IBAction func forgotPwd(_ sender: Any) {
        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }

   

}
