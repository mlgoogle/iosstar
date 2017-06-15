//
//  SockOpcode.swift
//  viossvc
//
//  Created by yaowang on 2016/11/22.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation

class SocketConst: NSObject {
    enum OPCode:UInt16 {
        // 心跳包
        case heart = 1000
        // 获取图片上传token
        case imageToken = 1047
        // 错误码
        case errorCode = 0
        // 登录
        case login = 3003
        // 注册
        case register = 3001
        // 注册
        case reducetime = 9017
       //减少时间
        case getlist = 6013
        // 重设密码
        case repwd = 3019
        // 声音验证码
        case voiceCode = 1006
        // 设置用户信息
        case userInfo = 10010
        case bindWchat = 3015
        //设置账号信息
        case WchatLogin = 3013
        case verifycode = 3011
        case getRealm = 3027
        // 校验用户
        case checkRegist = 3029
        //网易云
        case registWY = 9005
        case userinfo = 3007
        // 修改昵称
        case modifyNickname = 3031

        case paypwd = 7011

        case getorderstars = 10012
        case  tokenLogin  = 3009
        //明星个人信息
        case starInfo = 11005
        //资讯列表
        case newsInfo = 10013
       
        // banner
        case banners = 10015
        //行情分类
        case marketType = 11001

        //搜索
        case searchStar = 13001

        //搜索
        case weixinpay = 7033
        //我的资产
        case accountMoney = 1004
        case detailList = 1005
        case creditlist = 6003
        case restPwd = 3005
        case authentication = 3021
        //分类明星
        case marketStar = 11003
        
        //分时图
        case lineData = 11017

        //添加自选
        case addOptinal = 11015
        case realName = 7045
        //评论列表
        case commetList = 10017
        
        //明星经历
        case starExperience = 11009
        //明星成就
        case starAchive = 11011
        
        case newsStarInfo = 10001
        
        // 明星服务类型
        case starServiceType = 10019
        // 订购明星服务
        case buyStarService = 10021
        // 获取已购明星数量
        case buyStarCount = 10023
        //实时报价
        case realTime = 4001
        //分时图
        case timeLine = 4003
        //明星列表
        case starList = 4007
        //发送评论
        case sendComment = 12001
        //评论列表
        case commentList = 12003
        //发起委托
        case buyOrSell = 5001
        //收到匹配成功
        case receiveMatching = 5101
        //获取拍卖时间
        case auctionStatus = 5005
        
        //确认订单
        case sureOrder = 5007
        
        //取消订单
        case cancelOrder = 5009
        
        //双方确认后结果推送
        case orderResult = 7102
        
        
    }
    enum type:UInt8 {
        case error  = 0
        case wp     = 1
        case chat   = 2
        case user   = 3
        case time   = 4
        case deal   = 5
        case operate = 6
        case order = 7
        case getlist = 9
        case news = 10
        case market = 11
        case comment = 12
        case search = 13
    }
    
    enum aType:UInt8 {
        case shares = 1 //股票
        case spot = 2   //现货
        case futures = 3   //期货
        case currency = 4   //外汇
    }
    
    class Key {
        static let name = "name"
        static let phone = "phone"
        static let pwd = "pwd"
        static let pos = "startPos"
        static let code = "vCode"
        static let appid = "appid"
        static let secret = "secret"
        static let grant_type = "grant_type"
        static let memberId = "memberId"
        static let agentId = "agentId"
        static let recommend = "recommend"
        static let status = "status"
        static let uid  = "id"
        static let vToken = "vToken"
        static let avatarLarge = "avatarLarge"
        static let timestamp = "timeStamp"
        static let timetamp = "timestamp"
        static let aType = "aType"
        static let name_value = "name_value"
        static let accid_value = "accid_value"
        static let deviceId = "deviceId"
        static let vCode = "vCode"
        static let openid = "openid"
        static let nickname = "nickname"
        static let headerUrl = "headerUrl"
        static let headimgurl = "headimgurl"
        static let accessToken = "access_token"
        static let accid = "accid"
        static let createtime = "createtime"
        static let starcode = "starcode"
        static let deduct_amount = "deduct_amount"
        static let startnum = "startnum"
        static let endnum = "endnum"
        static let all = "all"
        static let countNuber = "count"
        static let starCode = "code"
        static let type = "type"
        static let sorttype = "sorttype"
        static let title = "title"
        static let price = "price"
        static let token = "token"
        static let realname = "realname"
        static let id_card = "id_card"
        static let checkRegist = "checkRegist"
        static let time = "time"
        static let id = "uid"
        static let paypwd = "paypwd"
    }
}
