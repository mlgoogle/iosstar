//
//  Share.swift
//  iOSStar
//
//  Created by sum on 2017/6/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class ShareView: UIView {

    var shareView : UIView = UIView()
    var  tabbar : UITabBarController?
    //require:分享的标题
    var title : String?
    //require:分享的内容
    var descr : String?
    //require:分享的网页链接
    var webpageUrl : String?
    //require:分享的图片
    var thumbImage : String?
    var typeArr = [UMSocialPlatformType.wechatTimeLine,UMSocialPlatformType.qzone,UMSocialPlatformType.sina,UMSocialPlatformType.wechatSession,UMSocialPlatformType.QQ];
    func shareViewController(viewController :UIViewController)  {
        shareView = UIView.init(frame: UIScreen.main.bounds)
        shareView.backgroundColor = UIColor.init(colorLiteralRed: 45.0/255, green: 45.0/255, blue: 45.0/255, alpha: 0.3)
        tabbar = viewController.tabBarController!
        tabbar?.view.addSubview(shareView)
        let tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(exit))
        shareView.addSubview(self)
        self.frame = CGRect.init(x: 0, y: self.shareView.bounds.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        UIView.animate(withDuration: 0.3) { 
            self.frame = CGRect.init(x: 0, y: self.shareView.bounds.size.height-self.frame.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
        shareView.addGestureRecognizer(tapGestureRecognizer)
    }
    @IBAction func shareToPlatForm(_ sender: Any) {
        
        let btn = sender as! UIButton
        let messageObject = UMSocialMessageObject()
        
        let shareObject = UMShareWebpageObject()
                    shareObject.title = title
                    shareObject.descr = descr
                    shareObject.thumbImage = UIImage.init(named: thumbImage!)
                    shareObject.webpageUrl = webpageUrl
          messageObject.shareObject = shareObject
          self.exit()
        UMSocialManager.default().share(to: typeArr[btn.tag  - 100], messageObject: messageObject, currentViewController: nil) {
            (data , error) in
            
            
          
        }
            
            
    }
    func exit(){
        
      shareView.removeFromSuperview()
      
    }
    
    
}
