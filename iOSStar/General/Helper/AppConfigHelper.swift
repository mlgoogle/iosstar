//
//  AppConfigHelper.swift
//  iOSStar
//
//  Created by J-bb on 17/5/26.
//  Copyright © 2017年 YunDian. All rights reserved.

import UIKit
import UserNotifications
import SVProgressHUD
import RealmSwift
// 个推信息
let kGtAppId:String = "j6hP8vFv4Q8juUqTmnPPy6"
let kGtAppKey:String = "5Tb2US9CEg8RsqqYlamnP1"
let kGtAppSecret:String = "4DXXxrRirbAhqYJor3THd"

class AppConfigHelper: NSObject {
    

    var dealResult:[Int32 : String] = [-1 : "订单取消", 0 : "扣费成功", -2 : "转让方持有时间不足", -3 : "求购方金币不足", 2 : "交易成功"]
    var updateModel:UpdateParam?
    
    lazy var alertView: TradingAlertView = {
        let alertView = Bundle.main.loadNibNamed("TradingAlertView", owner: nil, options: nil)?.first as! TradingAlertView
        alertView.str = "匹配成功提醒：范冰冰（808080）匹配成功，请到系统消息中查看，点击查看。"
        return alertView
    }()
    
    private static var helper = AppConfigHelper()
    class func shared() -> AppConfigHelper {
        return helper
    }
    
    
    func registerServers() {
        updateUpdateInfo()
        UIApplication.shared.applicationIconBadgeNumber = 0
        setupNIMSDK()
        setupUMSDK()
        WXApi.registerApp("wxa75d31be7fcb762f")
        setupBugout()
        setupRealmConfig()
        setupReceiveOrderResult()
        setupReceiveMatching()
        updateUpdateInfo()
        setupReceiveOrderResult()
        registerUMAnalytics()
        getstart()
        login()

    }
    
    //MARK: - Bugout
    func setupBugout() {
        let config = BugoutConfig.default()
        config?.enabledShakeFeedback = true
        config?.enabledMonitorException = true
        Bugout.init("aebdfa2eada182ab8dc7d44fd02a8c50", channel: "channel", config: config)
    }
    
    //MARK: - 初始化明星信息
    func getstart(){
        let requestModel = GetAllStarInfoModel()
        AppAPIHelper.user().requestAllStarInfo(requestModel: requestModel, complete: { (result) in
            print(NSHomeDirectory())
            if let model = result as? [StartModel]{
                for news in model{
                    let realm = try! Realm()
                    try! realm.write {
                        realm.add(news, update: true)
                    }
                }
            }
        }) { (error) in
            
        }
    }
    
    //MARK: - 校验token登录
    func login(){
        if  UserDefaults.standard.object(forKey: "phone") as? String == nil {
            return
        }
        let requestModel = TokenLoginRequestModel()
        AppAPIHelper.user().tokenLogin(requestModel: requestModel, complete: { (result) in
            if let model = result as? StarUserModel {
                StarUserModel.upateUserInfo(userObject: model)
                UserDefaults.standard.set(model.userinfo?.phone, forKey: "phone")
                self.updateDeviceToken()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccessNotice), object: nil, userInfo: nil)

                UserDefaults.standard.synchronize()
                self.LoginYunxin()
            }
        }) { (error ) in
            
            if let phoneString = UserDefaults.standard.object(forKey: "phone") as? String {
                UserDefaults.standard.set(phoneString, forKey: "lastLogin")
            }
            UserDefaults.standard.removeObject(forKey:"phone")
            UserDefaults.standard.removeObject(forKey: "token")
        }
        
    }
    
    func LoginYunxin(){
        let registerWYIMRequestModel = RegisterWYIMRequestModel()
        registerWYIMRequestModel.name_value = UserDefaults.standard.object(forKey: "phone") as? String  ?? "123"
        registerWYIMRequestModel.phone = UserDefaults.standard.object(forKey: "phone") as? String ?? "123"
        registerWYIMRequestModel.uid = Int(StarUserModel.getCurrentUser()?.id ?? 0)
        AppAPIHelper.login().registWYIM(model: registerWYIMRequestModel, complete: { (result) in
            if let datadic = result as? Dictionary<String,String> {
                let phone = UserDefaults.standard.object(forKey: "phone") as! String
                let token = (datadic["token_value"]!)
                NIMSDK.shared().loginManager.login(phone, token: token, completion: { (error) in
                    if (error == nil) {
                       NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccess), object: nil, userInfo:nil)
                    }
            })
          }
        }) { (error) in
            
        }
    }
    
    // MARK: - 网易云信
    func setupNIMSDK() {
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
//        NIMSDKConfig.shared().delegate = sdkConfigDelegate
//        NIMSDKConfig.shared().shouldSyncUnreadCount = true//0d0f4b452de9695f91b0e4dc949d54cc
        //9c3a406f233dea0d355c6458fb0171b8
//        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
//        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)
//        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        let option = NIMSDKOption.init(appKey: "9c3a406f233dea0d355c6458fb0171b8")
        NIMSDK.shared().register(with: option)
        
    }
    
    // MARK: -个推
    func setupGeTuiSDK(sdkDelegate : AppDelegate)  {
        
        // [ GTSdk ]：是否允许APP后台运行
        GeTuiSdk.runBackgroundEnable(true);
        
        // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
        // GeTuiSdk.lbsLocationEnable(true, andUserVerify: true);
        
        // [ GTSdk ]：自定义渠道
        GeTuiSdk.setChannelId("GT-Channel")
        
        // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
        GeTuiSdk.start(withAppId: kGtAppId, appKey: kGtAppKey, appSecret: kGtAppSecret, delegate: sdkDelegate)
        
        // 注册APNs - custom method - 开发者自定义的方法
        self.registerRemoteNotification(sdkDelegate: sdkDelegate)
        
    }
    
    // MARK: - 注册用户通知(推送)
    func registerRemoteNotification(sdkDelegate:AppDelegate) {
        /*
         警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
         */
        
        /*
         警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
         以下为演示代码，仅供参考，详细说明请参考苹果开发者文档，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken。
         */
        
        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
        if systemVer >= 10.0 {
            if #available(iOS 10.0, *) {
                let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
                center.delegate = sdkDelegate;
                center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        print("注册通知成功") //点击允许
                    } else {
                        print("注册通知失败") //点击不允许
                    }
                })
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if #available(iOS 8.0, *) {
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            };
        }else if systemVer >= 8.0 {
            if #available(iOS 8.0, *) {
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)
                
                UIApplication.shared.registerForRemoteNotifications()
            }
        }else {
            if #available(iOS 7.0, *) {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        }
    }
    
    // MARK: - 友盟
    func share(type:UMSocialPlatformType, shareObject:UMShareWebpageObject, viewControlller:UIViewController) {
        
        let messageObject = UMSocialMessageObject()

        messageObject.shareObject = shareObject

        UMSocialManager.default().share(to: type, messageObject: messageObject, currentViewController: viewControlller) { (data, error) in

        }
        
    }
    func registerUMAnalytics() {
        MobClick.setCrashReportEnabled(false)
        UMAnalyticsConfig.sharedInstance().appKey = "595ce5814ad1562ed6000348"
        UMAnalyticsConfig.sharedInstance().channelId = ""
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
        //version标识
        let version: String? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        MobClick.setAppVersion(version)
        //日志加密设置
        MobClick.setEncryptEnabled(true)
    }
    
    
    func setupUMSDK() {
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "5944e976c62dca4b80001e50"
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxa75d31be7fcb762f", appSecret: "edd6e7ea7293049951b563dbc803ebea", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1106199654", appSecret: nil, redirectURL: "www.baidu.com")

    }
    func updateDeviceToken() {
        let requestModel = UpdateDeviceTokenModel()
        AppAPIHelper.user().updateDeviceToken(requestModel: requestModel, complete: nil, error: nil)
    }
    
    //MARK: - Realm数据库
    func setupRealmConfig() {
        var config = Realm.Configuration()
        config.fileURL =  config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("\("starShare").realm")
        config.schemaVersion = 4
        
        //数据库迁移操作
        config.migrationBlock = { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 4 {
                
                migration.enumerateObjects(ofType: EntrustListModel.className(), { (oldObject, newObject) in
                    newObject!["pchg"] = 0.0
                })
                migration.enumerateObjects(ofType: WeChatPayResultModel.className(), { (oldObject, newObject) in
                    newObject!["rid"] = ""
                })
                migration.enumerateObjects(ofType: StarUserModel.className(), { (oldObject, newObject) in
                    newObject!["token_time"] = 0
                })
    
                
            }
        }
        Realm.Configuration.defaultConfiguration = config
        _ = try! Realm()
        
    }
    
    //MARK: - 初始化匹配
    func setupReceiveMatching() {
        //#246
        AppAPIHelper.dealAPI().setReceiveMatching { (response) in
            
            if let model = response as? ReceiveMacthingModel{
                
                StartModel.getStartName(startCode: model.symbol, complete: { (star) in
                     
                    if let starModel = star as? StartModel {
                        let body = "匹配成功提醒：\(starModel.name)（\(starModel.code)）匹配成功，请到系统消息中查看，点击查看"

                        // 处在后台
                        if UIApplication.shared.applicationState == .background {
                    
                            self.localNotify(body: body, userInfo: nil)
                        } else {
                            self.alertView.str = body
                            self.performSelector(onMainThread: #selector(self.showAlert), with: nil, waitUntilDone: false)
                        }
                    }
                })
            }
        }
    }
    func showAlert(){
        alertView.showAlertView()
        alertView.messageAction = {
            let vc = UIStoryboard.init(name: "Exchange", bundle: nil).instantiateViewController(withIdentifier: "SystemMessageVC")
            let nav = UINavigationController.init(rootViewController: vc)
            UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
        }

    }
    
    func setupReceiveOrderResult() {
        AppAPIHelper.dealAPI().setReceiveOrderResult { (response) in
            if let model = response as? OrderResultModel {
                let body = "您有一条新的订单状态更新:\(self.dealResult[model.result]!),点击查看"

                if UIApplication.shared.applicationState == .background {
                    self.localNotify(body: body, userInfo: nil)
                } else {
                    self.alertView.str = body
                    self.performSelector(onMainThread: #selector(self.showAlert), with: nil, waitUntilDone: false)
                }
            }
        }   
    }
    
    
    func AlertlocalNotify() {
        if UIApplication.shared.applicationState == .background {
            self.localNotify(body: "可以看见吗", userInfo: nil)
        }
    }
    
    
    
    func localNotify(body: String?, userInfo: [NSObject: AnyObject]?) {
        let localNotify = UILocalNotification()
        localNotify.fireDate = Date().addingTimeInterval(0.1)
        localNotify.timeZone = NSTimeZone.default
        localNotify.soundName = UILocalNotificationDefaultSoundName
        if #available(iOS 8.2, *) {
            localNotify.alertTitle = "星悦"
        } else {
            // Fallback on earlier versions
        }
        localNotify.alertBody = body!
        localNotify.userInfo = userInfo
        UIApplication.shared.scheduleLocalNotification(localNotify)
        
    }

    //MARK: - 查询是否有新版本更新
    func updateUpdateInfo() {
        AppAPIHelper.user().update(type: 0, complete: { (response) in
            if let model = response as? UpdateParam {
                self.updateModel = model
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.NoticeKey.checkUpdte.rawValue), object: nil)
            } 
            
        }) { (error) in
            
        }
    }
    
    func checkUpdate() -> Bool {
        let versionCode = Bundle.main.infoDictionary![AppConst.BundleInfo.CFBundleVersion.rawValue] as! String
        if updateModel == nil {
            return false
        }
        if  Double(versionCode) != nil {
            if updateModel!.newAppVersionCode >  Double(versionCode)! {
                return true
            }
        }
        return false
    }


    
    
}
