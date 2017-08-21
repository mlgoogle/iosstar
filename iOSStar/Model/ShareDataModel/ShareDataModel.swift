//
//  ShareDataModel.swift
//  iOSStar
//
//  Created by sum on 2017/4/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ShareDataModel: NSObject {

    private static var model: ShareDataModel = ShareDataModel()
    class func share() -> ShareDataModel{
        return model
    }
    var wechatUserInfo = [String:String]()
    dynamic var isweichaLogin : Bool = false
    var phone : String =   ""
    var codeToeken : String =   ""
    dynamic var selectMonth : String = ""
    var isReturnBackClick : Bool = false
    var orderInfo : OrderInformation?
    var isShowInWindows : Bool = false
    var registerModel: RegisterRequestModel = RegisterRequestModel()
    var wxregisterModel: WXRegisterRequestModel = WXRegisterRequestModel()
    var controlSwitch: Bool = true
    var buttonExtOnceSwitch = true
    var voiceSwitch = false
    var selectStarCode = ""
    var baseTabbarC: BaseTabBarController?
    var netInfo: NetModel = NetModel()
    var qiniuHeader = "http://out9d2vy4.bkt.clouddn.com/"
}

class OrderInformation: NSObject {
    
     var orderAllPrice : String =   ""
     var orderAccount : String =   ""
     var orderPrice : String =   ""
     var orderStatus : String =   ""
     var orderInfomation : String =   ""
     var ordertitlename : String =   "订单详情"
}

class Share: NSObject {
    
    var titlestr : String = ""
    var Image : UIImage!
    var name : String = ""
    var descr : String = ""
    var star_code : String = ""
    var work : String = ""
    var webpageUrl : String = ""
    var PromotionUrl : String = ""
}
