//
//  NewsApi.swift
//  iOSStar
//
//  Created by J-bb on 17/5/11.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

protocol NewsApi {
    func requestNewsList(startnum:Int, endnum:Int, complete: CompleteBlock?, error: ErrorBlock?)
    
    
    func requestBannerList(complete: CompleteBlock?, error: ErrorBlock?)
    func requestStarInfo(code:String,complete: CompleteBlock?, error: ErrorBlock?)

    
}
