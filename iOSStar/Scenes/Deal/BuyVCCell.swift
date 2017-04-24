//
//  SellOutCell.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class StatusCell: UITableViewCell {
    
    
}
class BuyVCCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate{
    
    //var 判断是买入还是卖出
    //UITableView 的宽度
    @IBOutlet weak var tableView_Width: NSLayoutConstraint!
    //价格
    @IBOutlet weak var price: UITextField!
    //数量
    @IBOutlet weak var count: UITextField!
    //名字
    @IBOutlet weak var nameLB: UILabel!
    //显示价格tableview
    @IBOutlet weak var tableView: UITableView!
    //价格下调
    @IBOutlet weak var priceDown: UIButton!
    //价格上涨
    @IBOutlet weak var priceUp: UIButton!
    //数量上涨
    @IBOutlet weak var countUp: UIButton!
    //数量下调
    @IBOutlet weak var countDown: UIButton!
    //购买
    @IBOutlet weak var buyBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        self.count.layer.borderWidth = 1
        self.count.layer.borderColor = UIColor.gray.cgColor
        self.count.clipsToBounds = true
        self.count.layer.cornerRadius = 1
        self.tableView.layer.borderColor = UIColor.gray.cgColor
        self.tableView.layer.borderWidth = 1
        self.tableView.clipsToBounds = true
        self.tableView.layer.cornerRadius = 1
        self.tableView_Width.constant = UIScreen.main.bounds.size.width/320.0 * 130
        
        // Initialization code
    }
    //MARK: btn的点击方法
    @IBAction func countUp(_ sender: Any) {
    }
    @IBAction func countDown(_ sender: Any) {
    }
    @IBAction func priceDown(_ sender: Any) {
    }
    @IBAction func priceUp(_ sender: Any) {
    }
    
    //MARK: tableview代理
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell")
        
        if indexPath.row == 5 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "LineCell")
              return cell!
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5{
         return 10
        }
        return 17
    }

}
