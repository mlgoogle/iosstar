//
//  MarketCommentViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketCommentViewController: MarketBaseViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        
        requestCommentList()
    }
    
    
    func requestCommentList() {
        AppAPIHelper.marketAPI().requestCommentList(starcode: "1001", complete: { (resonse) in
            
            
        }, error: errorBlockFunc())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MarketCommentViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCommentCell", for: indexPath)
        
        return cell 
    }
}
