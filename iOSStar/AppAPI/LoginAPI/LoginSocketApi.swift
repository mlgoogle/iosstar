//
//  LoginSocketApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import UIKit

class LoginSocketApi: BaseSocketAPI, LoginApi {
    
    // 注册（模型）
    func regist(model: RegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .register, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // 登录(模型)
    func login(model: LoginRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .login, model: model)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    //微信绑定(模型)
    func BindWeichat(model: WXRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?){
        let packet: SocketDataPacket = SocketDataPacket.init(opcode: .bindWchat, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    
    // 微信登录(模型)
    func WeChatLogin(model:WeChatLoginRequestModel,complete: CompleteBlock? , error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .WchatLogin, model: model)
        startModelRequest(packet, modelClass: StarUserModel.self, complete: complete, error: error)
    }
    
    // 校验用户登录(模型)
    func CheckRegister(model: CheckRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .checkRegist, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // 发送验证码(模型)
    func SendVerificationCode(model: SendVerificationCodeRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet:SocketDataPacket = SocketDataPacket.init(opcode: .verifycode, model: model)
        startRequest(packet, complete: complete, error: error)
    }
    
    // 重置登录密码(模型)
    func ResetPasswd(model: ResetPassWdRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .repwd, model: model)
        startRequest(packet, complete: complete, error: error)
    }
   
    // 注册网易云(模型)
    func registWYIM(model: RegisterWYIMRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .registWY, model: model)
        startModelRequest(packet, modelClass: WYIMModel.self, complete: complete, error: error)
    }
}
