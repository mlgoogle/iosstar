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
class BuyRemainingTimeModel: Object {
    dynamic var symbol = ""
    dynamic var remainingTime:Int64 = 0
}
class PanicBuyInfoModel: Object {
    dynamic var publish_price = 0.0
    dynamic var back_pic_url = ""
    dynamic var star_code = ""
    dynamic var star_name = ""
    dynamic var head_url = ""
    dynamic var star_type:Int64 = 0
    dynamic var publish_type:Int64 = 0
    dynamic var publish_time:Int64 = 0
    dynamic var publish_last_time:Int64 = 0
    dynamic var publish_begin_time:Int64 = 0
    dynamic var publish_end_time:Int64 = 0
}

class StarIntroduceResult: Object {
    dynamic var resultvalue:StarDetaiInfoModel?
}

class StarDetaiInfoModel: Object {
    dynamic var star_code = ""
    dynamic var star_name = ""
    dynamic var star_tpye:Int64 = 0
    dynamic var head_url = ""
    dynamic var back_pic = ""
    dynamic var portray1 = ""
    dynamic var portray2 = ""
    dynamic var portray3 = ""
    dynamic var portray4 = ""
    dynamic var acc_id = ""    
}

class CircleListModel: Object {
    dynamic var symbol = ""
    dynamic var symbol_name = ""
    dynamic var head_url = ""
    dynamic var circle_id:Int64 = 0
    dynamic var create_time:Int64 = 0
    dynamic var content = ""
    dynamic var pic_url = ""
    let approve_list = List<ApproveModel>()
    let comment_list = List<CircleCommentModel>()
}
class ApproveModel: Object {
    dynamic var user_name = ""
    dynamic var uid:Int64 = 0
}
class CircleCommentModel: Object {
    dynamic var uid = 0
    dynamic var user_name = ""
    dynamic var direction = 0
    dynamic var content = ""
    dynamic var priority = 0
}
