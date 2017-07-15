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
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        showBtn.setImage(UIImage.imageWith(AppConst.iconFontName.showIcon.rawValue, fontSize: CGSize.init(width: 22, height: 17), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.linkColor.rawValue)), for: .normal)
        showBtnTapped(showBtn)
        thumbUpBtn.setImage(UIImage.imageWith(AppConst.iconFontName.thumbIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
        CommentBtn.setImage(UIImage.imageWith(AppConst.iconFontName.commentIcon.rawValue, fontSize: CGSize.init(width: 16, height: 16), fontColor: UIColor.init(rgbHex: AppConst.ColorKey.closeColor.rawValue)), for: .normal)
    }
    override func update(_ data: Any!) {
        if let model = data as? CircleListModel{
            let userIcon = UIImage.imageWith(AppConst.iconFontName.userPlaceHolder.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            iconImage.kf.setImage(with: URL.init(string: model.head_url), placeholder: userIcon)
            nameLabel.text =  model.symbol_name
            newsLabel.text = model.content
            
            let newsPlace = UIImage.imageWith(AppConst.iconFontName.newsPlaceHolder.rawValue, fontSize: newsPic.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
            newsPic.kf.setImage(with: URL.init(string: model.pic_url), placeholder: newsPlace)
            
            contentHeight.constant = newsLabel.height
        }
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
    @IBOutlet weak var thumbUpHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        iconImage.image = UIImage.imageWith(AppConst.iconFontName.thumpUpIcon.rawValue, fontSize: iconImage.frame.size, fontColor: UIColor.init(rgbHex: AppConst.ColorKey.main.rawValue))
    }
    override func update(_ data: Any!) {
        if let model = data as? CircleListModel{
            var approveName = ""
            for approve in model.approve_list{
                approveName = "\(approveName),\(approve.user_name)"
            }
            thumbupNames.text = approveName
            
            thumbUpHeight.constant = thumbupNames.height 
        }
    }
}

class CommentCell: OEZTableViewCell {
    @IBOutlet var commentLabel: YYLabel!
    @IBOutlet weak var commentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        let replyGesture = UITapGestureRecognizer.init(target: self, action: #selector(replyGestureTapped(_:)))
        commentLabel.addGestureRecognizer(replyGesture)
        commentLabel.isUserInteractionEnabled = true
    }
    override func update(_ data: Any!) {
        if let model = data as? CircleCommentModel{
            commentLabel.text = "\(model.user_name):\(model.content)"
        }
        commentHeight.constant = commentLabel.height
    }
    func replyGestureTapped(_ gesture: UITapGestureRecognizer){
        didSelectRowAction(102, data: "")
    }
}

class StarNewsVC: BasePageListTableViewController, OEZTableViewDelegate {
    
    var tableData: [CircleListModel] = []
    
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
        let param = CircleListRequestModel()
//        param.pos = Int64(pageIndex)*Int64(10)
        AppAPIHelper.circleAPI().requestCircleList(requestModel: param, complete: { [weak self](result) in
            if let data = result as? [CircleListModel]{
                self?.tableData = data
                self?.tableView.reloadData()
            }
            self?.endRefreshing()
        }, error: errorBlockFunc())
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = tableData[section] as? CircleListModel{
            return model.comment_list.count+(model.approve_list.count > 0 ? 2:1)
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = tableData[indexPath.section]
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.className()) as? NewsCell
            cell?.update(model)
            return cell!
        }
        
        if indexPath.row == 1{
            let cell  = tableView.dequeueReusableCell(withIdentifier: ThumbupCell.className()) as? ThumbupCell
            cell?.update(model)
            return cell!
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.className()) as? CommentCell
        if let commentModel = model.comment_list[indexPath.row - 2] as? CircleCommentModel{
            cell?.update(commentModel)
        }
        return cell!
        
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
