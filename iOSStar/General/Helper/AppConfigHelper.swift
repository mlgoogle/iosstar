//
//  AppConfigHelper.swift
//  iOSStar
//
//  Created by J-bb on 17/5/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AppConfigHelper: NSObject {

    
  class func setupNIMSDK(sdkConfigDelegate:NTESSDKConfigDelegate?) {
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
        
        
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true//0d0f4b452de9695f91b0e4dc949d54cc
        //9c3a406f233dea0d355c6458fb0171b8
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)
        
        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        
    }

    

    class func share(type:UMSocialPlatformType, shareObject:UMShareWebpageObject, viewControlller:UIViewController) {
        
        let messageObject = UMSocialMessageObject()

        messageObject.shareObject = shareObject


        UMSocialManager.default().share(to: type, messageObject: messageObject, currentViewController: viewControlller) { (data, error) in
            
            
        }
        
    }
    
    class func setupUMSDK() {
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "5861e5daf5ade41326001eab"
//        UMSocialManager.default().umSocialAppSecret = ""
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "www.baidu.com")

    }
}
