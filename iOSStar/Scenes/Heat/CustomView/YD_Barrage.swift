//
//  YD_Barrage.swift
//  iOSStar
//
//  Created by sum on 2017/7/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import BarrageRenderer
class YD_Barrage: BarrageWalkSprite {
    override init() {
        super.init()
        trackNumber = 4
        setValue("UILabel", forKey: "viewClassName")
    }
}
