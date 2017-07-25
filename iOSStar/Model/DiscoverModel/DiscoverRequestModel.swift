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
    var aType:Int64 = 4
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
    var price = 0.0
}

