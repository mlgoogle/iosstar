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
    var sectionHeights:[CGFloat] = [80.0, 36.0, 80.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false

        if type.hashValue < 2 {
            identifiers.removeFirst()
            sectionHeights.removeFirst()
        }
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return identifiers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if section == identifiers.count - 1 {
            
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.section], for: indexPath)
        if type.rawValue > AppConst.DealDetailType.todayEntrust.rawValue{
            if indexPath.row == 0 {
                if let dateCell = cell as? DealSelectDateCell {
                    dateCell.delegate = self
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionHeights[indexPath.section]
    }
}
