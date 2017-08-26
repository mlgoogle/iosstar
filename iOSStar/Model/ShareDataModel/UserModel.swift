
//
//  StarUserModel.swift
//  iOSStar
//
//  Created by sum on 2017/5/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import RealmSwift

class UserInfo: Object {
    dynamic var agentName = ""
    dynamic var avatar_Large = ""
    dynamic var balance = 0.0
    dynamic var id:Int64 = 142
    dynamic var phone = ""
    dynamic var type = 0
    

    
}
class StarUserModel: Object {
    
    dynamic var userinfo  : UserInfo?
    dynamic var result : Int64 = 0
    dynamic var token : String = " "
    dynamic var token_time:Int64 = 0
    dynamic var id:Int64 = 0
    override static func primaryKey() -> String?{
        return "id"
    }
    class func upateUserInfo(userObject: AnyObject){
        
        if let model = userObject as? StarUserModel {
            model.id = model.userinfo?.id ?? 0
            UserDefaults.standard.setValue( model.userinfo?.id, forKey: SocketConst.Key.uid)
            let realm = try! Realm()
            try! realm.write {
                realm.add(model, update: true)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccessNotice), object: nil, userInfo: nil)
            }
        }
    }
    class func userInfo(userId: Int) -> StarUserModel? {
        let realm = try! Realm()
        let filterStr = "id = \(userId)"
        let user = realm.objects(StarUserModel.self).filter(filterStr).first
        if user != nil{
            return user!
        }else{
            return nil
        }
    }
    class func getCurrentUser() -> StarUserModel? {
        let userId = UserDefaults.standard.object(forKey: SocketConst.Key.uid) == nil ? 0 : ( UserDefaults.standard.object(forKey: SocketConst.Key.uid) as! Int64)
        let user = StarUserModel.userInfo(userId:Int(userId))
        if user != nil {
            return user
        }else{
            return nil
        }
    }
    
}
class WeChatPayResultModel: Object {
    
    dynamic var appid = ""
    dynamic var partnerid = ""
    dynamic var prepayid = ""
    dynamic var package = ""
    dynamic var noncestr = ""
    dynamic var timestamp = ""
    dynamic var sign = ""
    dynamic var rid = ""
}

class AliPayResultModel: Object {
    dynamic var orderinfo = ""
    dynamic var rid = ""
}

class ConfigReusltValue: Object {
    
    dynamic var param_value = ""
}

class CommissionModel: Object {
    
    dynamic var result = 1
    dynamic var total_num = 0
    dynamic var total_amount = 0.0
}
//ROMOTION
class PromotionModel: Object {
    
    dynamic var param_value = ""
    
}
class UploadTokenModel: BaseModel{
    var uptoken = ""
}


