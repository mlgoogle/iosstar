//
//  DiscoverSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class DiscoverSocketAPI:BaseSocketAPI, DiscoverAPI{
    
    //明星互动和热度
    func requestStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starList, model: requestModel)
        startModelsRequest(packet, listName: "symbol_info", modelClass: StarSortListModel.self, complete: complete, error: error)
    }
    //抢购明星列表
    func requestScrollStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starScrollList, model: requestModel)
        startModelsRequest(packet, listName: "symbol_info", modelClass: StarSortListModel.self, complete: complete, error: error)
    }
    //请求剩余时间
    func requestBuyRemainingTime(requestModel:BuyRemainingTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packt = SocketDataPacket(opcode: .remainingTime, model: requestModel)
        startModelRequest(packt, modelClass: BuyRemainingTimeModel.self, complete: complete, error: error)
        
    }
    //抢购明星信息
    func requsetPanicBuyStarInfo(requestModel:PanicBuyRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .panicBuyStarInfo, model: requestModel)
        startModelRequest(packet, modelClass: PanicBuyInfoModel.self, complete: complete, error: error)
    }
    //明星介绍页信息
    func requestStarDetailInfo(requestModel:StarDetaiInfoRequestModel,complete: CompleteBlock?, error: ErrorBlock? ) {
        let packet = SocketDataPacket(opcode: .starDetailInfo, model: requestModel)
        startModelRequest(packet, modelClass: StarIntroduceResult.self, complete: complete, error: error)
    }
    //抢购明星
    func buyStarTime(requestModel:BuyStarTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .panicBuy, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
    //朋友圈
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .circleList, model: requestModel)
        startModelsRequest(packet, listName: "circle_list", modelClass: CircleListModel.self, complete: complete, error: error)
    }
    //评论动态
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .commentCircle, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
    //点赞动态
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .approveCircle, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
}
