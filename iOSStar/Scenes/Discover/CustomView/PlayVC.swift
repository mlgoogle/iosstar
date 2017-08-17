//
//  PlayVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import PLShortVideoKit
class PlayVC: UIViewController {

    var asset : AVAsset?
    var shortVideoRecorder : PLShortVideoEditor?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shortVideoRecorder = PLShortVideoEditor.init(asset: asset)
//        self.shortVideoEditor.player.delegate = self
        self.shortVideoRecorder?.player.preview?.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.view.addSubview((self.shortVideoRecorder?.player.preview!)!)
        self.shortVideoRecorder?.player.play()
        // Do any additional setup after loading the view.
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
