//
//  MarketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/5/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
protocol MarketAPI {
    func requestTypeList(complete: CompleteBlock?, error: ErrorBlock?)
    func searchstar(requestModel:MarketSearhModel,  complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarList(requestModel:StarListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestOptionalStarList(startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?)
    func addOptinal(starcode:String,complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarExperience(code:String,complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarArachive(code:String,complete: CompleteBlock?, error: ErrorBlock?)
    func requestRealTime(requestModel:RealTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestTimeLine(requestModel:TimeLineRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func sendComment(requestModel:SendCommentModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestCommentList(requestModel:CommentListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestAuctionStatus(requestModel:AuctionStatusRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarRealTime(requestModel:StarRealtimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarServiceType(starcode:String,complete: CompleteBlock?, error: ErrorBlock?)
    func requestBuyStarService(requestModel:ServiceTypeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestEntrustFansList(requestModel:FanListRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    func requestOrderFansList(requestModel:FanListRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    func requestPositionCount(requestModel:PositionCountRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requstBuySellPercent(requestModel:BuySellPercentRequest,complete: CompleteBlock?, error: ErrorBlock?)
    func requstBuyBarrageList(requestModel:HeatBarrageModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestTotalCount(starCode:String,complete: CompleteBlock?, error: ErrorBlock?)
}
