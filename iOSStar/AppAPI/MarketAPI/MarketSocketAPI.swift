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
    
   func searchstar(code : String,  complete: CompleteBlock?, error: ErrorBlock?){
        
        let paramters:[String:Any] = [SocketConst.Key.starCode : code]
        let packet = SocketDataPacket(opcode: .searchStar, parameters: paramters)
        
        startModelsRequest(packet, listName: "list", modelClass: MarketClassifyModel.self, complete: complete, error: error)
    }
    
}
