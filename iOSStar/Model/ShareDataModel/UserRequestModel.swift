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
    
//    var id : Int64 = (UserModel.share().getCurrentUser()?.userinfo?.id)!
    var id : Int64 = UserModel.share().getCurrentUser()?.userinfo?.id ?? 0
}

class StarMailListRequestModel: MarketBaseModel {
    var status = 0
    var count = 10
    var startPos = 0
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
    var count:Int32 = 0
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
    
}

class ModifyNicknameModel: MarketBaseModel {
    var nickname = ""
}

class GetAllStarInfoModel: BaseModel {
    
    var phone = "1123"
    var code = "123"
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
    var token : String = ""
}
class CancelRechargeModel: UserBaseModel {
    var rid = ""
    var payResult:Int64 = 1
}
