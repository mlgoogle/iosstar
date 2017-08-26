//
//  PlayNetVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/21.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MediaPlayer
class PlayNetVC: UIViewController {

    var player : PLPlayer?
    var playUrl : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let option = PLPlayerOption.default()
//        player = PLPlayer.
//        self.view.addSubview((player?.playerView)!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
