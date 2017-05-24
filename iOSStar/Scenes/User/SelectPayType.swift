//
//  SelectPayType.swift
//  iOSStar
//
//  Created by sum on 2017/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class SelectPayTypeModel : NSObject{
    
    var name : String = ""
    var img : String = ""
    var number : String = ""
    var id  : Int = 0
}
class SelectPayType: UIView,UITableViewDataSource,UITableViewDelegate {
    
    var resultBlock: CompleteBlock?
    var selectNumber = Int()
    var modelArry = [SelectPayTypeModel]()
    @IBOutlet weak var tableView: UITableView!
    
    override func  awakeFromNib() {
        
        tableView.register(UINib.init(nibName: "SelectPayTypeCell", bundle: nil), forCellReuseIdentifier: "SelectPayTypeCell")
        let titleArr = ["微信","支付宝","银联"]
        for i in 0...2  {
            let model = SelectPayTypeModel.init()
            model.name = titleArr[i]
            model.img =  titleArr[i]
            model.number =  titleArr[i]
            model.id =  i
            modelArry.append(model)
        }
        tableView.reloadData()
        tableView.isScrollEnabled = false
    }
    //MARK: tableview的datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPayTypeCell")  as! SelectPayTypeCell
        
        let model = modelArry[indexPath.row]
        
        cell.titleLb.text = model.name
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
        resultBlock!(modelArry[indexPath.row] as AnyObject)
    }
    @IBAction func close(_ sender: Any) {
        self.resultBlock!(1000 as AnyObject)
    }
    
    
}
