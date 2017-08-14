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
    
    var titlestr : String = ""
    var Image : UIImage!
    var name : String = ""
    var descr : String = ""
    var webpageUrl : String = ""
    var PromotionUrl : String = ""
     var typeArrM = [UMSocialPlatformType.wechatSession,UMSocialPlatformType.wechatTimeLine,UMSocialPlatformType.sina,UMSocialPlatformType.QQ,UMSocialPlatformType.qzone]
    override func viewDidLoad() {
        super.viewDidLoad()
        starName.text = name
        starImg.image = Image
        getPromotionUrl()
        
        // Do any additional setup after loading the view.
    }
    func getPromotionUrl(){
        AppAPIHelper.user().configRequest(param_code: "PROMOTION_URL", complete: { (response) in
            if let model = response as? ConfigReusltValue {
                self.PromotionUrl = String.init(format: "%@?uid=%d", model.param_value,(StarUserModel.getCurrentUser()?.id ?? 0)!)
                
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
            shareObject.title = titlestr
            shareObject.descr = self.descr
            shareObject.thumbImage = self.Image
            //                    shareObject.thumbImage = UIImage.init(named: thumbImage!)
            shareObject.webpageUrl = webpageUrl
            messageObject.shareObject = shareObject
            
            UMSocialManager.default().share(to: self.typeArrM[btn.tag  - 100 - 1], messageObject: messageObject, currentViewController: nil) {
                (data , error) in
            }
             self.dismissController()
            break
            
        }
    }

    func sharetoquecode(){
        
      
        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "QrcodeVC") as? QrcodeVC
        vc?.modalPresentationStyle = .custom
        vc?.urlStr = self.PromotionUrl
        vc?.img = self.Image
        vc?.modalTransitionStyle = .crossDissolve
        present(vc!, animated: true, completion: nil)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
