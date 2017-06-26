//
//  LoginRequestModel.swift
//  iOSStar
//
//  Created by mu on 2017/6/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class LoginRequestModel: BaseModel {

}


class RegisterRequestModel: BaseModel{
    var phone = ""
    var pwd = ""
    var memberId = ""
    var agentId = ""
    var recommend = ""
    var timestamp = ""
    var sub_agentId = ""
}

class WXRegisterRequestModel: BaseModel{
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
