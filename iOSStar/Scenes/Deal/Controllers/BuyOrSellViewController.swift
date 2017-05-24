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
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension BuyOrSellViewController:UITableViewDelegate, UITableViewDataSource {
    
    
    
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
