//
//  PublisherPageViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class PublisherPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "PubInfoHeaderView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
}

extension PublisherPageViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 50
        }
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView")
            return view
        } else {
            return nil
        }
    }
}
