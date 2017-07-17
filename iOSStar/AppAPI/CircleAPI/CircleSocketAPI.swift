//
//  CircleSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class CircleSocketAPI: BaseSocketAPI, CircleAPI{
    //朋友圈
    func requestCircleList(requestModel:CircleListRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .circleList, model: requestModel)
        startModelsRequest(packet, listKey: "circle_list", modelClass: CircleListModel.self, complete: complete, error: error)
    }
    //评论动态
    func commentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .commentCircle, model: requestModel)
//        startResultIntRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    func starCommentCircle(requestModel:CommentCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .starComment, model: requestModel)
//        startResultIntRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }

    //点赞动态
    func approveCircle(requestModel:ApproveCircleModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .approveCircle, model: requestModel)
//        startResultIntRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
    //发送动态
    func sendCircle(requestModel:SendCircleRequestModel,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .sendCircle, model: requestModel)
        startModelRequest(packet, modelClass: SendCircleResultModel.self, complete: complete, error: error)
    }
    
    //删除动态
    func deleteCircle(requestModel:DeleteCircle, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .deleteCircle, model: requestModel)
//        startResultIntRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: ResultModel.self, complete: complete, error: error)
    }
}
