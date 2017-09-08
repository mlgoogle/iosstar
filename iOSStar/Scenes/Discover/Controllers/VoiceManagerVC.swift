
//
//  VoiceManagerVC.swift
//  iOSStar
//
//  Created by mu on 2017/9/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VoiceManagerVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var askBtn: UIButton!
    var videoVC: VoiceQuestionVC?
    var starModel: StarSortListModel = StarSortListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initNav()
    }
    
    func initNav() {
        let rightItem = UIBarButtonItem.init(title: "历史定制", style: .plain, target: self, action: #selector(rightItemTapped(_:)))
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(hexString: AppConst.Color.titleColor)
    }
    func rightItemTapped(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VoiceHistoryVC.className()) as? VoiceHistoryVC{
            vc.starModel = starModel
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func initUI() {
        title = "语音定制"
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VoiceQuestionVC") as? VoiceQuestionVC{
            videoVC =  vc
            vc.starModel = starModel
            vc.view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-64)
            contentView.addSubview(vc.view)
            addChildViewController(vc)
        }
    }
    
    
    @IBAction func askBtnTapped(_ sender: UIButton) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
            vc.starModel = starModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
