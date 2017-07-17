
//
//  DealSocketAPI.swift
//  iOSStar
//
//  Created by J-bb on 17/6/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
class DealSocketAPI: BaseSocketAPI, DealAPI{
    
    func allOrder(requestModel:DealRecordRequestModel,OPCode:SocketConst.OPCode,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .allOrder, model: requestModel)
        startModelsRequest(packet, listName: "ordersList", modelClass: OrderListModel.self, complete: complete, error: error)

    }
    //发起委托
    func buyOrSell(requestModel:BuyOrSellRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .buyOrSell, model: requestModel)
        startModelRequest(packet, modelClass: EntrustSuccessModel.self, complete: complete, error: error)
    }

    
    //确认订单
    func sureOrderRequest(requestModel:SureOrderRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .sureOrder, model: requestModel)
        startModelRequest(packet, modelClass: SureOrderResultModel.self, complete: complete, error: error)
    }
    
    //取消订单
    func cancelOrderRequest(requestModel:CancelOrderRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: .cancelOrder, model: requestModel)
        startResultIntRequest(packet, complete: complete, error: error)
    }
    //收到订单结果
    func setReceiveOrderResult(complete:@escaping CompleteBlock) {
        SocketRequestManage.shared.receiveOrderResult = { (response) in
            let jsonResponse = response as! SocketJsonResponse
            let model = jsonResponse.responseModel(OrderResultModel.self) as? OrderResultModel
            if  model != nil {
                complete(model)
            }
        }
    }
    
    //收到匹配成功
    func setReceiveMatching(complete:@escaping CompleteBlock) {
        SocketRequestManage.shared.receiveMatching = { (response) in
            let jsonResponse = response as! SocketJsonResponse
            let model = jsonResponse.responseModel(ReceiveMacthingModel.self) as? ReceiveMacthingModel
            if  model != nil {
                complete(model)
            }
        }
    }

    //验证交易密码
    func checkPayPass( paypwd: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.id: StarUserModel.getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.paypwd :paypwd, SocketConst.Key.token :StarUserModel.getCurrentUser()?.token ?? ""]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .paypwd, dict: param as [String : AnyObject])
         startRequest(packet, complete: complete, error: error)
    
    }
    //请求委托列表
    func requestEntrustList(requestModel:DealRecordRequestModel,OPCode:SocketConst.OPCode,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode:OPCode, model: requestModel)
        startModelsRequest(packet, listName: "positionsList", modelClass: EntrustListModel.self, complete: complete, error: error)
    }
    
    //订单列表
    func requestOrderList(requestModel:OrderRecordRequestModel,OPCode:SocketConst.OPCode,complete: CompleteBlock?, error: ErrorBlock?) {
        let packet = SocketDataPacket(opcode: OPCode, model: requestModel)
        startModelsRequest(packet, listName: "ordersList", modelClass: OrderListModel.self, complete: complete, error: error)
    }
}
