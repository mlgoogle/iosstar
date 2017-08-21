//
//  LoginModel.swift
//  iOSStar
//
//  Created by mu on 2017/6/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class LoginModel: BaseModel {

}

class WYIMModel: BaseModel {
    var result_value = ""
    var token_value = ""
}

class NetModel: BaseModel {
    var isp = ""
    var area = ""
    var isp_id = 0
    var area_id = 0
}

class QinniuModel: BaseModel{
    var QINIU_URL_HUADONG = ""
    var QINIU_URL_HUABEI = ""
    var QINIU_URL_HUANAN = ""
}
