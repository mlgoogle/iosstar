//
//  MarketSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/5/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class MarketSocketAPI: BaseSocketAPI,MarketAPI {
    
    func requestTypeList(complete: CompleteBlock?, error: ErrorBlock?) {
        
        let paramters:[String:Any] = [SocketConst.Key.phone : "123"]
        let packet = SocketDataPacket(opcode: .marketType, parameters: paramters)
        
        startModelsRequest(packet, listName: "list", modelClass: MarketClassifyModel.self, complete: complete, error: error)
    }
    func requestStarList(type:Int,startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?) {
        let paramters:[String:Any] = [SocketConst.Key.startnum : startnum,
                                      SocketConst.Key.endnum : endnum,
                                      SocketConst.Key.type : type]
        let packet = SocketDataPacket(opcode: .marketStar, parameters: paramters)
        
        startModelsRequest(packet, listName: "list", modelClass: <#T##AnyClass#>, complete: <#T##CompleteBlock?##CompleteBlock?##(AnyObject?) -> ()#>, error: <#T##ErrorBlock?##ErrorBlock?##(NSError) -> ()#>)

    }

}
