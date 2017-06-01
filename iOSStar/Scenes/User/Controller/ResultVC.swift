//
//  ResultVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ResultVC: UITableViewController {

    //明星的图片
    @IBOutlet weak var img: UIImageView!
    //金额
    @IBOutlet weak var money: UILabel!
    //状态
    @IBOutlet weak var status: UILabel!
    //银行
    @IBOutlet weak var bank: UILabel!
    //创建时间
    @IBOutlet weak var create: UILabel!
    //设置手续费具体金额
    @IBOutlet weak var feeMoney: UILabel!
    //创建时间
    @IBOutlet weak var creteTime: UILabel!
    //银行名称
    @IBOutlet weak var bankInfo: UILabel!
    //手续费
    @IBOutlet weak var feedBack: UILabel!
    
    
    var responseData : Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(self.responseData as! Model)")
        
        self.tableView.tableFooterView = UIView()
        
    }


   
}
