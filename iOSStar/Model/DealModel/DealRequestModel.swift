//
//  DealRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class BuyOrSellRequestModel: MarketBaseModel {
    var sort = 1
    var symbol = ""
    var buySell = 2
    var amount = 100
    var price:Double = 0.01
}

class SureOrderRequestModel: MarketBaseModel {
    var orderId:Int64 = 0
    var positionId:Int64 = 0
}
class CancelOrderRequestModel: MarketBaseModel {
    var orderId:Int64 = 0
}

class DealRecordRequestModel: MarketBaseModel {
    var start:Int32 = 0
    var count:Int64 = 10
}

class OrderRecordRequestModel: DealRecordRequestModel {
    var status:Int32 = 1
}
