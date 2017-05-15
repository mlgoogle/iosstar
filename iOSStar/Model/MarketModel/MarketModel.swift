//
//  MarketModel.swift
//  iOSStar
//
//  Created by J-bb on 17/5/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import RealmSwift

class MarketClassifyModel: Object {
    dynamic var name = ""
    dynamic var type = 0
}

class MarketListStarModel: Object {
    dynamic var accid = ""
    dynamic var code = ""
    dynamic var gender = 1
    dynamic var name = ""
    dynamic var type = 1
    
}
