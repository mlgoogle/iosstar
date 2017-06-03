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
    
    var id:Int64 = 0
}

class ResetPayPwdRequestModel: UserBaseModel {
    var timestamp : Int64 = 0
    var vCode = ""
    var vToken = ""
    var type = 1
    var pwd = ""
    var phone = ""
}
