//
//  VideoQuestionsVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VideoQuestionCell: OEZTableViewCell{
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith("\u{e655}", fontSize: CGSize.init(width: 26, height: 26), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        let contentTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(contentTapGestureTapped(_:)))
        contentLabel.addGestureRecognizer(contentTapGesture)
    }
    
    override func update(_ data: Any!) {
        if let tempTitle = data as? String{
            let attr = NSMutableAttributedString.init(string: "\(tempTitle)点击观看")
            attr.addAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: 0xfb9938)], range: NSRange.init(location: tempTitle.length(), length: 4))
            contentLabel.attributedText = attr
        }
    }
    
    func contentTapGestureTapped(_ gesture: UITapGestureRecognizer) {
        didSelectRowAction(1, data: nil)
    }
}

class VideoQuestionsVC: BasePageListTableViewController {

        var starModel: StarSortListModel = StarSortListModel()
        override func viewDidLoad() {
            super.viewDidLoad()
            title = starModel.name
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 200
            initNav()
        }
        
        func initNav() {
            let rightItem = UIBarButtonItem.init(title: "历史提问", style: .plain, target: self, action: #selector(rightItemTapped(_:)))
            navigationItem.rightBarButtonItem = rightItem
        }
        
        func rightItemTapped(_ sender: Any) {
            if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VideoHistoryVC.className()) as? VideoHistoryVC{
                vc.starModel = starModel
                _ = self.navigationController?.pushViewController(vc, animated: true)
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
            return VideoQuestionCell.className()
        }
        
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 64
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let urlStr = "rtmp://live.hkstv.hk.lxdns.com/live/hks"
            let url = URL.init(string: urlStr)
            PLPlayerHelper.shared().player.play(with: url)
            PLPlayerHelper.shared().player.play()
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
            if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "AskQuestionsVC") as? AskQuestionsVC{
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
}
