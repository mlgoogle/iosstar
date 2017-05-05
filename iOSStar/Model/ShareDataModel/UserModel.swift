
//
//  UserModel.swift
//  iOSStar
//
//  Created by sum on 2017/5/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import RealmSwift
class UserModel: Object {

    private static var model: UserModel = UserModel()
    class func share() -> UserModel{
        return model
    }
    dynamic  var currentUserId: Int64 = UserDefaults.standard.object(forKey: SocketConst.Key.uid) == nil ? 0 : ( UserDefaults.standard.object(forKey: SocketConst.Key.uid) as! Int64)
    dynamic var userId : Int64 = 0
      var wechatUserInfo = [String:String]()

    
    override static func primaryKey() -> String?{
        return "userId"
    }
    class func userInfo(userId: Int) -> UserModel? {
    
        
        let realm = try! Realm()
        let filterStr = "userId = \(userId)"
        let user = realm.objects(UserModel.self).filter(filterStr).first
        if user != nil{
            return user!
        }else{
            return nil
        }
    }
    func getCurrentUser() -> UserModel? {
        let user = UserModel.userInfo(userId:Int(currentUserId))
        if user != nil {
            return user
        }else{
            return nil
        }
    }

}
