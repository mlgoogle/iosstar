//
//  AppAPIHelper.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class AppAPIHelper: NSObject {
    
    fileprivate static var _loginApi = LoginSocketApi()
    fileprivate static var _friendApi = FriendSocketApi()
    fileprivate static var _newsApi = NewsSocketAPI()

    class func login() -> LoginApi{
        return _loginApi
    }
    class func friend() -> FriendApi{
        return _friendApi
    }
    
    class func newsApi()-> NewsApi {
        
        return _newsApi
    }
    
    
}

