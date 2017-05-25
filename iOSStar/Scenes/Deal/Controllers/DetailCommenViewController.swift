//
//  DetailCommenViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DetailCommenViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var type:AppConst.DealDetailType = .allEntrust
    var identifiers = ["DealSelectDateCell","DealTitleMenuCell","DealDoubleRowCell"]
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showDatePicker() {
        let vc = YD_DatePickerViewController()
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
        
    }

}

extension DetailCommenViewController :UITableViewDelegate, UITableViewDataSource, SelectDateDelegate{
    func startSelect(isStart:Bool) {
        showDatePicker()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row], for: indexPath)
        if type == .allDeal || type == .allEntrust{
            if indexPath.row == 0 {
                if let dateCell = cell as? DealSelectDateCell {
                    dateCell.delegate = self
                }
                
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 80
        } else if indexPath.row == 1 {
            return 36
        }
        return 70
    }
}
