//
//  DealOrderInfoCell.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealOrderInfoCell: UITableViewCell,UITextFieldDelegate {
    @IBOutlet weak var countReduceButton: UIButton!
    
    @IBOutlet weak var countPlusButton: UIButton!
    
    @IBOutlet weak var priceReducButton: UIButton!
    
    @IBOutlet weak var pricePlusButton: UIButton!
    @IBOutlet weak var priceInfoLabel: UILabel!
    @IBOutlet weak var countInfoLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
 
    @IBOutlet weak var coutTextField: UITextField!
    var count = 1
    var price = 0.01
    override func awakeFromNib() {
        super.awakeFromNib()
        coutTextField.delegate = self
        priceTextField.delegate = self
    }
    
    func setPrice() {
        priceTextField.text = "\(price)"
    }
    @IBAction func priceReduce(_ sender: Any) {
        
        if price > 0.00 {
            price -= 0.01
            if price == 0.0 {
                replaceImage(sender: priceReducButton, imageName: "market_unreduce")
            }
        }
        setPrice()
    }
   
    @IBAction func pricePlus(_ sender: Any) {
        
        if price < 100 {
            if price == 0 {
                replaceImage(sender: priceReducButton, imageName: "market_reduce")
            }
            price += 0.01
            
        }
        setPrice()
    }

    @IBAction func countPlus(_ sender: Any) {
        if count < 100 {
            if count == 0 {
                replaceImage(sender: countReduceButton, imageName: "market_reduce")
            }
            count += 1
        }
        setCount()
    }
    @IBAction func countReduce(_ sender: Any) {
        if count > 0 {
            count -= 1
            if count == 0 {
                replaceImage(sender: countReduceButton, imageName: "market_unreduce")
            }
        }
        setCount()
    }
    func setCount() {
        coutTextField.text = "\(count)"
    }
    func replaceImage(sender:UIButton, imageName:String) {
        sender.setImage(UIImage(named:imageName), for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
