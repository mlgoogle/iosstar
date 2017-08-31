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
    var settings : [String : AnyObject]?
    var shortVideoRecorder : PLShortVideoEditor?
    var groupLb : UILabel?
    var totaltime : CGFloat = 0
    var timer : Timer?
    var start : UIButton?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shortVideoRecorder = PLShortVideoEditor.init(asset: asset)
        self.shortVideoRecorder?.player.preview?.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.view.addSubview((self.shortVideoRecorder?.player.preview!)!)
        self.shortVideoRecorder?.player.play()
        gettotal()
        initUI()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGrogress), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI(){
        let share = UIButton.init(type: .custom)
        share.frame = CGRect.init(x: kScreenWidth - 100, y: 80, width: 70, height: 30)
        share.setTitle("关闭", for: .normal)
        share.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        share.setTitleColor(UIColor.init(hexString: AppConst.Color.main), for: .normal)
//        share.addTarget(self, action: #selector(publish), for: .touchUpInside)
        self.view.addSubview(share)
        
        start = UIButton.init(type: .custom)
        start?.frame = CGRect.init(x:view.center.x - 35, y: view.center.y, width: 70, height: 70)
        start?.setTitle("播放", for: .normal)
        start?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        start?.backgroundColor = UIColor.white
        start?.setTitleColor(UIColor.init(hexString: AppConst.Color.main), for: .normal)
        //        share.addTarget(self, action: #selector(publish), for: .touchUpInside)
        self.view.addSubview(start!)
        start?.addTarget(self , action: #selector(dobegain), for: .touchUpInside)
        start?.isHidden = true
    
    }
    
    func dobegain(){
        self.shortVideoRecorder?.player.setItemBy(asset)
        self.shortVideoRecorder?.player.play()
        groupLb?.frame = CGRect.init(x: 20, y: 30, width: 0 , height: 5)
        totaltime = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGrogress), userInfo: nil, repeats: true)
        
         start?.isHidden  = true
    }
    
    func updateGrogress(){
        if let total = self.settings?["PLSDurationKey"] as? CGFloat{
         let progress = (kScreenWidth - 40) / total
            if (totaltime < total){
                totaltime = totaltime + 0.1
                if (totaltime * progress > (kScreenWidth - 40)){
                 groupLb?.frame = CGRect.init(x: 20, y: 30, width: kScreenWidth - 40 , height: 5)
                }else{
                 groupLb?.frame = CGRect.init(x: 20, y: 30, width: totaltime * progress , height: 5)
                
                }
               
            }else{
            timer?.invalidate()
//            self.shortVideoRecorder?.player.pause()
            start?.isHidden = false
            }
        }
   }
    
    func gettotal(){
      let bgLabel = UILabel.init(frame: CGRect.init(x: 20, y: 30, width: self.view.frame.size.width - 40, height: 5))
      bgLabel.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.5)
      self.view.addSubview(bgLabel)
      groupLb = UILabel.init(frame: CGRect.init(x: 20, y: 30, width: 00, height: 5))
      groupLb?.backgroundColor = UIColor.init(hexString: "FB9938")
      self.view.addSubview(groupLb!)
    }
}

