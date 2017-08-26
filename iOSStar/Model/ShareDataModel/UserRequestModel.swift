//
//  UserRequestModel.swift
//  iOSStar
//
//  Created by MONSTER on 2017/6/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Foundation

class UserBaseModel: BaseModel {
    
    var id : Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
}

class StarMailListRequestModel: MarketBaseModel {
    var status = 0
    var count = 10
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var startPos = 0
}
class StarMailOrderListRequestModel: MarketBaseModel {
    
    var count = 10
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var pos = 0
}


class ReduceTimeModel: BaseModel {
    var phone = ""
    var deduct_amount = 0
    var starcode = ""
}

class ResetPassWdModel: UserBaseModel {
    var timestamp:Int64 = 0
    var vCode = ""
    var type = 1
    var vToken = ""
    var pwd = ""
    var phone = ""
    
}

class OrderStarsRequetsModel: BaseModel {
    var phone = ""
    var starcode = ""
}

class WeChatPayModel: UserBaseModel {
    var title = ""
    var price:Double = 0.0
}

class AccountMoneyRequestModel: UserBaseModel {
    
}

class CreditListRequetModel: MarketBaseModel {
    var status:Int32 = 0
    var startPos:Int32 = 0
    var count:Int32 = 10
    var time = ""
}

class AuthenticationRequestModel: UserBaseModel {

    var realname = ""
    var id_card = ""
}
class GetAuthenticationRequestModel: MarketBaseModel {
    
}

class UserInfoRequestModel: MarketBaseModel {
    
}
class TokenLoginRequestModel: MarketBaseModel {
    var token_time = StarUserModel.getCurrentUser()?.token_time ?? 0
}

class ModifyNicknameModel: MarketBaseModel {
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var nickname = ""
}

class GetAllStarInfoModel: BaseModel {
    
    var phone = ""
    var code = ""
    var all = 1
}
class AliPayRequestModel: MarketBaseModel {
    var title = ""
    var price:Double = 0.0
}

class ResetPayPwdRequestModel: UserBaseModel {
    var timestamp : Int64 = 0
    var vCode = ""
    var vToken = ""
    var type = 1
    var pwd = ""
    var phone = ""
}

class WeChatTokenRequestModel: BaseModel {
    
    var id : Int64 = 0
    var uid : Int64 = 0
    var token : String = ""
}
class CancelRechargeModel: UserBaseModel {
    var rid = ""
    var payResult:Int64 = 1
}
class WithDrawrequestModel: UserBaseModel {
    var price = 0.0
//    var withdrawPwd = "123"
   }

//CommissionModel
class CommissionModelequestModel: UserBaseModel {
    var uid : Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
}

class WithDrawListrequestModel: UserBaseModel {
    var status = 0
    var start = 0
    var count = 0
    var startPos = 0
}
class PromotionurlModel: UserBaseModel {
  
    var param_code = ""
}

