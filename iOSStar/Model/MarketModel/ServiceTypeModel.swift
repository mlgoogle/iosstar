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
    
    // 明星服务选中图片
    dynamic var url1 : String = ""
    
    // 明星服务未选中图片
    dynamic var url2 : String = ""
    
    // 服务名称
    dynamic var name : String = ""
    
    // 服务价格
    dynamic var price : String = ""
    
}
