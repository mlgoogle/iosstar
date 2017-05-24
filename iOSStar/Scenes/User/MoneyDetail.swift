//
//  MoneyDetail.swift
//  iOSStar
//
//  Created by sum on 2017/5/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class RechargeListVCCell: OEZTableViewCell {
    
    @IBOutlet weak var weekLb: UILabel!            // 姓名LbstatusLb
    @IBOutlet weak var timeLb: UILabel!            // 时间Lb
    @IBOutlet weak var moneyCountLb: UILabel!      // 充值金额Lb
    @IBOutlet weak var statusLb: UILabel!          // 状态Lb
    @IBOutlet weak var minuteLb: UILabel!          // 分秒
    @IBOutlet weak var bankLogo: UIImageView!      // 银行卡图片
    @IBOutlet weak var withDrawto: UILabel!        // 提现至
   
}

class MoneyDetail: BaseCustomListTableViewController {

     var contentoffset = CGFloat()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "资金明细"
  
        let btn = UIButton.init(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let right = UIBarButtonItem.init(customView: btn)
    
        btn.addTarget(self , action: #selector(selectDate), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = right
        ShareDataModel.share().addObserver(self, forKeyPath: "selectMonth", options: .new, context: nil)
    }
    
    override func didRequest(_ pageIndex : Int) {
    
    
    }
    //MARK-
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        if keyPath == "selectMonth" {
            
            if let selectMonth = change? [NSKeyValueChangeKey.newKey] as? String {
                
                self.tableView.isScrollEnabled = true
                if selectMonth != "1000000" {
//                    monthLb.text = "2017年" + " " + "\(selectMonth)" + "月"
                }
            }
        }
    }
    deinit {
        ShareDataModel.share().removeObserver(self, forKeyPath: "selectMonth", context: nil)
    }
    // MARK: - Table view data source

   
//     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 20
//    }
//
//    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    

        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeListVCCell")
       

        return cell!
    }

    func selectDate(){
        
        let customer : CustomeAlertView = CustomeAlertView.init(frame: CGRect.init(x: 0, y: -35, width: self.view.frame.size.width, height: self.view.frame.size.height + 40))
        tableView.isScrollEnabled = false
        self.view.addSubview(customer)
    }
    
  

}
