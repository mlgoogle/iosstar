
//
//  News.swift
//  iOSStar
//
//  Created by J-bb on 17/5/11.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import RealmSwift
import Foundation

class NewsModel: Object {
    dynamic var id = 0
    dynamic var link_url = ""
    dynamic var remarks = ""
    dynamic var showpic_url = ""
    dynamic var starcode = ""
    dynamic var subject_name = ""
    dynamic var times = ""
    
}

class BannerModel: Object {
    dynamic var code = ""
    dynamic var name = ""
    dynamic var pic_url = ""
    dynamic var type = 0
}

class BannerDetaiStarModel: Object {
    dynamic var accid = ""
    dynamic var brief = ""
    dynamic var code = ""
    dynamic var gender = 1
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var price = 0.0
    dynamic var pic_url = ""
}
