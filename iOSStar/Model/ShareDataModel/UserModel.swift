
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
     dynamic var id : Int64 = 0
     dynamic var phone : String = ""
     dynamic var type : Int64 = 0
     dynamic var balance : Double = 0
     dynamic var userinfo  : UserModel?
     dynamic var result : Int64 = 0
     dynamic var token : String = " "
     dynamic var nickname : String = " "
     dynamic var head_url : String = " "
    
    
    override static func primaryKey() -> String?{
        return "id"
    }
    func upateUserInfo(userObject: AnyObject){
        
        if let model = userObject as? UserModel {
            
            UserModel.share().currentUserId = model.id
            UserDefaults.standard.setValue( UserModel.share().currentUserId, forKey: SocketConst.Key.uid)
            let realm = try! Realm()
            try! realm.write {
                
                realm.add(model, update: true)
                //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NotifyDefine.UpdateUserInfo), object: nil)
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccessNotice), object: nil, userInfo: nil)
            }
        }
    }
    class func userInfo(userId: Int) -> UserModel? {
    
        
        let realm = try! Realm()
        let filterStr = "id = \(userId)"
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

