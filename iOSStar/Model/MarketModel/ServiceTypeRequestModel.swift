//
//  ServiceTypeRequestModel.swift
//  iOSStar
//
//  Created by MONSTER on 2017/6/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ServiceTypeRequestModel: BaseModel {
    
    var uid          : Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var starcode     : String = ""
    var mid          : Int64 = 0
    var city_name    : String = ""
    var appoint_time : String = ""
    var meet_type    : Int64 = 1
    var comment      : String = ""
}
