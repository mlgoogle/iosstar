//
//  StarNewsVC.swift
//  YStar
//
//  Created by mu on 2017/7/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import YYText
class NewsCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var newsPic: UIImageView!
    @IBOutlet weak var newsLabel: YYLabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var thumbUpBtn: UIButton!
    @IBOutlet weak var CommentBtn: UIButton!
    @IBOutlet weak var showView: UIView!
    
    override func awakeFromNib() {
        showBtn.setImage(UIImage.imageWith(AppConst.iconFontName.showIcon.rawValue, fontSize: CGSize.init(width: 22, height: 17), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.linkColor.rawValue)), for: .normal)
        thumbUpBtn.setImage(UIImage.imageWith(AppConst.iconFontName.thumbIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
        CommentBtn.setImage(UIImage.imageWith(AppConst.iconFontName.commentIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
    }
    override func update(_ data: Any!) {
        let userIcon = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        iconImage.kf.setImage(with: nil, placeholder: userIcon)
        
        let newsPlace = UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: newsPic.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
        newsPic.kf.setImage(with: nil, placeholder: newsPlace)
    }
    
    @IBAction func showBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        UIView.animate(withDuration: 0.25, animations: { [weak self] (animation) in
            self?.showView.isHidden = sender.isSelected
        })
    }
    
    @IBAction func thumbUpOrCommentBtnTapped(_ sender: UIButton) {
        didSelectRowAction(UInt(sender.tag))
        showBtnTapped(showBtn)
    }
}

class ThumbupCell: OEZTableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var thumbupNames: UILabel!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith(AppConst.iconFontName.thumpUpIcon.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    override func update(_ data: Any!) {
        
    }
}

class CommentCell: OEZTableViewCell {
    @IBOutlet var commentLabel: YYLabel!
    
    override func awakeFromNib() {
        let replyGesture = UITapGestureRecognizer.init(target: self, action: #selector(replyGestureTapped(_:)))
        commentLabel.addGestureRecognizer(replyGesture)
        commentLabel.isUserInteractionEnabled = true
    }
    override func update(_ data: Any!) {
        
    }
    func replyGestureTapped(_ gesture: UITapGestureRecognizer){
        didSelectRowAction(102, data: "")
    }
}

class StarNewsVC: BasePageListTableViewController, OEZTableViewDelegate {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "发现明星"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    enum cellAction: Int {
        case thumbUp = 100
        case comment = 101
        case reply = 102
    }
    
    override func didRequest(_ pageIndex: Int) {
        didRequestComplete([["","",""],["","","",""]] as AnyObject)
    
    }
    
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        switch indexPath.row {
        case 0:
            return NewsCell.className()
        case 1:
            return ThumbupCell.className()
        default:
            return CommentCell.className()
        }
    }
    override func isSections() -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!) {
    
        switch action {
        case cellAction.thumbUp.rawValue:
            print("点赞")
            break
        case cellAction.comment.rawValue:
            let keyboardVC = KeyboardInputViewController()
            keyboardVC.modalPresentationStyle = .custom
            keyboardVC.modalTransitionStyle = .crossDissolve
            present(keyboardVC, animated: true, completion: nil)
        case cellAction.reply.rawValue:
            let keyboardVC = KeyboardInputViewController()
            keyboardVC.modalPresentationStyle = .custom
            keyboardVC.modalTransitionStyle = .crossDissolve
            present(keyboardVC, animated: true, completion: nil)
        default:
            print("")
        }
        
    }
}
