//
//  MarketDetaiBaseInfoViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketDetaiBaseInfoViewController: UIViewController {

    var rows:[Int] = [1, 1, 10]
    var identifiers:[String] = ["MaketBannerCell","MarketInfoCell","MarketExperienceCell"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

extension MarketDetaiBaseInfoViewController:UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  3
    }
}
