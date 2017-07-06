//
//  CustomeAlertView.swift
//  wp
//
//  Created by sum on 2017/1/9.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit

protocol CustomeAlertViewDelegate {
    
    func didSelectMonth(index:Int)
}


class CustomeAlertView : UIView,UITableViewDelegate,UITableViewDataSource {
    
    // 代理属性
    var delegate :CustomeAlertViewDelegate?
    
    //大背景view
    var bgView = UIView()
    
    var tableView = UITableView()
    
    var dateArr = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // dateBtn.frame = CGRect.init(x: self.view.frame.size.width-100, y: 10, width: 80, height: 20)
        tableView = UITableView.init(frame: CGRect.init(x:self.frame.size.width-120, y:-40, width: 110, height: 0), style: UITableViewStyle.plain)
        
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        
        tableView.clipsToBounds = true
        
        tableView.layer.cornerRadius = 5;
        
        tableView.dataSource = self
        
        self.addSubview(tableView)
        
        bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.1);
        
        self.addSubview(bgView)
        
        self.addSubview(tableView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(removeFromView))
        
        bgView.addGestureRecognizer(tap)
        
        tableView.removeGestureRecognizer(tap)
        addAnimation()
    }
    
    func removeFromView(){
        
        ShareDataModel.share().selectMonth = "\(1000000)"
        UIView.animate(withDuration: 0.25) {
            
            self.removeFromSuperview()
        }
        
    }
    
    func addAnimation(){
        
        UIView.animate(withDuration: 0.25) {
            
            self.tableView.frame = CGRect.init(x:self.frame.size.width-120, y:45, width: 110, height: 200)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 表的代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return dateArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell :UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        
        cell.textLabel?.text = dateArr[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        cell.textLabel?.textColor = UIColor.init(hexString: "333333")
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        ShareDataModel.share().selectMonth = "\(indexPath.row + 1)"
        
        // 代理
        if self.delegate != nil {
            delegate?.didSelectMonth(index: (indexPath.row + 1))
        }
        
        UIView.animate(withDuration: 0.1) {
            self.removeFromSuperview()
        }
        
    }
    
}

class CustomeShowBankView : UIView,UITableViewDelegate,UITableViewDataSource {
    
    // 代理属性
    var delegate :CustomeAlertViewDelegate?
    
    //大背景view
    var bgView = UIView()
    
    var tableView = UITableView()
    
    var dateArr = ["钱包明细","银行卡"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // dateBtn.frame = CGRect.init(x: self.view.frame.size.width-100, y: 10, width: 80, height: 20)
        tableView = UITableView.init(frame: CGRect.init(x:self.frame.size.width-120, y:-40, width: 110, height: 0), style: UITableViewStyle.plain)
        
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        
        tableView.clipsToBounds = true
        
        tableView.layer.cornerRadius = 5;
        
        tableView.dataSource = self
        
        self.addSubview(tableView)
        
        bgView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.1);
        
        self.addSubview(bgView)
        
        self.addSubview(tableView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(removeFromView))
        
        bgView.addGestureRecognizer(tap)
        
        tableView.removeGestureRecognizer(tap)
        addAnimation()
    }
    
    func removeFromView(){
        
        ShareDataModel.share().selectMonth = "\(1000000)"
        UIView.animate(withDuration: 0.25) {
            
            self.removeFromSuperview()
        }
        
    }
    
    func addAnimation(){
        
        UIView.animate(withDuration: 0.25) {
            
            self.tableView.frame = CGRect.init(x:self.frame.size.width-120, y:60, width: 110, height: 80)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 表的代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return dateArr.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell :UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        
        cell.textLabel?.text = dateArr[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        cell.textLabel?.textAlignment = NSTextAlignment.center
        
        cell.textLabel?.textColor = UIColor.init(hexString: "333333")
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        // 代理
        if self.delegate != nil {
            delegate?.didSelectMonth(index: (indexPath.row ))
        }
        
        UIView.animate(withDuration: 0.1) {
            self.removeFromSuperview()
        }
        
    }
    
}
