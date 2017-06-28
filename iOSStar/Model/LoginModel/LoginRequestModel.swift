//
//  LoginRequestModel.swift
//  iOSStar
//
//  Created by mu on 2017/6/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class LoginRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
    var deviceId = ""
}

class RegisterRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
    var memberId = ""
    var agentId = ""
    var recommend = ""
    var timestamp = ""
    var sub_agentId = ""
}

class WXRegisterRequestModel: BaseModel {
    var phone = ""
    var timeStamp = 0
    var vToken = ""
    var pwd = ""
    var openid = ""
    var nickname = ""
    var headerUrl = ""
    var memberId = ""
    var agentId = ""
    var recommend = ""
    var sub_agentId = ""
    var deviceId = ""
    var vCode = ""
}

class WeChatLoginRequestModel: BaseModel {
    var openid = ""
    var deviceId = ""
}

class CheckRegisterRequestModel: BaseModel {
    var phone = ""
}

class SendVerificationCodeRequestModel: BaseModel {
    var phone = ""
}

class ResetPassWdRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
}

class RegisterWYIMRequestModel : BaseModel {
    var name_value = ""
    var accid_value = ""
    var phone = ""
    var memberId = 1001
    var agentId = "186681261"
    var recommend = "3tewe"
    var timeStamp = 100088888
}


