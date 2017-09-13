//
//  MarketRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/5/31.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation


class MarketBaseModel: BaseModel {
    
    var id:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    
    var token =  StarUserModel.getCurrentUser()?.token ?? ""
}

class RealTimeRequestModel:MarketBaseModel {

    var symbolInfos = [SymbolInfo]()
}
class SymbolInfo: BaseModel {
    var symbol = ""
    var aType = 5
}
class TimeLineRequestModel: MarketBaseModel {
    var symbol = ""
    var aType = 5
}

class StarListRequestModel: MarketBaseModel {
    
    var sort = 0 
    var aType:Int32 = 5
    var start:Int32 = 0
    var count:Int32 = 20
    
}

class SendCommentModel: BaseModel {
    var symbol = ""
    var fans_id =  "\(StarUserModel.getCurrentUser()?.userinfo?.id ?? 0)"
    var nick_name = StarUserModel.getCurrentUser()?.userinfo?.agentName ?? ""
    var comments = ""
    
    var head_url = StarUserModel.getCurrentUser()?.userinfo?.avatar_Large ?? ""
}

class CommentListRequestModel: BaseModel {
    var symbol = ""
    var token = StarUserModel.getCurrentUser()?.token ?? ""
    var startPos = 0
    var count = 10
}

class MarketSearhModel: MarketBaseModel {
    var message = ""
}

class AuctionStatusRequestModel: MarketBaseModel {
    var symbol = ""
    
}

class FanListRequestModel: MarketBaseModel {
    var symbol = ""
    var buySell:Int32 = 1
    var start:Int32 = 0
    var star_code = ""
    var count:Int64 = 10
}

class PositionCountRequestModel: BaseModel {

     var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
    
     var starcode = ""
    
}

class BuySellPercentRequest: MarketBaseModel {
    
     var symbol = ""
}
class EntrustCountRequestModel: MarketBaseModel {
    var symbol = ""
}
class BankCardListRequestModel: MarketBaseModel {
    var cardNo = ""
}
class UnbindCardListRequestModel: MarketBaseModel {
    var cardNo = ""
}

class BindCardListRequestModel: MarketBaseModel {
    var symbol = ""
    var account = ""
    var bankUsername = ""
    var prov = ""
    var city = ""
}

