//
//  SurePayOrderVC.swift
//  iOSStar
//
//  Created by sum on 2017/6/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class SurePayOrderVC: UIViewController {

    @IBOutlet var name: UILabel!
    @IBOutlet var sure: UIButton!
    //订单总价
    @IBOutlet var orderAllPrice: UILabel!
    //订单总量
    @IBOutlet var orderAccount: UILabel!
    //订单价格
    @IBOutlet var orderPrice: UILabel!
    //订单状态
    @IBOutlet var orderStatus: UILabel!
    //订单信息
    @IBOutlet var orderInfoMation: UILabel!
    var resultBlock: CompleteBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
    name.text = ShareDataModel.share().orderInfo?.ordertitlename
    sure.backgroundColor = UIColor.init(hexString: AppConst.Color.orange)
     orderAllPrice.text = ShareDataModel.share().orderInfo?.orderAllPrice
        if ((orderAllPrice) != nil){
            orderPrice.text = ShareDataModel.share().orderInfo?.orderPrice
        }
        if((orderAccount) != nil){
         orderAccount.text = ShareDataModel.share().orderInfo?.orderAccount
        }
    
     
     orderStatus.text = ShareDataModel.share().orderInfo?.orderStatus
     orderInfoMation.text = ShareDataModel.share().orderInfo?.orderInfomation
    }
    @IBAction func close(_ sender: Any) {
         resultBlock?(doStateClick.close as AnyObject)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    @IBAction func sureClick(_ sender: Any) {
        resultBlock?(doStateClick.donext as AnyObject)
    }

}
