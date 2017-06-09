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
    
    lazy var predicate:NSPredicate = {
       let predicate = NSPredicate(format: "SELF MATCHES %@", AppConst.Text.numberReg)
        
        return predicate
    }()
    var count = 1
    var price = 0.01
    override func awakeFromNib() {
        super.awakeFromNib()
        coutTextField.delegate = self
        priceTextField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        //如果删除成 "" 字符 允许通过
        if range.location == 0 && string == "" {
            return true
        }
        let ran = textField.text!.index((textField.text!.startIndex), offsetBy: range.location)..<textField.text!.index((textField.text!.startIndex), offsetBy: range.location + range.length)

        let str = textField.text?.replacingCharacters(in: ran, with: string)

        //正则判断替换为后字符串是否为符合要求的字符
        if predicate.evaluate(with: str) {
            //如果为00不允许通过
            if str! == "00" {
                return false
            }
            return true
        } else {
            //如果为单纯的 . 字符，不允许通过
            if str == "." {
                return false
            }

            let array = str?.components(separatedBy: ".")
            if array == nil {
                return true
            } else if array!.count == 1 {
                return true
            } else if array!.last! == "" || array!.last! == "0" || array!.last! == "00" {
                return true
            }
        }
        return false
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

    }

}
