//
//  CommenModel.swift
//  iOSStar
//
//  Created by J-bb on 17/6/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class UpdateParam: BaseModel{
    var appName = ""
    var newAppSize = 0
    var newAppVersionCode: Double = 0
    var newAppVersionName = ""
    var newAppUpdateDesc = ""
    var newAppReleaseTime = ""
    var newAppUrl = ""
    var isForceUpdate = 0
    var haveUpate = false
}

class UpdateDeviceTokenModel:BaseModel  {
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var device_type = 0
    var device_id = UserDefaults.standard.string(forKey: AppConst.Text.deviceToken) == nil ? "": UserDefaults.standard.string(forKey: AppConst.Text.deviceToken)!
    
    
}
