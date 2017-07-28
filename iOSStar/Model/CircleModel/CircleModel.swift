//
//  CircleModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import RealmSwift

class CircleListModel: Object {
    dynamic var symbol = ""
    dynamic var symbol_name = ""
    dynamic var head_url = ""
    dynamic var circle_id:Int64 = 0
    dynamic var create_time:Int64 = 0
    dynamic var content = ""
    dynamic var pic_url = ""
    dynamic var approve_dec_time = 0
    dynamic var comment_dec_time = 0
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
class SendCircleResultModel: Object {
    dynamic var circle_id = 0
}

class ResultModel: BaseModel{
    var result = 0
    
}
