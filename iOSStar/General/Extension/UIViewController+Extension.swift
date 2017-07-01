//
//  UIViewController+Extension.swift
//  viossvc
//
//  Created by yaowang on 2016/10/31.
//  Copyright © 2016年 ywwlcom.yundian. All rights reserved.
//

import Foundation
import RealmSwift
//import XCGLogger
import SVProgressHUD
extension UIViewController {
    
    class func storyboardInit(identifier:String, storyboardName:String) -> UIViewController? {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
    func errorBlockFunc()->ErrorBlock {
        return { [weak self] (error) in
            //            XCGLogger.error("\(error) \(self)")

            self?.didRequestError(error)
        }
    }
    func LoginSuccess(){
        
        self.doYunxin { (result) in
            
        }
    }
    
    
    func didRequestError(_ error:NSError) {
        if error.code == -11011 {
            return
        }
        SVProgressHUD.showErrorMessage(ErrorMessage: error.localizedDescription, ForDuration: 1.5, completion: nil)
    }
    
    func showErrorWithStatus(_ status: String!) {
        SVProgressHUD.showErrorMessage(ErrorMessage: status, ForDuration: 1.5, completion: nil)
    }
    
    func showWithStatus(_ status: String!) {
        SVProgressHUD.show(withStatus: status)
    }
    
    func showUpdateInfo() {
        let homeStoryboard = UIStoryboard.init(name: "User", bundle: nil)
        let controller = homeStoryboard.instantiateViewController(withIdentifier: UpdateVC.className()) as! UpdateVC
        controller.modalPresentationStyle = .custom
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true, completion: {
        })
        
    }
    //检查是否已登录
    func checkLogin() -> Bool {
        
        if UserDefaults.standard.object(forKey: "phone") as? String == nil {
            let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()
            controller?.modalPresentationStyle = .custom
            controller?.modalTransitionStyle = .crossDissolve
            present(controller!, animated: true, completion: nil)
            
            return false
        }else{
            return true
        }
    }
      //登录网易云信
    func doYunxin(complete: CompleteBlock?){
        
//        if UserDefaults.standard.object(forKey: "phone") as? String != nil {
//            
//            let phoneNum = (UserDefaults.standard.object(forKey: "phone") as? String)!
//            
//            AppAPIHelper.login().registWYIM(phone : phoneNum, token : phoneNum, complete : { (result) in
//                let datatic = result as? Dictionary<String,String>
//                if let response = datatic {
//                    NIMSDK.shared().loginManager.login( phoneNum, token: (response["token_value"])!, completion: { (error) in
//                        if (error != nil){
//                        }
//                        complete?(true as AnyObject)
//                        
//                    })
//                    UserDefaults.standard.set((response["token_value"])!, forKey: "tokenvalue")
//                    UserDefaults.standard.synchronize()
//                }
//            }) { (error) in
//               
//            }
//        }
        if UserDefaults.standard.object(forKey: "phone") as? String != nil {
            let phoneNum = (UserDefaults.standard.object(forKey: "phone") as? String)!
            let registerWYIMRequestModel = RegisterWYIMRequestModel()
            registerWYIMRequestModel.name_value = phoneNum
            registerWYIMRequestModel.phone = phoneNum
//            registerWYIMRequestModel.accid_value = phoneNum
            registerWYIMRequestModel.uid =  Int(StarUserModel.getCurrentUser()?.id ?? 0)
            AppAPIHelper.login().registWYIM(model: registerWYIMRequestModel, complete: { (result) in
                let datatic = result as? Dictionary<String,String>
                if let response = datatic {
                    NIMSDK.shared().loginManager.login(phoneNum, token: (response["token_value"])!, completion: { (error) in
                        if (error != nil){
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.loginSuccess), object: nil, userInfo:nil)
                        }
                        complete?(true as AnyObject)
                    })
                    UserDefaults.standard.set((response["token_value"])!, forKey: "tokenvalue")
                    UserDefaults.standard.synchronize()
                }
            }, error: { (error) in
                
            })
        }
    }
    //退出登录
    func userLogout() {
        if let tabbar = UIApplication.shared.windows[0].rootViewController as? BaseTabBarController{
            //为了让退回跟视图
            if let nav : UINavigationController = tabbar.selectedViewController as? UINavigationController{
                if nav.viewControllers.count > 0{
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }
            }
            DispatchQueue.main.async {
                tabbar.selectedIndex = 0
            }
        }
        if let phoneString = UserDefaults.standard.object(forKey: "phone") as? String {
            UserDefaults.standard.set(phoneString, forKey: "lastLogin")
        }
        UserDefaults.standard.removeObject(forKey:"phone")
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    //检查text是否为空
    func checkTextFieldEmpty(_ array:[UITextField]) -> Bool {
        for  textField in array {
            if  textField.text == ""  {
                SVProgressHUD.showErrorMessage(ErrorMessage: textField.placeholder!, ForDuration: 2.0, completion: {
                });
                return false
            }
        }
        return true
    }
    //关闭模态视图控制器
    func dismissController() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    //打电话
    func didActionTel(_ telPhone:String) {
        let alert = UIAlertController.init(title: "呼叫", message: telPhone, preferredStyle: .alert)
        let ensure = UIAlertAction.init(title: "确定", style: .default, handler: { (action: UIAlertAction) in
            UIApplication.shared.openURL(URL(string: "tel://\(telPhone)")!)
        })
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: { (action: UIAlertAction) in
            
        })
        alert.addAction(ensure)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    //导航栏透明
    func translucent(clear: Bool) {
        
        //     let navImageName = clear ? "nav_clear" : "nav_color"
        //        let navImageName = "nav_bg"
        //        navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: navImageName), for: .any, barMetrics: .default)
        
        navigationController?.navigationBar.isTranslucent = clear;
        
    }
    
    //MARK: -- 隐藏tabBar导航栏
    func hideTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        if window != nil {
            var tabFrame = tabBar?.frame
            tabFrame?.origin.y = (window?.bounds)!.maxY
            tabBar?.frame = tabFrame!
            content?.frame = (window?.bounds)!
        }
        
    }
    func setCustomTitle(title:String) {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(hexString: AppConst.Color.main)
        navigationItem.titleView = label
        
    }
    func showTabBarWithAnimationDuration() {
        let tabBar = self.tabBarController?.tabBar
        let parent = tabBar?.superview
        let content = parent?.subviews[0]
        let window = parent?.superview
        if window != nil {
            var tabFrame = tabBar?.frame
            tabFrame?.origin.y = (window?.bounds)!.maxY - ((tabBar?.frame)?.height)!
            tabBar?.frame = tabFrame!
            
            var contentFrame = content?.frame
            contentFrame?.size.height -= (tabFrame?.size.height)!
        }
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
    }
    //判断是否实名认证
    func checkVaildName(complete: CompleteBlock?){
        

    }
    func getUserRealmInfo(complete: CompleteBlock?){
        let requestModel = GetAuthenticationRequestModel()
        
        AppAPIHelper.user().requestAuthentication(requestModel: requestModel, complete: { (result) in
            complete?(result as AnyObject)
        }) { (error) in
//            SVProgressHUD.showErrorMessage(ErrorMessage: error.userInfo["NSLocalizedDescription"] as! String, ForDuration: 2.0, completion: nil)
        }
    }
    
    
    func getUserInfo(complete: CompleteBlock?){
        
         if UserDefaults.standard.object(forKey: "phone") as? String != nil{

            let requestModel = UserInfoRequestModel()
            AppAPIHelper.user().requestUserInfo(requestModel: requestModel, complete: { (result) in
                complete?(result as AnyObject)
            }, error: { (error) in
               self.userLogout()
            })

        }
    }
    //获取明星姓名
    func getStartName(startCode:String,complete: CompleteBlock?){
        
        let realm = try! Realm()
        let filterStr = "code = \(startCode)"
        let user = realm.objects(StartModel.self).filter(filterStr).first
        if user != nil{
             complete?(user as AnyObject)
        }else{
            complete?(nil)
        }
    }

    func showOnlyLogin(){
        userLogout()
        let onlyLoginAlter = UIAlertController.init(title: "被迫下线", message: "您的账号在另一地点登录，您已被迫下线", preferredStyle: .alert)
        let sureAction = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        onlyLoginAlter.addAction(sureAction)
        DispatchQueue.main.async {
            self.present(onlyLoginAlter, animated: true, completion: nil)
        }
    }
    
    func gethelp(){
        if let helpVC = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: CustomerServiceVC.className()) as? CustomerServiceVC{
            if let nav = tabBarController?.selectedViewController as? UINavigationController{
                nav.pushViewController(helpVC, animated: true)
            }
        }
        print("No CustomerServiceVC")
    }
}

