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
    
    @IBOutlet var title: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet var voiceImg: UIImageView!
    
    override func awakeFromNib() {
    }
    func voiceDidClick(_ sender : UIButton){
        didSelectRowAction(3, data: nil)
    }
    
    override func update(_ data: Any!) {
        if let response = data as? UserAskDetailList{
            contentLabel.text = response.uask
            voiceBtn.addTarget(self, action: #selector(voiceDidClick(_:)), for: .touchUpInside)
            timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(response.ask_t), format: "YYYY-MM-dd")
            let attr = NSMutableAttributedString.init(string: "点击播放")
            title.attributedText = attr
            //            voiceBtn.setAttributedTitle(attr, for: .normal)
            //            voiceBtn.setImage(UIImage.init(named: String.init(format: "listion")), for: .normal)
        }
    }
}
class VoiceHistoryVC: BasePageListTableViewController ,OEZTableViewDelegate,PLPlayerDelegate{
    
    @IBOutlet weak var titlesView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    var voiceimg: UIImageView!
    var time = 1
    var isplayIng = false
    var starModel: StarSortListModel = StarSortListModel()
    var type = true
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
        if self.dataSource?.count != nil{
            self.dataSource?.removeAll()
        }
        if selectedButton == closeButton{
            type = false
            
        }else{
            type = true
        }
        self.didRequest(1)
    }
    
    override func didRequest(_ pageIndex: Int) {
        
        
        let model = UserAskRequestModel()
        model.aType = 2
        model.pos = (pageIndex - 1) * 10
        model.pType = type ? 1 : 0
        AppAPIHelper.discoverAPI().useraskQuestion(requestModel: model, complete: { [weak self](result) in
            if let response = result as? UserAskList {
                self?.didRequestComplete(response.circle_list as AnyObject )
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            
            self.didRequestComplete(nil )
        }
        
    }
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!)
    {
        
        if let cell = tableView.cellForRow(at: indexPath) as? VoiceHistoryCell{
            voiceimg = cell.voiceImg
        }
        if let model = self.dataSource?[indexPath.row] as? UserAskDetailList{
            
            let url = URL(string: ShareDataModel.share().qiniuHeader +  model.sanswer)
            PLPlayerHelper.shared().player.play(with: url)
            PLPlayerHelper.shared().resultBlock =  {  [weak self] (result) in
                if let status = result as? PLPlayerStatus{
                    if status == .statusStopped{
                        PLPlayerHelper.shared().dochanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
                      if status == .statusPaused{
                        PLPlayerHelper.shared().dochanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
                      if status == .statusPreparing{
                        PLPlayerHelper.shared().dochanggeStatus(0)
                        PLPlayerHelper.shared().resultCountDown = {[weak self] (result) in
                            if let response = result as? Int{
                                self?.voiceimg.image = UIImage.init(named: String.init(format: "voice_%d",response))
                            }
                        }
                    }
                     if status == .statusError{
                        PLPlayerHelper.shared().dochanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
//                    else{
////                        PLPlayerHelper.shared().dochanggeStatus(4)
//                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
//                    }
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VoiceQuestionCell.className()
    }
    
    
}
