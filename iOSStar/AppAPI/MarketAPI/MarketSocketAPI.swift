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
   func searchstar(code : String,  complete: CompleteBlock?, error: ErrorBlock?){
        let paramters:[String:Any] = [SocketConst.Key.starCode : code]
        let packet = SocketDataPacket(opcode: .searchStar, parameters: paramters)
        startModelsRequest(packet, listName: "list", modelClass: MarketClassifyModel.self, complete: complete, error: error)
    }
    

    //单个分类明星列表
    func requestStarList(type:Int,startnum:Int, endnum:Int,complete: CompleteBlock?, error: ErrorBlock?) {
        let paramters:[String:Any] = [SocketConst.Key.startnum : startnum,
                                      SocketConst.Key.endnum : endnum,
                                      SocketConst.Key.type : type,
                                      SocketConst.Key.sorttype : 0]
        let packet = SocketDataPacket(opcode: .marketStar, parameters: paramters)
        

        startModelsRequest(packet, listName: "list", modelClass: MarketListStarModel.self, complete: complete, error: error)
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

    //分时图
    func requestLineViewData(starcode:String,complete: CompleteBlock?, error: ErrorBlock?) {
        let parameters:[String : Any] = [SocketConst.Key.starcode:starcode]
        let packet = SocketDataPacket(opcode: .lineData, parameters: parameters)
        startModelsRequest(packet, listName: "stastic", modelClass: LineModel.self, complete: complete, error: error)
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

    //获取评论列表
    func requestCommentList(starcode:String,complete: CompleteBlock?, error: ErrorBlock?) {
        let parameters:[String : Any] = [SocketConst.Key.starcode : "1001"]
        let packet = SocketDataPacket(opcode: .commetList, parameters: parameters)
        startModelsRequest(packet, listName: "list", modelClass: CommentModel.self, complete: complete, error: error)
    }
    //获取明星经历
    func requestStarExperience(code:String,complete: CompleteBlock?, error: ErrorBlock?) {
        let parameters:[String:Any] = [SocketConst.Key.starCode : code]
        let packet = SocketDataPacket(opcode: .starExperience, parameters: parameters)
        startModelsRequest(packet, listName: "list", modelClass: ExperienceModel.self, complete: complete, error: error)
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

}
