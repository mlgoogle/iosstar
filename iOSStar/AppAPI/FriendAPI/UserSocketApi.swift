//
//  UserSocketApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class UserSocketApi: BaseSocketAPI, UserApi  {
    
    func starmaillist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
    
        
        let param: [String: Any] = [SocketConst.Key.status: status,
                                    SocketConst.Key.pos :  pos,
                                    SocketConst.Key.countNuber :  count,SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token)!),]

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
    //微信支付
    func weixinpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    
                                     SocketConst.Key.title: title,SocketConst.Key.price: price]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .weixinpay, dict: param  as [String : AnyObject])
//        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    //我的资产
    func accountMoney(complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .accountMoney, dict: param as [String : AnyObject], type: SocketConst.type.wp)
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    //资金明细列表
    func creditlist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token)!),
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count] as [String : Any]
        
        
         let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .creditlist, dict: param  as [String : AnyObject])
        print(param)
        startModelRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)
    }
    
    func ResetPassWd(timestamp : Int64,vCode : String,vToken : String,pwd: String,type : Int, complete: CompleteBlock?, error: ErrorBlock?)
     {
        
        let param = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.timetamp: timestamp,
                     SocketConst.Key.vCode: vCode,
                     SocketConst.Key.type: type,
                     SocketConst.Key.vToken: vToken,
                     SocketConst.Key.pwd: pwd] as [String : Any]
        
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .restPwd, dict: param  as [String : AnyObject])
        
         startRequest(packet, complete: complete, error: error)
    
    }
    

}
