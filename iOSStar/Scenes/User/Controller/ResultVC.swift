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
    // 标题信息
    @IBOutlet weak var titleInfo: UILabel!
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
        
        title = "账单详情"
        
        //  获取上个界面传过来的model
        let model = self.responseData as! Model
        
        self.money.text = "+" + " "  + String.init(format: "%.2f", model.amount)
        self.status.text = model.status == 1 ? "处理中" : (model.status == 2 ?  "充值成功":  "充值失败")
        self.bankInfo.text = model.depositType == 1 ? "微信支付" :"银行卡"
        self.img.image = model.depositType == 1 ? UIImage(named: "fukuanxuanxiang_weixin") : UIImage(named: "支付宝")
        self.titleInfo.text = self.bankInfo.text
        let timestr : Int = Date.stringToTimeStamp(stringTime: model.depositTime)
        self.creteTime.text = Date.yt_convertDateStrWithTimestempWithSecond(timestr, format: "yyyy-MM-dd")
        
        self.tableView.tableFooterView = UIView()
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)//点击完成，取消高亮
        
    }

   
}
