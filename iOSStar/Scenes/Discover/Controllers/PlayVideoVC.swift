//
//  PlayVideoVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class PlayVideoVC: UIViewController {
    
    @IBOutlet weak var qBgView: UIView!
    @IBOutlet weak var qIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qContentLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var hiddleBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet var progressview: UIView!
    var resultBlock: CompleteBlock?
    var timer : Timer?
    var userPlayer = true
    var playerOnce = false
    var playerTwice = false
    var totaltime = CGFloat.init(0)
    @IBOutlet weak var progressCons: NSLayoutConstraint!
    @IBOutlet var secondProgress: NSLayoutConstraint!
    var startModel  : UserAskDetailList!
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
        let player = PLPlayer.init(url: nil, option: option)
        return player!
    }()
    //显示背景的图片
    @IBOutlet var showStartImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        if let playView = player.playerView{
            view.addSubview(playView)
            view.sendSubview(toBack: playView)
        }
        self.secondProgress.constant = 0
        stopBtn.isHidden = true
        SVProgressHUD.show(withStatus: "加载中")
        showStartImg.isHidden = false
        nameLabel.text = startModel?.nickName
        qContentLabel.text = startModel?.uask
        progressCons.constant = 0
        qIconImage.kf.setImage(with: URL(string :  (startModel?.headUrl)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGrogress), userInfo: nil, repeats: true)
    }
    func updateGrogress(){
      if player.totalDuration.value  == 0{
            return
        }
        if self.playerOnce && self.playerTwice {
            let current = CGFloat(player.currentTime.value)/CGFloat(player.currentTime.timescale)
            let total = CGFloat(player.totalDuration.value)/CGFloat(player.totalDuration.timescale)
            
            progressCons.constant = progressview.frame.width * current/total
        }else{
            let current = CGFloat(player.currentTime.value)/CGFloat(player.currentTime.timescale)
            let total = CGFloat(player.totalDuration.value)/CGFloat(player.totalDuration.timescale)
            
            secondProgress.constant = progressview.frame.width * current/total
        }
        
        
    }
    @IBAction func askQustion(_ sender: Any) {
        
        if self.resultBlock != nil{
       
            self.resultBlock!(true as AnyObject)
        
        
        }
        self.dismiss(animated: false, completion: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        
        
        SVProgressHUD.dismiss()
//        player.playerView?.removeFromSuperview()
        if player.isPlaying{
        
            player.pause()
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismissController()
    }
    @IBAction func atuoPlay(_ sender: Any) {
        stopBtn.isHidden = true
        player.play()
    }
    
    @IBAction func hiddleBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hiddleQustion(sender.isSelected)
    }
    
    func hiddleQustion(_ isHiddle: Bool){
        qBgView.isHidden = isHiddle
        qIconImage.isHidden = isHiddle
        nameLabel.isHidden = isHiddle
        qContentLabel.isHidden = isHiddle
    }
    
    func play(_ urlStr: String) {
        
        if urlStr ==  (ShareDataModel.share().qiniuHeader + startModel.sanswer) {
            showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnailS)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            totaltime = CGFloat(startModel.videoTimeS)
            userPlayer = true
        }else{
            showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnail)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            userPlayer = false
        }
        player.play(with: URL.init(string: urlStr))
    }
}


extension PlayVideoVC: PLPlayerDelegate{
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        
        if state == .statusPreparing{
            showStartImg.isHidden = false
            stopBtn.isHidden = true
            
            SVProgressHUD.show(withStatus: "加载中")
            self.view.sendSubview(toBack: showStartImg)
            
        }
        if state == .statusPlaying{
            SVProgressHUD.dismiss()
            if !self.playerOnce && !self.playerTwice{
                stopBtn.isHidden = true
                self.playerOnce = true
                self.playerTwice = true
            }
        }
        if state == .statusStopped{
            if self.playerOnce && self.playerTwice {
                self.playerOnce = true
                self.playerTwice = false
                stopBtn.isHidden = true
                if userPlayer{
                    if startModel.answer_t != 0{
                        
                    }
                }else{
                    showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnail)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                }
                doplay()
//                self.perform(#selector(doplay), with: self, afterDelay: 0)
                
            }else if self.playerOnce && !self.playerTwice{
                stopBtn.isHidden = true
                self.perform(#selector(doDidmiss), with: self , afterDelay: 2)
            }
            
        }
    }
    func doDidmiss(){
      self.dismissController()
    }
    func doplay(){
        if userPlayer{
            if startModel.video_url != ""{
                stopBtn.isHidden = false
                showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnail)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                player.play(with: URL.init(string:  ShareDataModel.share().qiniuHeader  + startModel.video_url))
            }
            
        }else{
            if startModel.answer_t != 0{
                showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnailS)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                player.play(with: URL.init(string: ShareDataModel.share().qiniuHeader  + startModel.sanswer))
            }
            
            
        }
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
    }
    
    func player(_ player: PLPlayer, codecError error: Error) {
        
    }
}
