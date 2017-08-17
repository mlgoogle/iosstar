//
//  VoiceQuestionVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VoiceQuestionCell: OEZTableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var voiceIcon: UIImageView!
    @IBOutlet weak var voiceCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        voiceBtn.setImage(UIImage.imageWith("\u{e64f}", fontSize: CGSize.init(width: 16, height: 26), fontColor: UIColor.init(rgbHex: 0x666666)), for: .normal)
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        voiceIcon.image = UIImage.imageWith("\u{e628}", fontSize: CGSize.init(width: 18, height: 18), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    
    override func update(_ data: Any!) {
        if let tempTitle = data as? String{
            contentLabel.text = tempTitle
        }
    }
}

class VoiceQuestionVC: BasePageListTableViewController {

    var starModel: StarSortListModel = StarSortListModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = starModel.name
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        initNav()
    }

    func initNav() {
        let rightItem = UIBarButtonItem.init(title: "历史定制", style: .plain, target: self, action: #selector(rightItemTapped(_:)))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func rightItemTapped(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VoiceHistoryVC.className()) as? VoiceHistoryVC{
            vc.starModel = starModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didRequest(_ pageIndex: Int) {
        didRequestComplete(nil)
        dataSource = [["花费20秒偷听,花费20秒偷听花费20秒偷听花费20秒偷听花费20秒偷听花费20秒偷听","点击播放","花费10秒偷听"] as AnyObject]
        tableView.reloadData()
    }
    
    override func isSections() -> Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VoiceQuestionCell.className()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 64
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 64))
        footer.backgroundColor = UIColor.init(rgbHex: 0xfafafa)
        let footerBtn = UIButton.init(type: .custom)
        footerBtn.frame = CGRect.init(x: 24, y: 20, width: kScreenWidth-48, height: 44)
        footerBtn.layer.cornerRadius = 3
        footerBtn.backgroundColor = UIColor.init(rgbHex: 0xfb9938)
        footerBtn.setTitle("找TA定制", for: .normal)
        footerBtn.addTarget(self, action: #selector(footerBtnTapped(_:)), for: .touchUpInside)
        footer.addSubview(footerBtn)
        return footer
    }
    
    func footerBtnTapped(_ sender: UIButton) {
        print("找他定制")
    }
}
