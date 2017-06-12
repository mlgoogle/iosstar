//
//  BaseTabBarController.swift
//  iosblackcard
//
//  Created by J-bb on 17/4/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController ,UITabBarControllerDelegate,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate{

    var showRed : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initcustomer()
        
    }
    
    func onSystemNotificationCountChanged(_ unreadCount: Int) {
        print(unreadCount)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func initcustomer(){
        delegate = self
     
        
        let storyboardNames = ["News","Market","Exchange","User"]
        let titles = ["首页","行情","分答","个人中心"]
        for (index, name) in storyboardNames.enumerated() {
            let storyboard = UIStoryboard.init(name: name, bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.tabBarItem.title = titles[index]
            controller?.tabBarItem.image = UIImage.init(named: "\(storyboardNames[index])_unselect")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.selectedImage = UIImage.init(named: "\(storyboardNames[index])_selected")?.withRenderingMode(.alwaysOriginal)
            controller?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(hexString: AppConst.Color.titleColor)], for: .selected)
            addChildViewController(controller!)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginSuccess(_:)), name: Notification.Name(rawValue:AppConst.loginSuccess), object: nil)
        

    }
    func didRemove(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
         self.tabBar.hideBadgeOnItemIndex(index: 2)
    }
    func allMessagesDeleted() {
          self.tabBar.hideBadgeOnItemIndex(index: 2)
    }
    func didAdd(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
       self.tabBar.showshowBadgeOnItemIndex(index: 2)
        
    }
    func didUpdate(_ recentSession: NIMRecentSession, totalUnreadCount: Int) {
        
         self.tabBar.showshowBadgeOnItemIndex(index: 2)
        print("=====什么时候调用这个方法呢? \(totalUnreadCount)")
    }
    func LoginSuccess(_ LoginSuccess : NSNotification){
        
        NIMSDK.shared().systemNotificationManager.add(self)
        NIMSDK.shared().conversationManager.add(self)
        
        if NIMSDK.shared().conversationManager.allUnreadCount() != 0 {
            self.tabBar.showshowBadgeOnItemIndex(index: 2)
        } else {
          self.tabBar.hideBadgeOnItemIndex(index: 2)
        }
        print("这里打印的是未读消息条数?-------------\(NIMSDK.shared().conversationManager.allUnreadCount())")
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex == 2  || tabBarController.selectedIndex == 3{

            if  checkLogin(){
            
            }
        }
    }
}
