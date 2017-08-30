//
//  DiscoverRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class StarSortListRequestModel: StarScrollListRequestModel {
    
    var sort:Int64 = 1
    var pos:Int64 = 1
    var count:Int32 = 20
    
}
class StarScrollListRequestModel: MarketBaseModel {
    var aType:Int64 = 5
}

class StarRealtimeRequestModel: StarScrollListRequestModel{
    var starcode = ""
}

class BuyRemainingTimeRequestModel: BaseModel {
    
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var token =  StarUserModel.getCurrentUser()?.token ?? ""
    var symbol = ""
}
class PanicBuyRequestModel: BaseModel {
    var symbol = ""
}
class StarDetaiInfoRequestModel: BaseModel {
    var star_code = ""
}
class BuyStarTimeRequestModel:BuyRemainingTimeRequestModel {
    var amount:Int64 = 0
    var price        =  0.0
}
class MiuCountRequestModel: BaseModel{
    var uid =       StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var star_code = ""
}

class AskRequestModel: BaseModel{
    var uid =      StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var token =    StarUserModel.getCurrentUser()?.token ?? ""
    var starcode = ""
    var aType =    0
    var pType =    0
    var cType =    0
    var uask =     ""
    var videoUrl = ""
}
class UserAskRequestModel: BaseModel{
    var uid = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var token =     StarUserModel.getCurrentUser()?.token ?? ""
    var pos = 0
    var aType = 0
    var pType = 0
    var count =     10
}
class StarAskRequestModel: BaseModel{
    var starcode =  ""
    var uid      =     StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var token =     StarUserModel.getCurrentUser()?.token ?? ""
    var pos =       0
    var count =     10
    var aType = 0
    var pType = 0
}
class PeepVideoOrvoice: BaseModel {
    var  uid      =     StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    var  qid      =     0
    var  starcode =     ""
    var  cType    =     0
}
