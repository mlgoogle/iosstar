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
    
}
