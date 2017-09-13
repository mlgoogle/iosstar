//
//  VoiceHistoryVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class VoiceHistoryCell: OEZTableViewCell {
    
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var voiceIcon: UIImageView!
    @IBOutlet weak var voiceCountLabel: UILabel!
    
    @IBOutlet var title: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet var status: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var headImg: UIImageView!
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
            let titleTip = response.answer_t == 0 ? "点击播放（未回复）" : "点击播放"
            let attr = NSMutableAttributedString.init(string: titleTip)
            title.attributedText = attr
            voiceCountLabel.text = "听过\(response.s_total)"
            if !response.isplay{
                voiceImg.image = UIImage.init(named: String.init(format: "listion"))
            }
            
            if response.isall == 1{
                if response.answer_t == 0{
                status.text = "明星未回复"
                }else{
                status.text = "已定制"
                }
                StartModel.getStartName(startCode: response.starcode) { [weak self](response) in
                    if let star = response as? StartModel {
                        self?.headImg.kf.setImage(with: URL(string:ShareDataModel.share().qiniuHeader + star.pic_url_tail))
                        self?.nameLab.text = star.name
                    }
                    
                }
                
            }
        }

    }
    
   
}
class VoiceHistoryVC: BasePageListTableViewController ,OEZTableViewDelegate,PLPlayerDelegate{
    
    @IBOutlet weak var titlesView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    var selectRow = 99999999
    var voiceimg: UIImageView!
    var time = 1
    var isplayIng = false
    var type  = true
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
        if voiceimg != nil{
            PLPlayerHelper.shared().doChanggeStatus(4)
            self.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
        }
        if PLPlayerHelper.shared().player.isPlaying{
            PLPlayerHelper.shared().player.stop()
        }
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor(hexString: "ffffff")
        self.selectedButton = sender
        if self.dataSource?.count != 0{
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
        model.starcode = starModel.symbol
        model.pos =  pageIndex == 1 ? 1 : dataSource?.count ?? 0
        model.pType = type ? 1 : 0
        AppAPIHelper.discoverAPI().useraskQuestion(requestModel: model, complete: { [weak self](result) in
            if let response = result as? UserAskList {
                for model in response.circle_list!{
                    model.calculateCellHeight()
                }
                self?.didRequestComplete(response.circle_list as AnyObject )
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            
            self.didRequestComplete(nil )
        }
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = dataSource?[indexPath.row] as? UserAskDetailList{
            return model.cellHeight
        }
        return 200
    }
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!)
    {
        
        if voiceimg != nil{
         self.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
        }
        if PLPlayerHelper.shared().player.isPlaying{
            PLPlayerHelper.shared().player.stop()
        }
        if let cell = tableView.cellForRow(at: indexPath) as? VoiceHistoryCell{
            voiceimg = cell.voiceImg
        }
        
        if let model = self.dataSource?[indexPath.row] as? UserAskDetailList{
            
            if model.answer_t == 0{
             SVProgressHUD.showErrorMessage(ErrorMessage: "明星未回复", ForDuration: 2, completion: nil)
                return
            }
            let url = URL(string: ShareDataModel.share().qiniuHeader +  model.sanswer)
             model.isplay = true
            PLPlayerHelper.shared().player.play(with: url)
         
            PLPlayerHelper.shared().resultBlock =  {  [weak self] (result) in
                if let status = result as? PLPlayerStatus{
                    if status == .statusStopped{
                        if let arr = self?.dataSource?[0] as? Array<AnyObject>{
                            if let model = arr[(self?.selectRow)!] as? UserAskDetailList{
                                model.isplay = false
                            }
                        }
                        PLPlayerHelper.shared().doChanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
                      if status == .statusPaused{
                        if let arr = self?.dataSource?[0] as? Array<AnyObject>{
                            if let model = arr[(self?.selectRow)!] as? UserAskDetailList{
                                model.isplay = false
                            }
                        }
                        PLPlayerHelper.shared().doChanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
                      if status == .statusPreparing{
                        PLPlayerHelper.shared().doChanggeStatus(0)
                        PLPlayerHelper.shared().resultCountDown = {[weak self] (result) in
                            if let response = result as? Int{
                                self?.voiceimg.image = UIImage.init(named: String.init(format: "voice_%d",response))
                            }
                        }
                    }
                     if status == .statusError{
                        PLPlayerHelper.shared().doChanggeStatus(4)
                        self?.voiceimg.image = UIImage.init(named: String.init(format: "listion"))
                    }
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
         let model = dataSource?[indexPath.row] as! UserAskDetailList
        if model.isall == 1{
        return "VoiceALLCell"
        }
        return VoiceQuestionCell.className()
    }
    
    
}
