//
//  QrcodeVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol QrcodeVCdelegate {
    
    func close()
    
    
}
class QrcodeVC: UIViewController {
    
    @IBOutlet var test_img: UIImageView!
    @IBOutlet var qrcode_view: UIView!
    @IBOutlet var Qrcode: UIImageView!
    @IBOutlet var header: UIImageView!
    var urlStr : String = "123"
    var delegate:QrcodeVCdelegate?
    var img : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的二维码"
        Qrcode.image = UIImage.createQRForString(qrString: urlStr , qrImageName: img)

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func didmiss(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConst.didmiss), object: nil , userInfo: nil)
        //       self.dismissController()
        self.dismissController()
        //       self.presentedViewController?.dismissController()
    }
    
    @IBAction func saveImageToPhoneLib(_ sender: UIButton) {
        let actionController = UIAlertController.init(title: "保存图片", message: "保存图片到相册", preferredStyle: .alert)
        let cancelAlter = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        actionController.addAction(cancelAlter)
        let sureAction = UIAlertAction.init(title: "确认", style: .default, handler: { [weak self](result) in
            SVProgressHUD.showProgressMessage(ProgressMessage: "保存中")
            UIImageWriteToSavedPhotosAlbum((self?.Qrcode.image)!, self, #selector(self?.savedOK(image:didFinishSavingWithError:contextInfo:)), nil)
        })
        actionController.addAction(sureAction)
        present(actionController, animated: true, completion: nil)
    }
    
    func captureView(_ theView : UIView)->UIImage{
        let rect = theView.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        theView.layer.render(in: context!)
        let img =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
//        test_img.image = img
    }
    func savedOK(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        SVProgressHUD.dismiss()
        if error != nil {
            SVProgressHUD.showErrorMessage(ErrorMessage: error!.localizedDescription, ForDuration: 1.5, completion: nil)
            return
        }
        SVProgressHUD.showSuccessMessage(SuccessMessage: "保存成功", ForDuration: 1.5, completion: nil)
        
    }
}
