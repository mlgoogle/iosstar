//
//  DiscoverAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
protocol DiscoverAPI {
    func requestStarList(requestModel:StarListRequestModel,complete: CompleteBlock?, error: ErrorBlock?)


}
