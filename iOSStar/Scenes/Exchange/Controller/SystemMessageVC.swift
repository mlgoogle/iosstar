//
//  SystemMessageVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SystemMessageVC: BasePageListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "系统消息"
        tableView.separatorStyle = .none
            }


    override func didRequest(_ pageIndex: Int) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //定义一个model
//        let model = OrderInformation()
//        model.orderAllPrice = "100"
//        model.orderAccount = "100"
//        model.orderPrice = "100"
//        model.orderStatus = "100"
//        model.orderInfomation = "100"
//        //将值传给 sharedatemodel
//        ShareDataModel.share().orderInfo = model
//        let storyboard = UIStoryboard.init(name: "Order", bundle: nil)
//        let controller = storyboard.instantiateInitialViewController() as!  UINavigationController
//        
//        let rootvc = controller.viewControllers[0] as! ContainPayVC
//        print(controller.viewControllers.count)
//        rootvc.resultBlock = { (result) in
//            controller.dismissController()
//            
//        }
//        controller.modalPresentationStyle = .custom
//        controller.modalTransitionStyle = .crossDissolve
//        present(controller, animated: true, completion: nil)
        
        let nav : UINavigationController = UINavigationController.storyboardInit(identifier: "Input", storyboardName: "Order") as! UINavigationController
         let rootvc = nav.viewControllers[0] as! InputPassVC
        
        
         rootvc.resultBlock = { (result) in
                        rootvc.dismissController()
            
                    }
        rootvc.showKeyBoard = true
        nav.modalPresentationStyle = .custom
        nav.modalTransitionStyle = .crossDissolve
//         rootvc.textField.becomeFirstResponder()
        present(nav, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") 
        cell?.selectionStyle = .none
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 5
    }
     override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
