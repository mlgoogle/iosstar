//
//  SellOutCell.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class StatusCell: UITableViewCell {
    
    override func awakeFromNib() {
        
    }
}
class BuyVCCell: UITableViewCell ,UITableViewDataSource,UITableViewDelegate{
    
    //var 判断是买入还是卖出
    var isSellout : Bool = false {
        didSet{
       
        buyBtn.setTitle(isSellout == false ? "买入" : "卖出", for: .normal)
        }
    }
    @IBOutlet weak var bordor: UILabel!

    @IBOutlet weak var line: UILabel!
    //价格
    @IBOutlet weak var price: UITextField!
    //数量
    @IBOutlet weak var count: UITextField!
    //名字
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var selltableView: UITableView!
    //显示价格tableview
    @IBOutlet weak var buytableView: UITableView!
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
        selltableView.delegate = self
        selltableView.dataSource = self
        buytableView.delegate = self
        buytableView.dataSource = self

       
        nameTF.layer.borderColor = transferStringToColor("185CA5").cgColor
        bordor.layer.borderColor = transferStringToColor("185CA5").cgColor
        line.layer.borderColor = transferStringToColor("185CA5").cgColor
       
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
        
       
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 16
    }

}
