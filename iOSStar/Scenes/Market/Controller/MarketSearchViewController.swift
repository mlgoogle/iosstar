//
//  MarketSearchViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class MarketSearchViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!
    var dataArry = [MarketClassifyModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        backView.layer.cornerRadius = 1
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = "搜索"
        //
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(hexString: AppConst.Color.main)
        navigationItem.titleView = label
        searchTextField.addTarget(self , action:#selector(textfiledchange(_:)), for: .editingChanged)
        searchTextField.delegate = self
    }
    func textfiledchange(_ textField: UITextField){
        
        if textField.text == "" {
            dataArry.removeAll()
            tableView.reloadData()
            return
        }
        AppAPIHelper.marketAPI().searchstar(code: textField.text!, complete: { [weak self](result) in
            if let _ = result {
                self?.dataArry = result as! [MarketClassifyModel]
                self?.tableView.reloadData()
            }
        }) { [weak self](error) in
            self?.dataArry.removeAll()
            self?.tableView.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            dataArry.removeAll()
            tableView.reloadData()
            return false
        }
        AppAPIHelper.marketAPI().searchstar(code: textField.text!, complete: { [weak self](result) in
            if let _ = result {
                self?.dataArry = result as! [MarketClassifyModel]
                self?.tableView.reloadData()
                
            }
        }) { [weak self](error) in
            self?.dataArry.removeAll()
            self?.tableView.reloadData()
        }
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MarketSearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        
        cell.update(dataArry[indexPath.row])
        
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
