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
    var price:Double = 12.12
}
