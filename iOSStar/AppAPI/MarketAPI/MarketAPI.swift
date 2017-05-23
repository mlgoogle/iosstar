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

    func searchstar(code : String,  complete: CompleteBlock?, error: ErrorBlock?)
    
    func requestStarList(type:Int,startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?)
    func requestOptionalStarList(startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?)
    func requestLineViewData(starcode:String,complete: CompleteBlock?, error: ErrorBlock?)
    func addOptinal(starcode:String,complete: CompleteBlock?, error: ErrorBlock?)
    func requestCommentList(starcode:String,complete: CompleteBlock?, error: ErrorBlock?)
    
    func requestStarExperience(code:String,complete: CompleteBlock?, error: ErrorBlock?)
}
