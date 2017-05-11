//
//  MakeAppointmentStarVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/9.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MakeAppointmentStarVCCell: UITableViewCell {
    
}
class MakeAppointmentStarVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我预约的明星"
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MakeAppointmentStarVCCell")

       

        return cell!
    }
  



}
