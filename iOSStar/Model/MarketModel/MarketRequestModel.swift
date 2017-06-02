//
//  MarketRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/5/31.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation


class MarketBaseModel: BaseModel {
    
    var id:Int64 = 0
    var token = ""
}

class RealTimeRequestModel:MarketBaseModel {

    var symbolInfos = [SymbolInfo]()
}
class SymbolInfo: BaseModel {
    
    var symbol = "1011650450024"
    var aType = 5
}
class TimeLineRequestModel: MarketBaseModel {
    var symbol = "1011650450024"
    var aType = 5
}

class StarListRequestModel: MarketBaseModel {
    
    var sort = 0
    var aType:Int32 = 5
    var start:Int32 = 0
    var count:Int32 = 10
    
}
