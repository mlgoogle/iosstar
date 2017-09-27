//
//  ServiceTypeModel.swift
//  iOSStar
//
//  Created by MONSTER on 2017/6/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ServiceTypeModel: Object {
    
    // 服务id
    dynamic var mid : Int64 = 0
    
    // 网红服务选中图片
    dynamic var url1_tail : String = ""
    
    // 网红服务未选中图片
    dynamic var url2_tail : String = ""
    
    // 服务名称
    dynamic var name : String = ""
    
    // 服务价格
    dynamic var price : String = ""
    
    // 约见城市
    dynamic var meet_city = ""
    
    // 开始时间
    dynamic var startdate = ""
    
    // 结束时间
    dynamic var enddate = ""
    
}
