//
//  UserApi.swift
//  iOSStar
//
//  Created by sum on 2017/5/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol UserApi {
    
      //获取好友列表
     func starmaillist(status: Int32, pos: Int32, count: Int32, complete: CompleteBlock?, error: ErrorBlock?)
      //发送时间少一秒
      func reducetime(phone: String, starcode: String,deduct_amount:Int64, complete: CompleteBlock?, error: ErrorBlock?)
      //预约的明细
      func getorderstars(phone: String, starcode: String, complete: CompleteBlock?, error: ErrorBlock?)
     // 微信支付
      func weixinpay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?)
     // 我的资产接口
     func accountMoney(complete: CompleteBlock?, error: ErrorBlock?)
     // 资金明细列表
    func creditlist(status: Int32, pos: Int32, count: Int32,time : String, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 设置交易密码
    func ResetPassWd(timestamp : Int64,vCode : String,vToken : String,pwd: String,type : Int, phone :String, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 重置支付密码
    func ResetPayPwd(requestModel:ResetPayPwdRequestModel,complete: CompleteBlock?, error: ErrorBlock?)
    
     // 实名认证
     func authentication(realname: String, id_card: String, complete: CompleteBlock?, error: ErrorBlock?)
    // 获取实名认证信息
     func getauthentication( complete: CompleteBlock?, error: ErrorBlock?)
     // 获取用户信息
     func getauserinfo( complete: CompleteBlock?, error: ErrorBlock?)
    // tokenLogin token登录
     func tokenLogin( complete: CompleteBlock?, error: ErrorBlock?)
    func weichattokenLogin( id:Int64,token:String,complete: CompleteBlock?, error: ErrorBlock?)
    // 修改nickname 
    func modifyNickName(nickname:String, complete: CompleteBlock?, error: ErrorBlock?)
    
    // 获取已购明星数量
    func requestBuyStarCount(complete: CompleteBlock?, error: ErrorBlock?)
    func addstarinfo(complete: CompleteBlock?, error: ErrorBlock?)
    
    // 支付宝支付
    func alipay(title:String,  price:Double, complete: CompleteBlock?, error: ErrorBlock?)
    
    //获取版本更新信息
    func update(type: Int, complete: CompleteBlock?, error: ErrorBlock?)

    //更新devicetoken
    func updateDeviceToken(requestModel:UpdateDeviceTokenModel, complete: CompleteBlock?, error: ErrorBlock?)
    
}
