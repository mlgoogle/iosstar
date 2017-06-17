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
    
    //检查系统时间差
    func checkTimeDistance() {
        let timeCount = Int64(Date().timeIntervalSince1970)
        YD_CountDownHelper.shared.timeDistance = sysTime - timeCount
    }
    func cacheSelf() {
        let realm = try! Realm()
        checkTimeDistance()
        try! realm.write {
            realm.add(self, update: true)
        }
 
    }
}


class SearchResultModel: Object {
    dynamic var gender = 1
    dynamic var name = ""
    dynamic var pic = ""
    dynamic var symbol = ""
    dynamic var wid = ""
}




class AuctionStatusModel: Object {
    dynamic var remainingTime:Int64 = 0
    dynamic var status = false
    dynamic var symbol = "1001"
}
class FansListModel: Object {
    
    dynamic var trades:FansTradesModel?
    dynamic var user:FansInfoModel?
}

class FansTradesModel: Object {
    dynamic var amount = 0
    dynamic var buySell = 1
    dynamic var handle = 0
    dynamic var id = 0
    dynamic var openCharge = 0.0
    dynamic var openPrice = 0.0
    dynamic var positionId:Int64 = 0
    dynamic var positionTime:Int64 = 0
    dynamic var symbol = ""
}

class FansInfoModel: Object {
    dynamic var gender = 0
    dynamic var headUrl = ""
    dynamic var nickname = ""
    dynamic var uid = 0
}

class OrderFansListModel: Object {
    dynamic var buy_user:BuyOrSellFansModel?
    dynamic var sell_user:BuyOrSellFansModel?
    dynamic var trades:OrderTradesModel?
    
}
class BuyOrSellFansModel: Object {
    dynamic var gender = 0
    dynamic var headUrl = ""
    dynamic var nickname = ""
    dynamic var uid = 0
}

class OrderTradesModel: Object {
    dynamic var amount = 21
    dynamic var buyUid = 152
    dynamic var closeTime = 0
    dynamic var grossProfit = 0
    dynamic var handle = 0
    dynamic var openCharge = 0
    dynamic var openTime = 0
    dynamic var orderId = 0
    dynamic var sellUid = 0
    dynamic var symbol = ""
    dynamic var openPrice = 0.0
}
class PositionCountModel: Object {
    
    dynamic var star_time:Int64 = 0
    dynamic var result:Int64 = 0
}

class BuySellCountModel: Object {
    
    dynamic var buyCount = 0
    dynamic var sellCount = 0
    dynamic var buyTime = 0
    dynamic var sellTime = 0
    dynamic var symbol = "1001"
}


class StarTotalCountModel:Object {
    dynamic var result:Int64 = 1
    dynamic var star_time:Int64 = 0
}

class EntrustCountModel:Object {
    
}
