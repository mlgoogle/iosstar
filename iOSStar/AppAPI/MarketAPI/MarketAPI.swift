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

    //搜索
    func searchstar(code : String,  complete: CompleteBlock?, error: ErrorBlock?)
    

    func requestStarList(type:Int,startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?)
}
