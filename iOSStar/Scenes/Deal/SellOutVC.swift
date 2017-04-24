//
//  SellOutVC.swift
//  iOSStar
//
//  Created by sum on 2017/4/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellOutVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if section == 0{
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellOutCell")
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1{
            return 40
        }
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2{
            return  0.001
        }
        return 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var view : UIView?
        if section == 1{
            
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
