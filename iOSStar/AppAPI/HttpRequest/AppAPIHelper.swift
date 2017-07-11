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
    fileprivate static var _friendApi = UserSocketApi()
    fileprivate static var _newsApi = NewsSocketAPI()
    fileprivate static var _marketAPI = MarketSocketAPI()
    fileprivate static var _dealAPI = DealSocketAPI()
    fileprivate static var _discoverAPI = DiscoverSocketAPI()
    class func login() -> LoginApi{
        return _loginApi
    }
    class func user() -> UserApi{
        return _friendApi
    }
    
    class func newsApi()-> NewsApi {
        
        return _newsApi
    }
    class func marketAPI()-> MarketAPI{
        return _marketAPI
    }
    class func dealAPI()-> DealAPI {
        return _dealAPI
    }
    class func discoverAPI()-> DiscoverAPI {
        return _discoverAPI
    }
    
}

