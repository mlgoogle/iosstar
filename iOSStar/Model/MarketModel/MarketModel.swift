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
    dynamic var code = 0
}

class MarketListStarModel: Object {
    dynamic var accid = ""
    dynamic var code = ""
    dynamic var gender = 1
    dynamic var name = ""
    dynamic var type = 1
    dynamic var head = ""
    dynamic var price = 0.0
    dynamic var updown = 0.0
    
    
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
