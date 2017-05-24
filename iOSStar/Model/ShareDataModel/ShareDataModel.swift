//
//  ShareDataModel.swift
//  iOSStar
//
//  Created by sum on 2017/4/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ShareDataModel: NSObject {

    private static var model: ShareDataModel = ShareDataModel()
    class func share() -> ShareDataModel{
        return model
    }
    var wechatUserInfo = [String:String]()
    var isweichaLogin : Bool = false
    var phone : String =   ""
    var codeToeken : String =   ""
    dynamic var selectMonth : String = ""
  
}
