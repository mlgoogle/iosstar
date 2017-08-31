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
    var timer : Timer?
    var totaltime = CGFloat.init(0)
    @IBOutlet weak var progressCons: NSLayoutConstraint!
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
        SVProgressHUD.show(withStatus: "加载中")
        showStartImg.isHidden = true
        nameLabel.text = startModel?.nickName
        qContentLabel.text = startModel?.uask
        progressCons.constant = 0
        qIconImage.kf.setImage(with: URL(string : (startModel?.headUrl)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        showStartImg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (startModel?.thumbnail)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        
    }
    func updateGrogress(){
        let total = CGFloat.init(10)
            let progress = (kScreenWidth - 40) / total
            if (totaltime < total){
                totaltime = totaltime + 0.1
                if (totaltime * progress > (kScreenWidth - 40)){
                   progressCons.constant = kScreenWidth - 40
                }else{
                    progressCons.constant = totaltime * progress
                    
                }
                
            }else{
                timer?.invalidate()
               
            }
        }
    @IBAction func askQustion(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        dismissController()
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
        player.play(with: URL.init(string: urlStr))
    }
}


extension PlayVideoVC: PLPlayerDelegate{
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        print(state.rawValue)
        if state == .statusPreparing{
            showStartImg.isHidden = true
         
//        self.view.bringSubview(toFront: player.playerView!)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGrogress), userInfo: nil, repeats: true)
        }
        if state == .statusPlaying{
        SVProgressHUD.dismiss()
        }
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
    }
    
    func player(_ player: PLPlayer, codecError error: Error) {
        
    }
}
