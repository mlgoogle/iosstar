//
//  StarListModel.swift
//  iOSStar
//
//  Created by sum on 2017/5/11.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class BaseModel: OEZModel {
    override class func jsonKeyPostfix(_ name: String!) -> String! {
        return "";
    }
    deinit {
        
    }
}

class StarListModel: BaseModel {

  
    var depositsinfo : [StarInfoModel]?
    

    class func depositsinfoModelClass() ->AnyClass {
        return  StarInfoModel.classForCoder()
    }

}
class StarInfoModel: NSObject {
    
    var faccid : String = ""
    var status : Int64 = 0
    var ownseconds : Int64 = 0
    var appoint : Int64 = 0
    var starcode : String = ""
    var starname : String = ""
    var uid : Int64 = 0

    
    
}
