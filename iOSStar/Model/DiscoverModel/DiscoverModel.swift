//
//  DiscoverModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import RealmSwift

class StarSortListModel: Object {
    
    dynamic var wid:Int64 = 0
    dynamic var name = ""
    dynamic var pic = ""
    dynamic var home_pic = ""
    dynamic var home_button_pic = ""
    dynamic var symbol = ""
    dynamic var currentPrice = 0.0
    dynamic var priceTime:Int64 = 0
    dynamic var sysTime:Int64 = 0
    dynamic var change = 0.0
    dynamic var pchg = 0.0
    dynamic var pushlish_type = 0
}
