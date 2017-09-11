
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
            contentView.addSubview(vc.view)
            addChildViewController(vc)
            vc.view.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
    }
    
    
    @IBAction func askBtnTapped(_ sender: UIButton) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VoiceAskVC") as? VoiceAskVC{
            vc.starModel = starModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
