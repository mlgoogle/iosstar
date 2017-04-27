//
//  BuyVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BuyVC: UIViewController ,UITableViewDelegate ,UITableViewDataSource {

    var isSellout : Bool = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        if section == 1{
            return 1
        }
        if section == 2{
            return 380
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
    
        let cell : BuyVCCell = tableView.dequeueReusableCell(withIdentifier: "BuyVCCell") as! BuyVCCell
        if indexPath.section == 1 {
            
            cell.isSellout = isSellout
            return cell
            //OrderListCell
        }else{
             let cell : OrderListCell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell") as! OrderListCell
            return cell
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 1 ? 360 : 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  section == 0 || section == 2{
         return 40
        }
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return  0.001

        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     
        var view : UIView?
        
        
        if section == 0{
            
            view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            view?.backgroundColor = UIColor.white
        
             let titleLb = UILabel.init(frame: CGRect.init(x: 17 , y: 0, width: 40, height: 40))

             view?.addSubview(titleLb)
             titleLb.text = "当日成交"
             titleLb.font = UIFont.systemFont(ofSize: 10)
             titleLb.textColor = UIColor.black
             titleLb.textAlignment = .center
            
            let contentLb = UILabel.init(frame: CGRect.init(x: 57 , y: 0, width: 300, height: 40))
            
            view?.addSubview(contentLb)
            contentLb.text = "2.00 + 0.12 + 6.38%"
            contentLb.font = UIFont.systemFont(ofSize: 10)
            contentLb.textColor = UIColor.black
            contentLb.textAlignment = .center
            
            let btn  = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.size.width - 17, y: 15, width: 15, height: 15))
            
            view?.addSubview(btn)
           
            btn.backgroundColor = UIColor.red
            
            return view
        }
        if section == 2{
        
            view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            view?.backgroundColor = UIColor.white
            let arr = ["名称/代码","持有/可转(秒)","现价／成本(元)","盈亏(元)"]
            
            for i in 0...arr.count-1 {
                let titleLb = UILabel.init(frame: CGRect.init(x: CGFloat.init(i)*(UIScreen.main.bounds.size.width / 4.0), y: 0, width: UIScreen.main.bounds.size.width / 4.0, height: 40))
                print(i)
                view?.addSubview(titleLb)
                titleLb.text = arr[i]
                titleLb.font = UIFont.systemFont(ofSize: 10)
                titleLb.textColor = UIColor.black
                titleLb.textAlignment = .center
            
            }
            
            return view
        }
        return view
    }

}
