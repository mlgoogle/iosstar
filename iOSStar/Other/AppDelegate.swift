//
//  AppDelegate.swift
//  iosblackcard
//
//  Created by J-bb on 17/4/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

import Alamofire
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,WXApiDelegate{

    var window: UIWindow?
 
    var sdkConfigDelegate: NTESSDKConfigDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
   
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
        
        sdkConfigDelegate = NTESSDKConfigDelegate.init()
        
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true//0d0f4b452de9695f91b0e4dc949d54cc
                                             //9c3a406f233dea0d355c6458fb0171b8
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)

        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        
        WXApi.registerApp("wx9dc39aec13ee3158")
        //   NSString *appKey = [[NTESDemoConfig sharedConfig] appKey];
//        NSString *cerName= [[NTESDemoConfig sharedConfig] cerName];
    
        
//        [[NIMSDK sharedSDK] registerWithAppID:您的APPKEY
//            cerName:您的推送证书名]
        UIApplication.shared.statusBarStyle = .lightContent

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        WXApi.handleOpen(url, delegate: self)
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
       
            WXApi.handleOpen(url, delegate: self)
        
        return true
    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
  
        
        // 支付返回
        func onResp(_ resp: BaseResp!) {
            //微信登录返回
            if resp.isKind(of: SendAuthResp.classForCoder()) {
                let authResp:SendAuthResp = resp as! SendAuthResp
                if authResp.errCode == 0{
                    accessToken(code: authResp.code)
                }
                return
            }
            
        }
        
        func accessToken(code: String)
        {
            let param = [SocketConst.Key.appid : AppConst.WechatKey.Appid,
                         "code" : code,
                         SocketConst.Key.secret : AppConst.WechatKey.Secret,
                         SocketConst.Key.grant_type : "authorization_code"]
            
            Alamofire.request(AppConst.WechatKey.AccessTokenUrl, method: .get, parameters: param).responseJSON { [weak self](result) in
                if let resultJson = result.result.value as? [String: AnyObject] {
                    if let errCode = resultJson["errcode"] as? Int{
                        print(errCode)
                    }
                    if let access_token = resultJson[SocketConst.Key.accessToken] as? String {
                        if let openid = resultJson[SocketConst.Key.openid] as? String{
                            
                          self?.wechatUserInfo(token: access_token, openid: openid)
                         

                        }
                    }
                }
            }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        window?.endEditing(true)
        
    }
    func wechatUserInfo(token: String, openid: String)
    {
        let param = [SocketConst.Key.accessToken : token,
                     SocketConst.Key.openid : openid]
        Alamofire.request(AppConst.WechatKey.wechetUserInfo, method: .get, parameters: param).responseJSON {(result) in
            guard let resultJson = result.result.value as? [String: AnyObject] else{return}
            if let errCode = resultJson["errcode"] as? Int{
                print(errCode)
            }
            if let nickname = resultJson[SocketConst.Key.nickname] as? String {
              ShareDataModel.share().wechatUserInfo[SocketConst.Key.nickname] = nickname
            }
            if let openid = resultJson[SocketConst.Key.openid] as? String{
                ShareDataModel.share().wechatUserInfo[SocketConst.Key.openid] = openid
            }
            if let headimgurl = resultJson[SocketConst.Key.headimgurl] as? String{
                ShareDataModel.share().wechatUserInfo[SocketConst.Key.headimgurl] = headimgurl
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.WechatKey.ErrorCode), object: nil, userInfo:nil)
         }
         }
}

    
