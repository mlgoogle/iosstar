//
//  LoginSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class LoginSocketApi: BaseSocketAPI, LoginApi {
    
    // MARK: - 注册
    func regist(phone: String, password: String, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd:  password,
                                    SocketConst.Key.memberId: 1001,
                                    SocketConst.Key.agentId:  "186681261",
                                    SocketConst.Key.recommend: "3tewe",
                                    SocketConst.Key.timestamp: 100088888]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, dict: param as [String : AnyObject])
        
       startRequest(packet, complete: complete, error: error)
    }
    // 注册（模型）
    func regist(model: RegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 登录
    func login(phone: String, password: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd:  password,
                                    SocketConst.Key.deviceId: "deviceId"]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .login, dict: param as [String : AnyObject])
        //startRequest(packet, complete: complete, error: error)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    // 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .login, model: model)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    
    // MARK: - 微信绑定
      func BindWeichat(phone: String, timeStamp: Int,vToken: String,pwd: String,openid: String,nickname: String,headerUrl: String,memberId: Int,agentId: String,recommend: String,deviceId: String,vCode: String, complete: CompleteBlock?, error: ErrorBlock?){
    
        let param: [String: Any] = [SocketConst.Key.vCode: vCode,
                                    SocketConst.Key.timestamp:  timeStamp,
                                    SocketConst.Key.vToken: vToken,
                                    SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd: pwd,
                                    SocketConst.Key.openid: openid,
                                    SocketConst.Key.nickname: nickname,
                                    SocketConst.Key.headerUrl: headerUrl,
                                    SocketConst.Key.memberId: memberId,
                                    SocketConst.Key.agentId: agentId,
                                    SocketConst.Key.recommend: recommend,
                                    SocketConst.Key.deviceId: deviceId,
                                    ]
        // print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .bindWchat, dict: param as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
    }
    
    //微信绑定(模型)
    func BindWeichat(model: WXRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .bindWchat, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    
    // MARK: - 微信登录
    func WeichatLogin(openid: String, deviceId: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.openid: openid,
                                    SocketConst.Key.deviceId:  deviceId,
                                    ]
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .WchatLogin, dict: param as [String : AnyObject])
        
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    // 微信登录(模型)
    func WeChatLogin(model:WeChatLoginRequestModel,complete: CompleteBlock? , error: ErrorBlock?) {
        
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .WchatLogin, model: model)
        
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    // MARK: - 校验用户是否注册
    func checkRegist(phone: String, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let param : [String : Any] = [SocketConst.Key.phone : phone]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .checkRegist,dict : param as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
        
    }
    
    // 校验用户登录(模型)
    func CheckRegister(model: CheckRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .checkRegist, model: model)
        
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 发送验证码
    func SendCode(phone: String, complete: CompleteBlock?, error: ErrorBlock?){
        
        let param: [String: Any] = [SocketConst.Key.phone: phone,]
        
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .verifycode, dict: param as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
    }
    
    // 发送验证码(模型)
    func SendVerificationCode(model: SendVerificationCodeRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        
        let packet:SocketDataPacket = SocketDataPacket.init(opcode: .verifycode, model: model)
        
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 重置登录密码
    func ResetPassWd(phone: String,pwd: String, complete: CompleteBlock?, error: ErrorBlock?) {
        let param: [String: Any] = [SocketConst.Key.phone: phone,
                                    SocketConst.Key.pwd:  pwd,]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .repwd, dict: param as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
    }
    // 重置登录密码(模型)
    func ResetPasswd(model: ResetPassWdRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .repwd, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // MARK: - 注册网易云
    func registWYIM(phone: String, token: String, complete: CompleteBlock?, error: ErrorBlock?){
        let param: [String: Any] = [SocketConst.Key.name_value: phone,
                                    SocketConst.Key.phone: phone,
                                    SocketConst.Key.accid_value:  token,
                                    SocketConst.Key.memberId: 1001,
                                    SocketConst.Key.agentId:  "186681261",
                                    SocketConst.Key.recommend: "3tewe",
                                    SocketConst.Key.timestamp: 100088888]
        print(param)
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .registWY, dict: param as [String : AnyObject])
        
        startRequest(packet, complete: complete, error: error)
    }
    // 注册网易云(模型)
    func registWYIM(model: RegisterWYIMRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .registWY, model: model)
        startModelRequest(packet, modelClass: WYIMModel.self, complete: complete, error: error)
    }

    

    
    
   
}
