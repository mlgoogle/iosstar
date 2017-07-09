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
    
    var identifiers = [SellingIntroCell.className(), SellingTimeAndCountCell.className(), SellingCountDownCell.className(), SellingBuyCountCell.className(), SellingPriceCell.className(), SellingTipsCell.className()]
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

}

extension SellingViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row]!, for: indexPath)
        return cell
    }
    
}
