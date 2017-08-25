//
//  StarTimeBorrowVC.swift
//  iOSStar
//
//  Created by sum on 2017/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarTimeBorrowVC: UIViewController , UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var height: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
//     self.height.constant = 200
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarTimeBorrowVCCell")
        return cell!
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        //print(offsetY)
//         self.height.constant = 200
//        height.constant  = 0
        if offsetY > 0 && offsetY <=  104{
          self.height.constant = 104 - offsetY
        }
        else if (offsetY > 104){
            self.height.constant = -104
        }
        else if (offsetY < 0){
        self.height.constant = 104 - (offsetY * 10)
        }
    }



}
