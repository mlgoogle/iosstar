//
//  CircleRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class CircleListRequestModel: BaseModel {
    var star_code = ""
    var pos:Int64 = 0
    var count:Int32 = 10
}
class ApproveCircleModel: BaseModel {
    var star_code = ""
    var circle_id:Int64 = 0
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
}
class CommentCircleModel: ApproveCircleModel {
    var direction = 0
    var content = ""
    
}
class SendCircleRequestModel: BaseModel {
    var star_code = ""
    var content = ""
    var picurl = ""
}
class DeleteCircle: BaseModel {
    dynamic var star_code = ""
    dynamic var circle_id = 0
}
