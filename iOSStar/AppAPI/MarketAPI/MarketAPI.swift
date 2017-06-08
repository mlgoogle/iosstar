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

}
