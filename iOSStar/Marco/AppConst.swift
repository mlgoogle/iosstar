//
//  AppConfig.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import UIKit



typealias CompleteBlock = (AnyObject?) ->()
typealias ErrorBlock = (NSError) ->()
typealias paramBlock = (AnyObject?) ->()?

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
//MARK: --正则表达
func isTelNumber(num: String)->Bool
{
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^1[3|4|5|7|8][0-9]\\d{8}$")
    return predicate.evaluate(with: num)
}
// 密码校验
func isPassWord(pwd: String) ->Bool {
    let predicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "(^[A-Za-z0-9]{6,20}$)")
    return predicate.evaluate(with: pwd)
}


class AppConst {
    static let DefaultPageSize = 15
    static let UMAppkey = "584a3eb345297d271600127e"
    static let isMock = false
    static let sha256Key = "t1@s#df!"
    static let pid = 1002
    static let bundleId = "com.newxfin.goods"
    static let loginSuccess = "loginSuccess"
    static let loginSuccessNotice = "loginSuccessNotice"
    static let chooseServiceTypeSuccess = "chooseServiceTypeSuccess"
    static let valueStarCode = "valueStarCode"
    
    enum KVOKey: String {
        case selectProduct = "selectProduct"
        case allProduct = "allProduct"
        case currentUserId = "currentUserId"
        case balance = "balance"
    }
    
    enum NoticeKey: String {
        case logoutNotice = "LogoutNotice"
    }
    
    class Color {

        static let main = "921224"
        static let orange = "FB9938"
        static let up = "CB4232"
        static let down = "18B03F"
        static let titleColor = "8C0808"
        static let background = "background"
        static let auxiliary = "auxiliary"
        static let lightBlue = "lightBlue"
    };
     class SystemFont {
        static let S1 = UIFont.systemFont(ofSize: 18)
        static let S2 = UIFont.systemFont(ofSize: 15)
        static let S3 = UIFont.systemFont(ofSize: 13)
        static let S4 = UIFont.systemFont(ofSize: 12)
        static let S5 = UIFont.systemFont(ofSize: 10)
        static let S14 = UIFont.systemFont(ofSize: 14)
    };
    
    class Network {
        #if false  //是否测试环境
        static let TcpServerIP:String = "139.224.34.22";
        static let TcpServerPort:UInt16 = 16104
        static let TttpHostUrl:String = "139.224.34.22";
        #else
        static let TcpServerIP:String = "139.224.34.22";
        static let TcpServerPort:UInt16 = 16104;
        static let HttpHostUrl:String = "139.224.34.22";
        
        #endif
        static let TimeoutSec:UInt16 = 10
        static let qiniuHost = "http://ofr5nvpm7.bkt.clouddn.com/"
    }
    class Text {
        static let PhoneFormatErr = "请输入正确的手机号"
        static let VerifyCodeErr  = "请输入正确的验证码"
        static let SMSVerifyCodeErr  = "获取验证码失败"
        static let PasswordTwoErr = "两次密码不一致"
        static let ReSMSVerifyCode = "重新获取"
        static let ErrorDomain = "com.redsky.starshare"
        static let PhoneFormat = "^1[3|4|5|7|8][0-9]\\d{8}$"
        static let RegisterPhoneError = "输入的手机号已注册"
        static let numberReg = "^(?!0(\\d|\\.0+$|$))\\d+(\\.\\d{1,2})?$"
    }
    
    
    enum Action:UInt {
        case callPhone = 10001
        case handleOrder = 11001
    }
    
    enum BundleInfo:String {
        case CFBundleDisplayName = "CFBundleDisplayName"
        case CFBundleShortVersionString = "CFBundleShortVersionString"
        case CFBundleVersion = "CFBundleVersion"
    }
    
    enum StoryBoardName:String {
        case Markt = "Market"
        case News = "News"
        case Deal = "Deal"
        case User = "User"
        case Login = "Login"
        case Exchange = "Exchange"
    }
    
    enum RegisterIdentifier:String {
        
        case MarketDetailMenuView = "MarketDetailMenuView"
        case PubInfoHeaderView = "PubInfoHeaderView"
        case MaketBannerCell = "MaketBannerCell"
        case MarketInfoCell = "MarketInfoCell"
        case MarketExperienceCell = "MarketExperienceCell"
        case FansListHeaderView = "FansListHeaderView"
        case MarketFansCell = "MarketFansCell"
        case MarketCommentCell = "MarketCommentCell"
        case NewsListCell = "NewsListCell"
    }
    
    enum SegueIdentifier:String {
        case newsToDeatail = "newsToDeatail"
        case showPubPage = "showPubPage"
    }
    enum DealType:Int {
        case buy = 1
        case sell = -1
    }
    
    enum OrderStatus:Int32 {
        case pending = 0
        case matching = 1
        case complete = 2
    }
    
    enum SortType:Int {
        case down = 0
        case up = 1
    }
    enum DealDetailType:UInt16 {
        //当日成交
        case todayComplete = 6007
        //当日委托
        case todayEntrust = 6001
        //历史委托
        case allEntrust = 6005
        //历史交易
        case allDeal = 6009
    }
    
    class WechatKey {
        static let Scope = "snsapi_userinfo"
        static let State = "wpstate"
        static let AccessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token"
        static let Appid = "wx9dc39aec13ee3158"
        static let Secret = "a12a88f2c4596b2726dd4ba7623bc27e"
        static let ErrorCode = "ErrorCode"
        static let wechetUserInfo = "https://api.weixin.qq.com/sns/userinfo"
    }
    class aliPay {
        static let aliPayCode = "aliPayCode"
    }

    class WechatPay {
        static let WechatKeyErrorCode = "WechatKeyErrorCode"
    }
    
    class UnionPay {
        static let UnionErrorCode = "UnionErrorCode"
    }
    
    class NotifyDefine {
        

    }
    
}
