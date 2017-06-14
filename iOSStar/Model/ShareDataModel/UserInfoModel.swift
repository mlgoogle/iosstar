//
//  UserInfoModel.swift
//  iOSStar
//
//  Created by sum on 2017/6/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import RealmSwift

class UserInfoModel: Object {
    dynamic var nick_name : String = " "
    dynamic var market_cap : Int = 0
    dynamic var is_setpwd : Int = 0
    dynamic var balance : Double = 0
    dynamic var total_amt  :Double = 0
    dynamic var head_url : String = " "
}
