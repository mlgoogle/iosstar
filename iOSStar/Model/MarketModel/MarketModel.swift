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
    dynamic var code = ""
}


class MarketListStarModel: Object {
    dynamic var wid = ""
    dynamic var sysTime:Int64 = 0
    dynamic var symbol = ""
    dynamic var priceTime:Int64 = 0
    dynamic var pic = ""
    dynamic var name = ""
    dynamic var currentPrice = 0.0
    dynamic var change = 0.0
    
    
    
}
class LineModel: Object {
    
    dynamic var timestamp = 0
    dynamic var value = 0.0
    class func getLineData(starCode:String) -> [LineModel] {
        let realm = try! Realm()
        let results = realm.objects(LineModel.self).sorted(byProperty: "timestamp")
        var array = [LineModel]()
        for (_, model) in results.enumerated() {
            if array.count == 30 {
                break
            }
            array.append(model)
        }
        return array
    }
    //缓存分时数据
    class func cacheLineData(datas:[LineModel]) {
        let realm = try! Realm()
        for (_, model) in datas.enumerated() {
            try! realm.write {
                realm.add(model)
            }
        }

    }
}

class ExperienceModel: Object {
    dynamic var experience = ""
    
}
class CommentModel: Object {
    dynamic var comment = ""
    dynamic var headurl = ""
    dynamic var nickname = ""
    dynamic var times = ""
}

class PirceBaseModel: Object {
    dynamic var currentPrice = 0.0
    dynamic var change = 0.0
    dynamic var openingTodayPrice = 0.0
    dynamic var closedYesterdayPrice = 0.0
    dynamic var highPrice = 0.0
    dynamic var lowPrice = 0.0
    dynamic var priceTime:Int64 = 0
    dynamic var symbol = ""
    dynamic var pchg = 0.0



}
class TimeLineModel: PirceBaseModel {
    override static func primaryKey() -> String?{
        return "symbol"
    }
}
class RealTimeModel: PirceBaseModel {
    dynamic var sysTime:Int64 = 0
    override static func primaryKey() -> String?{
        return "symbol"
    }
}

