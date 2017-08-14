//
//  ShareVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class ShareVC: UIViewController {
    
    @IBOutlet var starWork: UILabel!
    @IBOutlet var starName: UILabel!
    @IBOutlet var starImg: UIImageView!
    var share : Share!
    
    var PromotionUrl : String = ""
    var typeArrM = [UMSocialPlatformType.wechatSession,UMSocialPlatformType.wechatTimeLine,UMSocialPlatformType.sina,UMSocialPlatformType.QQ,UMSocialPlatformType.qzone]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sharedata = share{
            starName.text = sharedata.name
            starImg.image = sharedata.Image
            getPromotionUrl()
            starWork.text = sharedata.work
        }
        
        
        // Do any additional setup after loading the view.
    }
    func getPromotionUrl(){
        AppAPIHelper.user().configRequest(param_code: "PROMOTION_URL", complete: { (response) in
            if let model = response as? ConfigReusltValue {
                self.PromotionUrl = String.init(format: "%@?uid=%d&star_code=%@", model.param_value,(StarUserModel.getCurrentUser()?.id ?? 0)!,self.share.star_code)
            }
            
        }) { (error) in
            
        }
    }
    @IBAction func didMIss(_ sender: Any) {
        self.dismissController()
    }
    @IBAction func shareClick(_ sender: Any) {
        let btn = sender as! UIButton
        switch btn.tag {
        case 100:
            sharetoquecode()
            break
            
        default :
            let messageObject = UMSocialMessageObject()
            
            let shareObject = UMShareWebpageObject()
            if let shareData = share{
                shareObject.descr = shareData.descr
                shareObject.thumbImage = shareData.Image
                shareObject.webpageUrl = shareData.webpageUrl
                messageObject.shareObject = shareObject
                shareObject.title = shareData.titlestr
            }
            
            
            UMSocialManager.default().share(to: self.typeArrM[btn.tag  - 100 - 1], messageObject: messageObject, currentViewController: nil) {
                (data , error) in
            }
            self.dismissController()
            break
            
        }
    }
    
    func sharetoquecode(){
        
        if let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "QrcodeVC") as? QrcodeVC{
            vc.modalPresentationStyle = .custom
            vc.urlStr = self.PromotionUrl
            vc.img = share.Image
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
