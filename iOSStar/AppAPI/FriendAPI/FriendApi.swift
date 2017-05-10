//
//  FriendApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol FriendApi {
    
      func getfriendList(accid: String, createtime: String, complete: CompleteBlock?, error: ErrorBlock?)
      func reducetime(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?)
}
