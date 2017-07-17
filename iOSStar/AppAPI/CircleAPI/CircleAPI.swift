//
//  CircleAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

protocol CircleAPI {
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func sendCircle(requestModel:SendCircleRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    func deleteCircle(requestModel:DeleteCircle, complete: CompleteBlock?, error: ErrorBlock?)
    
    func starCommentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?)

}

