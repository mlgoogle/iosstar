//
//  DealAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

protocol DealAPI {
    func buyOrSell(requestModel:BuyOrSellRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    func setReceiveMatching(complete:@escaping CompleteBlock)
}
