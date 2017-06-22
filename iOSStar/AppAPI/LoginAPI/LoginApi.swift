//
//  LoginApi.swift
//  wp
//
//  Created by 木柳 on 2016/12/21.
//  Copyright © 2016年 com.yundian. All rights reserved.
//

import Foundation

protocol LoginApi {
    
     
    //注册
    func regist(phone: String, password: String, complete: CompleteBlock?, error: ErrorBlock?)
    //注册（模型）
    func regist(model: RegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    //注册网易云
    func registWYIM(phone: String, token: String, complete: CompleteBlock?, error: ErrorBlock?)
    //登录
    func login(phone: String, password: String, complete: CompleteBlock?, error: ErrorBlock?)
    
    //微信绑定
    func BindWeichat(phone: String, timeStamp: Int,vToken: String,pwd: String,openid: String,nickname: String,headerUrl: String,memberId: Int,agentId: String,recommend: String,deviceId: String,vCode: String, complete: CompleteBlock?, error: ErrorBlock?)
    //微信绑定(模型)
    func BindWeichat(model: WXRegisterRequestModel, complete: CompleteBlock?, error: ErrorBlock?)
    
    //微信登录
    func WeichatLogin(openid: String, deviceId: String, complete: CompleteBlock?, error: ErrorBlock?)
    //发送验证码
    func SendCode(phone: String, complete: CompleteBlock?, error: ErrorBlock?)
    //重置密码
    func ResetPassWd(phone: String,pwd: String, complete: CompleteBlock?, error: ErrorBlock?)
    // 校验是否注册
    func checkRegist(phone:String,complete: CompleteBlock?, error: ErrorBlock?)
}
