//
//  LoginApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol LoginApi {
    
     

    // 注册（模型）
    func regist(model: RegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 登录（模型）
    func login(model:LoginRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    // 微信绑定(模型)
    func BindWeichat(model: WXRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 微信登录(模型)
    func WeChatLogin(model:WeChatLoginRequestModel,complete: CompleteBlock? , error: ErrorBlock?)
    
    // 校验用户是否注册(模型)
    func CheckRegister(model:CheckRegisterRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    // 发送验证码(模型)
    func SendVerificationCode(model:SendVerificationCodeRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    // 重置密码(模型)
    func ResetPasswd(model:ResetPassWdRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
    // 注册网易云(模型)
    func registWYIM(model:RegisterWYIMRequestModel,complete:CompleteBlock?,error:ErrorBlock?)
    

    // 获取七牛api
    func qiniuHttpHeader(complete:CompleteBlock?,error:ErrorBlock?)
}
