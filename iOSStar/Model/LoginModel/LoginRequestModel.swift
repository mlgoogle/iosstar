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
    var isp = ShareDataModel.share().netInfo.isp
    var area = ShareDataModel.share().netInfo.area
    var isp_id = ShareDataModel.share().netInfo.isp_id
    var area_id = ShareDataModel.share().netInfo.area_id
}

class RegisterRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
    var memberId = ""
    var agentId = ""
    var recommend = ""
    var timestamp = ""
    var sub_agentId = ""
    var channel = "  "

    var star_code = " "
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
    var channel = ""
    var star_code = " "
}

class WeChatLoginRequestModel: BaseModel {
    var openid = ""
    var deviceId = ""
}

class CheckRegisterRequestModel: BaseModel {
    var phone = ""
    var type = 0
}

class SendVerificationCodeRequestModel: BaseModel {
    var phone = ""
    var type = 0
}

class ResetPassWdRequestModel: BaseModel {
    var phone = ""
    var pwd = ""
}

class RegisterWYIMRequestModel : BaseModel {
    var name_value = ""
    var user_type = 0
    var uid  = 0
    var phone = ""
    var memberId = 0
    var agentId = ""
    var recommend = ""
    var timeStamp = Date.nowTimestemp()
}


