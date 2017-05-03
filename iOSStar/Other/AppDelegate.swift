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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 
    var sdkConfigDelegate: NTESSDKConfigDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
   
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
        
        sdkConfigDelegate = NTESSDKConfigDelegate.init()
        
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true

        NIMSDK.shared().register(withAppID: "0d0f4b452de9695f91b0e4dc949d54cc", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)

        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        
       
        //   NSString *appKey = [[NTESDemoConfig sharedConfig] appKey];
//        NSString *cerName= [[NTESDemoConfig sharedConfig] cerName];
    
        
//        [[NIMSDK sharedSDK] registerWithAppID:您的APPKEY
//            cerName:您的推送证书名]
        UIApplication.shared.statusBarStyle = .lightContent;

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

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

