//
//  MarketSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/5/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class MarketSocketAPI: BaseSocketAPI,MarketAPI {


    
    //请求行情分类
    func requestTypeList(complete: CompleteBlock?, error: ErrorBlock?) {
        
        let paramters:[String:Any] = [SocketConst.Key.phone : "123"]
        let packet = SocketDataPacket(opcode: .marketType, parameters: paramters)
        
        startModelsRequest(packet, listName: "list", modelClass: MarketClassifyModel.self, complete: complete, error: error)
    }
    //搜索
    func searchstar(requestModel:MarketSearhModel,  complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .searchStar, model: requestModel, type:.search)
        startModelsRequest(packet, listName: "starsinfo", modelClass: SearchResultModel.self, complete: complete, error: error)
    }
    

    //单个分类明星列表
    func requestStarList(requestModel:StarListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {

        let packet = SocketDataPacket(opcode: .starList, model: requestModel)

        startModelsRequest(packet, listName: "symbol_info", modelClass: MarketListStarModel.self, complete: complete, error: error)
    }
    //自选明星
    func requestOptionalStarList(startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?) {
        
        guard UserDefaults.standard.string(forKey: SocketConst.Key.phone) != nil else {
            return
        }
        let paramters:[String:Any] = [SocketConst.Key.startnum : startnum,
                                      SocketConst.Key.endnum : endnum,
                                      SocketConst.Key.phone : UserDefaults.standard.string(forKey: SocketConst.Key.phone)!]
        let packet = SocketDataPacket(opcode: .marketStar, parameters: paramters)
        startModelsRequest(packet, listName: "list", modelClass: MarketListStarModel.self, complete: complete, error: error)
    }


    //添加自选明星
    func addOptinal(starcode:String,complete: CompleteBlock?, error: ErrorBlock?) {
        guard UserDefaults.standard.string(forKey: SocketConst.Key.phone) != nil else {
            return
        }
        let parameters:[String:Any] = [SocketConst.Key.starcode:starcode,
                                       SocketConst.Key.phone:UserDefaults.standard.string(forKey: SocketConst.Key.phone)!]
        let packet = SocketDataPacket(opcode: .addOptinal, parameters: parameters)
        startResultIntRequest(packet, complete: complete, error: error)
    }


    //获取明星经历
    func requestStarExperience(code:String,complete: CompleteBlock?, error: ErrorBlock?) {
        let parameters:[String:Any] = [SocketConst.Key.starCode : code]
        let packet = SocketDataPacket(opcode: .starExperience, parameters: parameters)
        startModelsRequest(packet, listName: "list", modelClass: ExperienceModel.self, complete: complete, error: error)
    }
    func requestStarArachive(code:String,complete: CompleteBlock?, error: ErrorBlock?) {
        let parameters:[String:Any] = [SocketConst.Key.starCode : code]
        let packet = SocketDataPacket(opcode: .starAchive, parameters: parameters)
        startModelsRequest(packet, listName: "list", modelClass: AchiveModel.self, complete: complete, error: error)

    }
    //获取实时报价
    func requestRealTime(requestModel:RealTimeRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .realTime, model: requestModel)
        startModelsRequest(packet, listName: "priceinfo", modelClass: RealTimeModel.self, complete: complete, error: error)
    }
    //获取分时图
    func requestTimeLine(requestModel:TimeLineRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .timeLine, model: requestModel)
        startModelsRequest(packet, listName: "priceinfo", modelClass: TimeLineModel.self, complete: complete, error: error)
    }
    //发送评论
    func sendComment(requestModel:SendCommentModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .sendComment, model: requestModel)
        startRequest(packet, complete: complete, error: error)
        
    }
    //获取评论列表
    func requestCommentList(requestModel:CommentListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .commentList, model: requestModel)
        startRequest(packet, complete: complete, error: error)
    }
    
    //获取拍卖时间
    func requestAuctionStatus(requestModel:AuctionStatusRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .auctionStatus, model: requestModel)
        startModelRequest(packet, modelClass: AuctionStatusModel.self, complete: complete, error: error)
    }
    
    // 获取明星服务类型
    func requestStarServiceType(starcode: String, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let parameters:[String:Any] = [SocketConst.Key.starcode : starcode]
        
        let packet = SocketDataPacket(opcode: .starServiceType, parameters: parameters)
        
        startModelsRequest(packet, listName: "list", modelClass: ServiceTypeModel.self, complete: complete, error: error)
    }
    // 订购明星服务
    func requestBuyStarService(requestModel: ServiceTypeRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .buyStarService, model: requestModel)

        startRequest(packet, complete: complete, error: error)
    }

    //委托粉丝榜
    func requestEntrustFansList(requestModel:FanListRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .fansList, model: requestModel)
        startModelsRequest(packet, listName: "positionsList", modelClass: FansListModel.self, complete: complete, error: error)
    }
    //订单粉丝榜
    func requestOrderFansList(requestModel:FanListRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .orderFansList, model: requestModel)
        startModelsRequest(packet, listName: "ordersList", modelClass: OrderFansListModel.self, complete: complete, error: error)
    }
}
