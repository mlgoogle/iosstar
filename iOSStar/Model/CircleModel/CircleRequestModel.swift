//
//  CircleRequestModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class CircleListRequestModel: BaseModel {
    
    var pos:Int64 = 0
    var count:Int32 = 10
}
class ApproveCircleModel: BaseModel {
    var star_code = "1001"
    var circle_id:Int64 = 10001
    var uid:Int64 = StarUserModel.getCurrentUser()?.userinfo?.id ?? 0
}
class CommentCircleModel: ApproveCircleModel {
    var direction = 0
    var content = "111111111"
    
}
class SendCircleRequestModel: BaseModel {
    var star_code = "1001"
    var content = "d隧道掘进机爱迪生的卡死了；打开了；奥斯卡了；奥斯卡；懒得看洒了；的卡萨；离苦得乐；萨克的；拉斯柯达；拉卡死了；打卡；塑料颗粒；打开了"
    var picurl = "http://p3.img.cctvpic.com/nettv/newgame/2011/0519/20110519071618926.jpg"
}
class DeleteCircle: BaseModel {
    dynamic var star_code = "1001"
    dynamic var circle_id = 0
}
