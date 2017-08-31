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
        if let response  = data as? UserAskDetailList{
//            contentLabel.text = response.uask
            let attr = NSMutableAttributedString.init(string: "\(response.c_type)点击观看")
            attr.addAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: 0xfb9938)], range: NSRange.init(location: "\(response.c_type)".length(), length: 4))
            contentLabel.attributedText = attr
            
            timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(response.ask_t), format: "YYYY-MM-dd")
            countLabel.text = "\(response.s_total)人听过"
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
        func rightItemTapped(_ sender: Any) {
            if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VideoHistoryVC.className()) as? VideoHistoryVC{
                vc.starModel = starModel
                _ = self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        override func didRequest(_ pageIndex: Int) {
            let model = StarAskRequestModel()
            model.pos = (pageIndex - 1) * 10
            model.starcode = starModel.symbol
            AppAPIHelper.discoverAPI().staraskQuestion(requestModel: model, complete: { [weak self](result) in
                if let response = result as? UserAskList {
                    self?.didRequestComplete([response.circle_list] as AnyObject )
                    
                    self?.tableView.reloadData()
                }
                
            }) { (error) in
                
            }
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
            return 84
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: PlayVideoVC.className()) as? PlayVideoVC{
                present(vc, animated: true, completion: { 
                    vc.play("rtmp://live.hkstv.hk.lxdns.com/live/hks")
                })
            }
        }
    
        override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 84))
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
            if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
                vc.starModel = starModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
}
