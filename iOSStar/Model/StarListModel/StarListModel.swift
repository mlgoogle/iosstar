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

  
    var list : [StarInfoModel]?
    var result : Int = 3
    var size : Int = 3

    class func listModelClass() ->AnyClass {
        return  StarInfoModel.classForCoder()
    }

}
class StarInfoModel: NSObject {
    
    var faccid : String = ""
    var head : String = ""
    var name : String = ""
    var type : String = ""
    
    
}
