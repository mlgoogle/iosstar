//
//  VoiceHistoryVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VoiceHistoryCell: OEZTableViewCell {

    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var voiceIcon: UIImageView!
    @IBOutlet weak var voiceCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        voiceBtn.setImage(UIImage.imageWith("\u{e64f}", fontSize: CGSize.init(width: 16, height: 26), fontColor: UIColor.init(rgbHex: 0x666666)), for: .normal)
        voiceIcon.image = UIImage.imageWith("\u{e628}", fontSize: CGSize.init(width: 18, height: 18), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    
    override func update(_ data: Any!) {
        if let tempTitle = data as? String{
            contentLabel.text = tempTitle
        }
    }
}

class VoiceHistoryVC: BasePageListTableViewController {

    @IBOutlet weak var titlesView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    var starModel: StarSortListModel = StarSortListModel()
    private var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "历史定制"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        titleViewButtonAction(openButton)
    }
    
    @IBAction func titleViewButtonAction(_ sender: UIButton) {
        
        self.selectedButton?.isSelected = false
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor.init(rgbHex: 0xECECEC)
        self.selectedButton = sender
    }
    
    override func didRequest(_ pageIndex: Int) {
        didRequestComplete(["花费20秒偷听,花费20秒偷听花费20秒偷听花费20秒偷听花费20秒偷听花费20秒偷听","点击播放","花费10秒偷听"] as AnyObject)
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VoiceQuestionCell.className()
    }

}
