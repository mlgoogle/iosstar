//
//  VideoManagerVC.swift
//  iOSStar
//
//  Created by mu on 2017/9/8.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VideoManagerVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var askBtn: UIButton!
    var videoVC: VideoQuestionsVC?
    var starModel: StarSortListModel = StarSortListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initNav()
    }
    
    func initNav() {
        let rightItem = UIBarButtonItem.init(title: "历史提问", style: .plain, target: self, action: #selector(rightItemTapped(_:)))
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(hexString: AppConst.Color.main)
    }
    func rightItemTapped(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VideoHistoryVC.className()) as? VideoHistoryVC{
            vc.starModel = starModel
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
    }   
    
    func initUI() {
        title = "视频定制"
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoQuestionsVC") as? VideoQuestionsVC{
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
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
            vc.starModel = starModel
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
}
