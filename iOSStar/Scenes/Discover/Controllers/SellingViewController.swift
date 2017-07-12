//
//  SellingViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SellingViewController: UIViewController {
    @IBOutlet weak var sureBuyButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //倒计时剩余时间
    var remainingTime = 0
    
    var starInfoModel:PanicBuyInfoModel?
    
    var starModel:StarSortListModel?
    var sectionHeights = [200, 70, 50, 65, 60, 50]
    var identifiers = [SellingIntroCell.className(), SellingTimeAndCountCell.className(), SellingCountDownCell.className(), SellingBuyCountCell.className(), SellingPriceCell.className(), SellingTipsCell.className()]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发售"
        setPriceWithPrice(price: 0)
        requestRemainTime()
        requestPanicBuyStarInfo()

        YD_CountDownHelper.shared.countDownRefresh = { [weak self] (result) in
            

            if self!.remainingTime > 0 {
                
                self?.remainingTime -= 1
            }
            
            if let cell = self?.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? SellingCountDownCell {
                cell.setRemainingTime(count: self!.remainingTime)
            }
            
            
        }
        YD_CountDownHelper.shared.start()
    }
    deinit {
        YD_CountDownHelper.shared.countDownRefresh = nil    
    }
    
    func setPriceWithPrice(price:Double) {
        let priceString = String(format: "%.2f", price)
        let text = "合计: ￥\(priceString)"
        
        totalPriceLabel.setAttributeText(text: text, firstFont: 16, secondFont: 16, firstColor: UIColor(hexString: "333333"), secondColor: UIColor(hexString: "FB9938"), range: NSRange(location: 4, length: text.length() - 4))
        
        
    }
    func requestRemainTime() {
        guard starModel != nil else {
            return
        }
        let requestModel = BuyRemainingTimeRequestModel()
        requestModel.symbol = starModel!.symbol
        AppAPIHelper.discoverAPI().requestBuyRemainingTime(requestModel: requestModel, complete: { (response) in
            
            if let model = response as? BuyRemainingTimeModel {
                self.remainingTime = Int(model.remainingTime)
            }
        }) { (error) in
            
        }
    }
    
    func requestPanicBuyStarInfo() {
        guard starModel != nil else {
            return
        }
        let requestModel = PanicBuyRequestModel()
        requestModel.symbol = starModel!.symbol
        AppAPIHelper.discoverAPI().requsetPanicBuyStarInfo(requestModel: requestModel, complete: { (response) in
    
            if let model = response as? PanicBuyInfoModel {
                self.starInfoModel = model
                self.tableView.reloadData()
            }
        }) { (error) in
            
        }
        
    }

    @IBAction func buyAction(_ sender: Any) {
        
        guard starModel != nil else {
            return
        }
        let requestModel = BuyStarTimeRequestModel()
        requestModel.amount = 10
        requestModel.price = 1.01
        requestModel.symbol = starModel!.symbol
        
        AppAPIHelper.discoverAPI().buyStarTime(requestModel: requestModel, complete: { (response) in
            
            
            
        }) { (error) in
            
        }
    }
}

extension SellingViewController:UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        tableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sectionHeights[indexPath.row])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row]!, for: indexPath)
        switch indexPath.row {
        case 2:
            if let countDownCell = cell as? SellingCountDownCell {
                countDownCell.setRemainingTime(count:remainingTime)
            }
        case 3:
            if let buyCountCell = cell as? SellingBuyCountCell {
                buyCountCell.countTextField.delegate = self

            }
        case 5:
            if let tipsCell = cell as? SellingTipsCell {
                return tipsCell
            }
        default:
            break
        }
        if let baseCell = cell as? SellingBaseCell {
            baseCell.setPanicModel(model: starInfoModel)
        }
        return cell
    }
    
}
