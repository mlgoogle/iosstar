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
    var memberId = 0
    var agentId = ""
    var recommend = ""
    var timestamp = ""
}

class WXRegisterRequestModel: BaseModel{
    var phone = ""
    var timeStamp = 0
    var vToken = ""
    var pwd = ""
    var openid = ""
    var nickname = ""
    var headerUrl = ""
    var memberId = 0
    var agentId = ""
    var recommend = ""
    var deviceId = ""
    var vCode = ""
}
