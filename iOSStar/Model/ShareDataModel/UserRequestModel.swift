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
