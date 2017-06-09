//
//  DealSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class DealSocketAPI: BaseSocketAPI, DealAPI{
    
    func buyOrSell(requestModel:BuyOrSellRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .buyOrSell, model: requestModel)
        startModelRequest(packet, modelClass: EntrustSuccessModel.self, complete: complete, error: error)
    }
    
    func setReceiveMatching(complete:@escaping CompleteBlock) {
        SocketRequestManage.shared.receiveMatching = { (response) in
            let jsonResponse = response as! SocketJsonResponse
            let model = jsonResponse.responseModel(ReceiveMacthingModel.self) as? ReceiveMacthingModel
            if  model != nil {
                complete(model)
            }
            
            
        }
    }
    
}
