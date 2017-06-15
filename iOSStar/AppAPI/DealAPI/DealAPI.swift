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
    func checkPayPass( paypwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    func setReceiveOrderResult(complete:@escaping CompleteBlock)
    func sureOrderRequest(requestModel:SureOrderRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    func cancelOrderRequest(requestModel:CancelOrderRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    func requestEntrustList(requestModel:DealRecordRequestModel,OPCode:SocketConst.OPCode,complete: CompleteBlock?, error: ErrorBlock?)
    func requestOrderList(requestModel:DealRecordRequestModel,OPCode:SocketConst.OPCode,complete: CompleteBlock?, error: ErrorBlock?)    
}
