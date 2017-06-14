
//
//  DealModel.swift
//  iOSStar
//
//  Created by J-bb on 17/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import RealmSwift

class EntrustSuccessModel: Object {
    dynamic var amount = 0
    dynamic var buySell = 2
    dynamic var id = 132
    dynamic var openPrice = 13.0
    dynamic var positionId:Int64 = 0
    dynamic var positionTime:Int64 = 1496920841
    dynamic var symbol = ""
}

class ReceiveMacthingModel: Object {
    dynamic var buyUid = 0
    dynamic var sellUid = 0
    dynamic var openPositionTime:Int64 = 0
    dynamic var openPrice:Double = 1.00
    dynamic var orderId:Int64 = 2371231398736937636
    dynamic var symbol = "1001"
    dynamic var amount = 0
    override static func primaryKey() -> String?{
        return "orderId"
    }
    func cacheSelf() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
    
    class func getData() -> ReceiveMacthingModel? {
        let realm = try! Realm()
        let results = realm.objects(ReceiveMacthingModel.self)
        return results.first
    }
    
}

class SureOrderResultModel: Object {
    dynamic var orderId:Int64 = 0
    dynamic var status:Int32 = 0
}
class OrderResultModel: Object {
    dynamic var orderId:Int64 = 0
    dynamic var result:Int32 = 0
}

