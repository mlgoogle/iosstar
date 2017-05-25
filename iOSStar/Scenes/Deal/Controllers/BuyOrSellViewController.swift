//
//  BuyOrSellViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BuyOrSellViewController: UIViewController {
    var identifiers = ["DealStarInfoCell","DealMarketCell","DealOrderInfoCell","DealHintCell"]
    var rowHeights = [137, 188,133,82]
    var dealType:AppConst.DealType = AppConst.DealType.sell {
        didSet {
            buyOrSellButton.setTitle("确认求购", for: .normal)
        }
    }
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var orderPriceLabel: UILabel!
    
    @IBOutlet weak var buyOrSellButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    func keyboardWillShow(notification: NSNotification?) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -100, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    func keyboardWillHide(notification: NSNotification?) {

        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    deinit {
    
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BuyOrSellViewController:UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UITextFieldDelegate {
    


    func scrollViewDidScroll(_ scrollView: UIScrollView){
        tableView.endEditing(true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeights[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row], for: indexPath)
        
        return cell
    }
}
