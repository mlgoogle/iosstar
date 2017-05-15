//
//  FriendApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol FriendApi {
    
      //获取好友列表
      func getfriendList(accid: String, createtime: String, complete: CompleteBlock?, error: ErrorBlock?)
      //发送时间少一秒
      func reducetime(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?)
      //预约的明细
      func getorderstars(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?)
}
