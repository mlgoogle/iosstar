//
//  DiscoverSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class DiscoverSocketAPI:BaseSocketAPI, DiscoverAPI{
    
    func requestStarList(requestModel:StarListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .starList, model: requestModel)
        
        startModelsRequest(packet, listName: "symbol_info", modelClass: StarSortListModel.self, complete: complete, error: error)
    }
}
