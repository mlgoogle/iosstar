//
//  DiscoverAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
protocol DiscoverAPI {
    func requestStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestScrollStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)

    
    func requestBuyRemainingTime(requestModel:BuyRemainingTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requsetPanicBuyStarInfo(requestModel:PanicBuyRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func requestStarDetailInfo(requestModel:StarDetaiInfoRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
  
    func buyStarTime(requestModel:BuyStarTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
}
