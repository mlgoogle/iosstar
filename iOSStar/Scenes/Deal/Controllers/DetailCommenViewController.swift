//
//  DetailCommenViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/23.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DetailCommenViewController: DealBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var dealTitles = ["名称/代码","成交时间","成交价/成交量","状态/成交额"]
    var entrustTitles = ["名称/代码","委托价/时间","委托量/成交量","状态"]

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
        if type == AppConst.DealDetailType.todayEntrust {
            requestTodayEntrustList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func requestTodayEntrustList() {
        let requestModel = TodayEntrustRequestModel()
        AppAPIHelper.dealAPI().requestTodayEntrust(requestModel: requestModel, complete: { (response) in
            
            
            
            
        }, error: errorBlockFunc())
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
//        if type.rawValue > AppConst.DealDetailType.todayEntrust.rawValue{
//           
//            switch indexPath.section {
//            case 0:
//                if let dateCell = cell as? DealSelectDateCell {
//                    dateCell.delegate = self
//                }
//            case 1:
//                if let menuCell = cell as? DealTitleMenuCell {
//                    if type.rawValue == AppConst.DealDetailType.allEntrust.rawValue {
//                        menuCell.setTitles(titles: entrustTitles)
//                    } else {
//                        menuCell.setTitles(titles: dealTitles)
//                    }
//                }
//            default:
//                break
//            }
//
//        } else {
            switch indexPath.section {
            case 0:
                if let menuCell = cell as? DealTitleMenuCell {
                    if type.rawValue == AppConst.DealDetailType.todayEntrust.rawValue {
                        menuCell.setTitles(titles: entrustTitles)
                    } else {
                        menuCell.setTitles(titles: dealTitles)
                    }
                }
            default:
                break
            }
//        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sectionHeights[indexPath.section]
    }
}
