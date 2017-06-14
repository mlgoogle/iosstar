//
//  BuyOrSellViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class BuyOrSellViewController: DealBaseViewController {
    var identifiers = ["DealStarInfoCell","DealMarketCell","DealOrderInfoCell"]
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
        if realTimeData != nil {
            priceDidChange(price: realTimeData!.currentPrice * Double(600))
        }
        
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
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buyOrSellAction(_ sender: Any) {
        let model = BuyOrSellRequestModel()
        model.buySell = -1
        model.symbol = "1001"
        AppAPIHelper.dealAPI().buyOrSell(requestModel: model, complete: { (response) in
            SVProgressHUD.showSuccess(withStatus: "委托成功")
        }) { (error) in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        YD_CountDownHelper.shared.marketTimeLineRefresh = nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        YD_CountDownHelper.shared.marketTimeLineRefresh = { [weak self] (result)in
            self?.requestRealTime()
        }
    }
    func requestRealTime() {
        let requestModel = RealTimeRequestModel()
        let syModel = SymbolInfo()
        if starListModel != nil {
            syModel.symbol = starListModel!.wid
        } else  {
            return
        }
        requestModel.symbolInfos.append(syModel)
        AppAPIHelper.marketAPI().requestRealTime(requestModel: requestModel, complete: { (response) in
            if let model = response as? [RealTimeModel] {
                self.realTimeData = model.first
                self.tableView.reloadData()
            }
        }) { (error) in
        }
    }

}

extension BuyOrSellViewController:UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, OrderInfoChangeDelegate{ 
    
    func priceDidChange(price:Double) {
        let priceString = String(format: "%.2f", price)
        orderPriceLabel.setAttributeText(text: "总价：\(priceString)", firstFont: 18, secondFont: 18, firstColor: UIColor(hexString: "999999"), secondColor: UIColor(hexString: "FB9938"), range: NSRange(location: 3, length: priceString.length()))
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        tableView.endEditing(true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeights[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row], for: indexPath)
        
        switch indexPath.row {
        case 0:
            if let infoCell = cell as? DealStarInfoCell{
                infoCell.setupData(model:starListModel)
            }
        case 1:
            if let marketCell = cell as? DealMarketCell {
                marketCell.setRealTimeData(model: realTimeData)
            }
            
        case 2:
            if let orderCell = cell as? DealOrderInfoCell {
                orderCell.count = 600
                
                orderCell.delegate = self
                guard realTimeData != nil else {
                    return orderCell
                }
                orderCell.price = realTimeData!.currentPrice
                
                orderCell.setPriceAndCount(price:realTimeData!.currentPrice, count:600)
            }
        default:
            break
        }
        return cell
    }
}
