//
//  PlayVideoVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class PlayVideoVC: UIViewController {

    @IBOutlet weak var qBgView: UIView!
    @IBOutlet weak var qIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var qContentLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var hiddleBtn: UIButton!
    @IBOutlet weak var progressCons: NSLayoutConstraint!
    
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
        let player = PLPlayer.init(url: nil, option: option)
        return player!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        if let playView = player.playerView{
            view.addSubview(playView)
            view.sendSubview(toBack: playView)
        }
        qIconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        
    }

    @IBAction func askQustion(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "AskQuestionsVC") as? AskQuestionsVC{
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
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
    }
    
    func player(_ player: PLPlayer, codecError error: Error) {
        
    }
}
