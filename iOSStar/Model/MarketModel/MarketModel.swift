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
class AchiveModel: Object {
    dynamic var achive = ""
}

class ExperienceModel: Object {
    dynamic var experience = ""
    
}
class CommentModel: Object {
    dynamic var symbol = ""
    dynamic var fans_id = ""
    dynamic var nick_name = ""
    dynamic var head_url = ""
    dynamic var comments = ""
    dynamic var cms_time:Int64 = 0
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
    
    class func getLineData(starWid:String) -> [TimeLineModel] {
        let realm = try! Realm()
        let results = realm.objects(TimeLineModel.self).filter("symbol = '\(starWid)'").sorted(byProperty: "priceTime", ascending: false)
        var array = [TimeLineModel]()
        for (_, model) in results.enumerated() {
            if array.count == 30 {
                break
            }
            array.append(model)
        }
        return array
    }
    //缓存分时数据
    class func cacheLineData(datas:[TimeLineModel]) {
        let realm = try! Realm()
        for (_, model) in datas.enumerated() {
            try! realm.write {
                realm.add(model)
            }
        }
        
    }
}
class RealTimeModel: PirceBaseModel {
    dynamic var sysTime:Int64 = 0
    override static func primaryKey() -> String?{
        return "symbol"
    }
}


class SearchResultModel: BaseModel {
    dynamic var gender = 1
    dynamic var name = ""
    dynamic var pic = ""
    dynamic var symbol = ""
    dynamic var wid = ""
}


