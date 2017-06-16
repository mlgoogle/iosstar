//
//  SystemMessageVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class MessageCell:  OEZTableViewCell{
    
    @IBOutlet var time_lb: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var dosee: UIButton!
    override func update(_ data: Any!) {
        let model = data as! OrderListModel
       
         StartModel.getStartName(startCode: model.symbol) { (result) in
            let data = result as! StartModel
            let str = model.sellUid == 1 ? "转让":"求购"
             self.content.text = "\(data.name)" + "(" + "\(data.code)" + ")" + str
        }
        
        time_lb.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.openTime), format: "YY-MM-dd HH:mm:ss")
       
        if model.handle == 0{
            dosee.setTitle("未确认", for: .normal)
        }else{
        
        dosee.setTitle( ((model.buyHandle == 0) && (model.sellHandle == 0)) ? "未确认" : (((model.buyHandle == -1) || (model.sellHandle == -1)) ? "已取消" : ((((model.buyHandle == 0) && (model.sellHandle == 1)) || ((model.buyHandle == 1) && (model.sellHandle == 0))) ? "未确认" : "交易成功")), for: .normal)
    }
        
    }
    
}
class SystemMessageVC: BasePageListTableViewController {

    @IBOutlet var nodata: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "系统消息"
        tableView.separatorStyle = .none
        self.nodata.isHidden = false
    }
    override func didRequest(_ pageIndex: Int) {
        
        let model = OrderRecordRequestModel()
        model.status = 3
        model.start = Int32((pageIndex - 1) * 10)
        model.count = 10
      AppAPIHelper.dealAPI().requestOrderList(requestModel: model, OPCode: .historyOrder, complete: { (result) in
         if  let object = result {
            self.didRequestComplete(object)
            if self.dataSource?.count == 0{
            self.nodata.isHidden = false
            }else{
             self.nodata.isHidden = true
             self.nodata.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
            }
        }
    }) { (error ) in
         self.didRequestComplete(nil)
         self.nodata.isHidden = false
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  data = self.dataSource?[indexPath.section] as! OrderListModel
        
    
        if (data.handle == 1) {
            if ((data.buyUid == 1 && data.sellHandle == 0) && (data.sellUid == 1 && data.sellHandle == 0)){
                let alertController = UIAlertController(title: "交易提醒", message: "点击确认进行交易", preferredStyle:.alert)
                // 设置2个UIAlertAction
                let cancelAction = UIAlertAction(title: "取消", style:.default) { (UIAlertAction) in
                    self.doorder(data, true)
                }
                let completeAction = UIAlertAction(title: "确定", style:.default) { (UIAlertAction) in
                    self.doorder(data, false)
                }
                
                // 添加
                alertController.addAction(cancelAction)
                alertController.addAction(completeAction)
                // 弹出
                self.present(alertController, animated: true, completion: nil)
                

            }
            else if (data.sellHandle != -1 || data.buyHandle != -1){
                
                
                
                
            }
          //
        }else{
            let alertController = UIAlertController(title: "交易提醒", message: "点击确认进行交易？", preferredStyle:.alert)
            // 设置2个UIAlertAction
            let cancelAction = UIAlertAction(title: "取消", style:.default) { (UIAlertAction) in
                self.doorder(data, true)
            }
            let completeAction = UIAlertAction(title: "确定", style:.default) { (UIAlertAction) in
                self.doorder(data, false)
            }
            
            // 添加
            alertController.addAction(cancelAction)
            alertController.addAction(completeAction)
            // 弹出
            self.present(alertController, animated: true, completion: nil)
        }
//        let nav : UINavigationController = UINavigationController.storyboardInit(identifier: "Input", storyboardName: "Order") as! UINavigationController
//         let rootvc = nav.viewControllers[0] as! InputPassVC
//        
//        
//         rootvc.resultBlock = { (result) in
//                        rootvc.dismissController()
//            
//                    }
//        rootvc.showKeyBoard = true
//        nav.modalPresentationStyle = .custom
//        nav.modalTransitionStyle = .crossDissolve
////         rootvc.textField.becomeFirstResponder()
//        present(nav, animated: true, completion: nil)
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        print(indexPath.section)
        cell.update(dataSource?[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource != nil ? (self.dataSource?.count)! : 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 3 : 0.001
    }
     override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func doorder(_ order : OrderListModel,_ canel : Bool)  {
        
        if canel{
            let sure = CancelOrderRequestModel()
            sure.orderId = order.orderId
            
            AppAPIHelper.dealAPI().cancelOrderRequest(requestModel: sure, complete: { (result) in
                if let object = result  {
                    
                    if object["status"] as! Int == 0{
                        SVProgressHUD.showSuccess(withStatus: "确认成功")
                    }
                }
            }, error: { (error ) in
               
            })
        }else{
            let sure = SureOrderRequestModel()
            sure.orderId = order.orderId
            sure.positionId = order.positionId
            AppAPIHelper.dealAPI().sureOrderRequest(requestModel: sure, complete: { (result) in
               
                if let object = result  {
                
                    if object["status"] as! Int == 0{
                      SVProgressHUD.showSuccess(withStatus: "确认成功")
                    }
                }
            }, error: { (error) in
                print(error)
            })
        }
        
        //                //定义一个model
        //                let model = OrderInformation()
        //                model.orderAllPrice = "100"
        //                model.orderAccount = "100"
        //                model.orderPrice = "100"
        //                model.orderStatus = "100"
        //                model.orderInfomation = "100"
        //                //将值传给 sharedatemodel
        //                ShareDataModel.share().orderInfo = model
        //                let storyboard = UIStoryboard.init(name: "Order", bundle: nil)
        //                let controller = storyboard.instantiateInitialViewController() as!  UINavigationController
        //
        //
        //                let rootvc = controller.viewControllers[0] as! ContainPayVC
        //                print(controller.viewControllers.count)
        //
        //                rootvc.resultBlock = { (result) in
        //                    if canel{
        //                        let sure = CancelOrderRequestModel()
        //                        sure.orderId = order.orderId
        //
        //                        AppAPIHelper.dealAPI().cancelOrderRequest(requestModel: sure, complete: { (result) in
        //
        //                        }, error: { (error ) in
        //
        //                        })
        //                    }else{
        //                        let sure = SureOrderRequestModel()
        //                        sure.orderId = order.orderId
        //                        sure.positionId = order.positionId
        //                        AppAPIHelper.dealAPI().sureOrderRequest(requestModel: sure, complete: { (result) in
        //                            print(result)
        //                        }, error: { (error) in
        //
        //                        })
        //                    }
        //                    controller.dismissController()
        //        
        //                }
        //                controller.modalPresentationStyle = .custom
        //                controller.modalTransitionStyle = .crossDissolve
        //                present(controller, animated: true, completion: nil)
        
    }
}
