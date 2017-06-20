
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
                                    SocketConst.Key.countNuber :  count,
                                    SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token) ?? ""),]

        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .getlist, dict: param as [String : AnyObject], type: .getlist)
//        startRequest(packet, complete: complete, error: error)
        
          startModelRequest(packet, modelClass: StarListModel.self, complete: complete, error: error)
    }
    //聊天减时间
    func reducetime(phone: String, starcode: String,deduct_amount:Int64,complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.starcode:  starcode,
                                    SocketConst.Key.deduct_amount : deduct_amount,]
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
        print(param)
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
    func creditlist(status: Int32, pos: Int32, count: Int32,time:String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token) ?? ""),
                     SocketConst.Key.status: status,
                     SocketConst.Key.pos: pos,
                     SocketConst.Key.countNuber: count ,
                     SocketConst.Key.time : time] as [String : Any]
        
        
         let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .creditlist, dict: param  as [String : AnyObject])
        print(param)
        startModelRequest(packet, modelClass: RechargeListModel.self, complete: complete, error: error)
    }
    
    // MARK: - 设置支付密码
    func ResetPassWd(timestamp : Int64,vCode : String,vToken : String,pwd: String,type : Int, phone :String, complete: CompleteBlock?, error: ErrorBlock?)
     {
        
        let param = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.timetamp: timestamp,
                     SocketConst.Key.vCode: vCode,
                     SocketConst.Key.type: type,
                     SocketConst.Key.vToken: vToken,
                     SocketConst.Key.pwd: pwd,
                     SocketConst.Key.phone: phone] as [String : Any]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .restPwd, dict: param  as [String : AnyObject])
        
         startRequest(packet, complete: complete, error: error)
    
    }
     // MARK: 重置支付密码
    func ResetPayPwd(requestModel: ResetPayPwdRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet = SocketDataPacket(opcode: .restPwd, model: requestModel)
        
        startRequest(packet, complete: complete, error: error)
        
    }
    // MARK: - 实名认证接口
    func authentication(realname: String, id_card: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.realname: realname,
                     SocketConst.Key.id_card: id_card,
                       ] as [String : Any]
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .authentication, dict: param  as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)

    }
    
    // MARK: - 获取实名认证信息
    func getauthentication( complete: CompleteBlock?, error: ErrorBlock?) {
    
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token)!),]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .getRealm, dict: param as [String : AnyObject])
        startRequest(packet, complete: complete, error: error)

    }
    //  MARK: -  获取用户信息
    func getauserinfo( complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token) ?? ""),]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .userinfo, dict: param as [String : AnyObject])
        startModelRequest(packet, modelClass: UserInfoModel.self, complete: complete, error: error)
        
    }
    // MARK: -  tokenLogin token登录
    func tokenLogin( complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                    SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token) ?? ""),]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .tokenLogin, dict: param as [String : AnyObject])
        //startRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: UserModel.self, complete: complete, error: error)
    }
    
    // MARK: - 修改昵称
    func modifyNickName(nickname:String, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param = [SocketConst.Key.id : UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                     SocketConst.Key.token : String.init(format: "%@",  (UserModel.share().getCurrentUser()?.token)!),
                     SocketConst.Key.nickname: nickname,] as [String : Any]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .modifyNickname, dict: param  as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: 已购明星接口
    func requestBuyStarCount(complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param: [String: Any] = [SocketConst.Key.id: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .buyStarCount, dict: param  as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)

    }
    // MARK: 获取明星名称
    func addstarinfo(complete: CompleteBlock?, error: ErrorBlock?){
        let param = [SocketConst.Key.phone :"1123",
                     SocketConst.Key.starCode : " 123",
                     SocketConst.Key.all: 1,] as [String : Any]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .newsStarInfo, dict: param  as [String : AnyObject])
        
        startModelsRequest(packet, listName: "list", modelClass: StartModel.self, complete: complete, error: error)
    }
     // MARK: 支付宝支付
    func alipay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String : Any] = [SocketConst.Key.uid: UserModel.share().getCurrentUser()?.userinfo?.id ?? 0,
                                     
                                     SocketConst.Key.title: title,SocketConst.Key.price: price]
        
        let packet: SocketDataPacket =  SocketDataPacket.init(opcode: .alipay, dict: param  as [String : AnyObject])
        print(param)
        startRequest(packet, complete: complete, error: error)
    }
    //版本更新提醒
    func update(type: Int, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .update, dict: ["ttype": type as AnyObject], type: .user)
        startModelRequest(packet, modelClass: UpdateParam.self, complete: complete, error: error)
    }
    
}
