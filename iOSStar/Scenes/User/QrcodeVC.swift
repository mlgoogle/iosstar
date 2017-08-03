//
//  QrcodeVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/3.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class QrcodeVC: UIViewController {

    @IBOutlet var Qrcode: UIImageView!
    var urlStr : String = "123"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的二维码"
       
        Qrcode.image = UIImage.qrcodeImage(urlStr)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    @IBAction func didmiss(_ sender: Any) {
        self.dismissController()
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
