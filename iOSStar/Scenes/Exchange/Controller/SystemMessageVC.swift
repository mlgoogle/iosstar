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
            let str = model.sellUid == UserModel.share().getCurrentUser()?.userinfo?.id ? "转让":"求购"
            self.content.text = "\(data.name)" + "(" + "\(data.code)" + ")" + str
        }
        
        time_lb.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(model.openTime), format: "YY-MM-dd HH:mm:ss")
         dosee.setTitle("", for: .normal)
        if model.handle == 0{
           dosee.setTitle("未确认", for: .normal)
        }else if model.handle == 1{
            
            if ((model.buyUid == UserModel.share().getCurrentUser()?.userinfo?.id && model.sellHandle == 1) || (model.sellUid == UserModel.share().getCurrentUser()?.userinfo?.id && model.sellHandle == 1)){
            dosee.setTitle("对方未确认", for: .normal)
            }else{
             dosee.setTitle( ((model.buyHandle == 0) && (model.sellHandle == 0)) ? "未确认" : (((model.buyHandle == -1) || (model.sellHandle == -1)) ? "已取消" : ((((model.buyHandle == 0) && (model.sellHandle == 1)) || ((model.buyHandle == 1) && (model.sellHandle == 0))) ? "未确认" : "交易成功")), for: .normal)
            }
         
        }
        else{
          dosee.setTitle("交易成功", for: .normal)
      
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backClick"), style: .done, target: self, action: #selector(leftButtonItemClick(_ :)))
        
    }
    
    
    
    // 判断是被push还是被modal出来的;
    func leftButtonItemClick(_ sender : Any) {
        
        // print("点击了返回");
        let vcs = self.navigationController?.viewControllers
        
        guard vcs != nil else { return }
        
        if vcs!.count > 1{
            // push过来的
            if vcs?[vcs!.count - 1] == self {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            // modal
                self.navigationController?.dismiss(animated: true, completion: nil)
        }
        
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
        
        self.getUserRealmInfo { (result) in
            if let model = result{
                let object =  model as! [String : AnyObject]
                  let alertVc = AlertViewController()
                if object["realname"] as! String == ""{
                    
                    alertVc.showAlertVc(imageName: "tangchuang_tongzhi",
                                        titleLabelText: "您还没有身份验证",
                                        
                                        subTitleText: "您需要进行身份验证,\n之后才可以进行明星时间交易",
                                     
                                        completeButtonTitle: "开 始 验 证") {[weak alertVc] (completeButton) in
                                            alertVc?.dismissAlertVc()
                                            
                                            let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "VaildNameVC")
                                            self.navigationController?.pushViewController(vc, animated: true )
                                            return
                    }
                    
                }else{
                    let  data = self.dataSource?[indexPath.section] as! OrderListModel
                    
                    
                    if (data.handle == 1) {
                        if ((data.buyUid == UserModel.share().getCurrentUser()?.userinfo?.id && data.sellHandle == 0) && (data.sellUid == UserModel.share().getCurrentUser()?.userinfo?.id && data.sellHandle == 0)){
                            let alertController = UIAlertController(title: "交易提醒", message: "点击确认进行交易", preferredStyle:.alert)
                            // 设置2个UIAlertAction
                            let cancelAction = UIAlertAction(title: "取消", style:.default) { (UIAlertAction) in
                                self.doorder(data, true)
                            }
                            let completeAction = UIAlertAction(title: "确定", style:.default) { (UIAlertAction) in
                                self.showView(data, false)
                            }
                            
                            // 添加
                            alertController.addAction(cancelAction)
                            alertController.addAction(completeAction)
                            // 弹出
                            self.present(alertController, animated: true, completion: nil)
                            
                            
                        }
                        else if (data.sellHandle == -1 || data.buyHandle == -1){
                            
                            
                            
                            
                        }
                        //
                    }
                    else if (data.handle == 2){
                        
                    }
                    else{
                        let alertController = UIAlertController(title: "交易提醒", message: "点击确认进行交易？", preferredStyle:.alert)
                        // 设置2个UIAlertAction
                        let cancelAction = UIAlertAction(title: "取消", style:.default) { (UIAlertAction) in
                            self.doorder(data, true)
                        }
                        let completeAction = UIAlertAction(title: "确定", style:.default) { (UIAlertAction) in
                            self.showView(data, false)
                        }
                        
                        // 添加
                        alertController.addAction(cancelAction)
                        alertController.addAction(completeAction)
                        // 弹出
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        
     

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        print(indexPath.section)
        cell.update(dataSource?[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
                if let object = result as? [String : Any]  {
                    

                    if let status = object["status"] as? Int{
                        if status == 0{
                            SVProgressHUD.showSuccess(withStatus: "取消成功")

                    }
                    }
                }
            }, error: { (error ) in
               
            })
        }else{
            let sure = SureOrderRequestModel()
            sure.orderId = order.orderId
            sure.positionId = order.positionId
            AppAPIHelper.dealAPI().sureOrderRequest(requestModel: sure, complete: { (result) in
               
                if let object = result as? [String : Any]  {
                
                    if let status = object["status"] as? Int{
                        if status == 0{
                            SVProgressHUD.showSuccess(withStatus: "确认成功")
                        }
                    }
                }
            }, error: { (error) in
                print(error)
            })
        }

    }
    func showView(_ order : OrderListModel,_ canel : Bool){
        let model = OrderInformation()
        let aa = order.openPrice * Double.init(order.amount)
        let float = "\(aa)"
        model.orderAllPrice = "\(float)"
        model.orderAccount = "\(order.amount)"
        model.orderPrice = "\(order.openPrice)"
        model.orderStatus  = order.sellUid == UserModel.share().getCurrentUser()?.userinfo?.id ? "转让":"求购"
        StartModel.getStartName(startCode: order.symbol) { (result) in
            
            let data = result as! StartModel
            model.orderInfomation = "\(data.name)" + "(" + "\(data.code)" + ")"
        }
        
        //将值传给 sharedatemodel
        ShareDataModel.share().orderInfo = model
        let storyboard = UIStoryboard.init(name: "Order", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as!  UINavigationController
        
        
        let rootvc = controller.viewControllers[0] as! ContainPayVC
        print(controller.viewControllers.count)
        
        rootvc.resultBlock = { (result) in
            if canel {
                self.doorder(order, true)
            }else{
                self.doorder(order, false)
            }
            controller.dismissController()
            
        }
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: nil)
    }
}
