//
//  DiscoverSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class DiscoverSocketAPI:BaseSocketAPI, DiscoverAPI{
   

    
    //网红互动和热度
    func requestStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starList, model: requestModel)
        startModelsRequest(packet, listName: "symbol_info", modelClass: StarSortListModel.self, complete: complete, error: error)
    }
    //抢购网红列表
    func requestScrollStarList(requestModel:StarSortListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starScrollList, model: requestModel)
        startModelRequest(packet, modelClass: DiscoverListModel.self, complete: complete, error: error)
    }
    //请求剩余时间
    func requestBuyRemainingTime(requestModel:BuyRemainingTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packt = SocketDataPacket(opcode: .remainingTime, model: requestModel)
        startModelRequest(packt, modelClass: BuyRemainingTimeModel.self, complete: complete, error: error)
        
    }
    //抢购网红信息
    func requsetPanicBuyStarInfo(requestModel:PanicBuyRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .panicBuyStarInfo, model: requestModel)
        startModelRequest(packet, modelClass: PanicBuyInfoModel.self, complete: complete, error: error)
    }
    //网红介绍页信息
    func requestStarDetailInfo(requestModel:StarDetaiInfoRequestModel,complete: CompleteBlock?, error: ErrorBlock? ) {
        let packet = SocketDataPacket(opcode: .starDetailInfo, model: requestModel)
        startModelRequest(packet, modelClass: StarIntroduceResult.self, complete: complete, error: error)
    }
    //抢购网红
    func buyStarTime(requestModel:BuyStarTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .panicBuy, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
    //视频问答
    func videoAskQuestion(requestModel:AskRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet = SocketDataPacket(opcode: .askVideo, model: requestModel)
        
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
        
    }
    //语音问答
    func useraskQuestion(requestModel:UserAskRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
    
        let packet = SocketDataPacket(opcode: .userask, model: requestModel)
        
        startModelRequest(packet, modelClass: UserAskList.self, complete: complete, error: error)

    }
    func staraskQuestion(requestModel:StarAskRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        
        let packet = SocketDataPacket(opcode: .starask, model: requestModel)
        
        startModelRequest(packet, modelClass: UserAskList.self, complete: complete, error: error)
        
    }
    func peepAnswer(requestModel:PeepVideoOrvoice, complete: CompleteBlock?, error: ErrorBlock?){
        let packet = SocketDataPacket(opcode: .qeepask, model: requestModel)
        
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    func requestStarDetail(requestModel:CirCleStarDetail,complete: CompleteBlock?, error: ErrorBlock?){
    
        let packet = SocketDataPacket(opcode: .circleListdetail, model: requestModel)
        
        startModelRequest(packet, modelClass: StarDetailCircle.self, complete: complete, error: error)
    
    }
}
