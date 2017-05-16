//
//  FriendSocketApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class FriendSocketApi: BaseSocketAPI, FriendApi  {
    
    func getfriendList(accid: String, createtime: String, complete: CompleteBlock?, error: ErrorBlock?){
    
        
        let param: [String: Any] = [SocketConst.Key.accid: accid,
                                    SocketConst.Key.createtime:  createtime,]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .getlist, dict: param as [String : AnyObject], type: .getlist)
//        startRequest(packet, complete: complete, error: error)
        
          startModelRequest(packet, modelClass: StarListModel.self, complete: complete, error: error)
    }
    func reducetime(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.starcode:  starcode,]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .reducetime, dict: param as [String : AnyObject], type: .getlist)
        startRequest(packet, complete: complete, error: error)
    }
    func getorderstars(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.starcode:  starcode,]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .getorderstars, dict: param as [String : AnyObject], type: .getlist)
        startRequest(packet, complete: complete, error: error)
    
    }
}
