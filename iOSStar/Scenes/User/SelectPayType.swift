//
//  SelectPayType.swift
//  iOSStar
//
//  Created by sum on 2017/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SelectPayType: UIView,UITableViewDataSource,UITableViewDelegate {

    var resultBlock: CompleteBlock?
    var selectNumber = Int()
    
    @IBOutlet weak var tableView: UITableView!
    let titleArr = ["微信","支付宝","银联"]
    override func  awakeFromNib() {
        tableView.register(UINib.init(nibName: "SelectPayTypeCell", bundle: nil), forCellReuseIdentifier: "SelectPayTypeCell")
        tableView.isScrollEnabled = false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPayTypeCell")  as! SelectPayTypeCell
        
         cell.titleLb.text = titleArr[indexPath.row]
        if indexPath.row == selectNumber {
            cell.selectImg.image = UIImage.init(named: "timg")

        }else{
            cell.selectImg.image = UIImage.init(named: "")

        }
                  return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         selectNumber = indexPath.row
         tableView.reloadData()
          resultBlock!(indexPath.row as AnyObject)
    }
       @IBAction func close(_ sender: Any) {
        self.resultBlock!(1000 as AnyObject)
    }
    

}
