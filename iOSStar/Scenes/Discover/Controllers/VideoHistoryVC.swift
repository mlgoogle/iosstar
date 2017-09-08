//
//  VideoHistoryVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class VideoHistoryCell: OEZTableViewCell {
    
    @IBOutlet weak var voiceCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seeAskLabel: UILabel!
    @IBOutlet weak var seeAnsLabel: UILabel!
    
    
    override func awakeFromNib() {
        
    }
    
    override func update(_ data: Any!) {
        if let response = data as? UserAskDetailList{
            contentLabel.text = response.uask
            timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(response.ask_t), format: "YYYY-MM-dd")
            voiceCountLabel.text = "\(response.s_total)看过"
        }
    }
    
    @IBAction func seeAnswer(_ sender: Any) {
        didSelectRowAction(1, data: nil)
    }
    @IBAction func seeAsk(_ sender: Any) {
        didSelectRowAction(2, data: nil)
    }
    
}


class VideoHistoryVC: BasePageListTableViewController,OEZTableViewDelegate {
    
    @IBOutlet weak var titlesView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var openButton: UIButton!
    var starModel: StarSortListModel = StarSortListModel()
    var type = true
    private var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "历史提问"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        titleViewButtonAction(openButton)
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!){
        if action ==  1{
            if let model = dataSource?[indexPath.row] as? UserAskDetailList{
                
                if model.answer_t == 0{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "明星还没回复", ForDuration: 2, completion: nil)
                    return
                }
                if model.video_url != ""{
                    self.pushViewController(pushSreing: PlayVideoVC.className(), videdoUrl: (ShareDataModel.share().qiniuHeader + model.sanswer), pushModel: model, withImg: model.thumbnailS != "" ? model.thumbnailS  :  "1123.png", complete: { (result) in
                        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
        
                }else{
                    self.pushViewController(pushSreing: PlaySingleVC.className(), videdoUrl: (ShareDataModel.share().qiniuHeader + model.sanswer), pushModel: model, withImg: model.thumbnailS != "" ? model.thumbnailS  :  "1123.png", complete: { (result) in
                        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    })
                    
                }
            }
        }
        if action ==  2{
            
            if let model = dataSource?[indexPath.row] as? UserAskDetailList{
                
                if model.video_url == ""{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "没有提问视频问题", ForDuration: 2, completion: nil)
                    return
                }
                
                self.pushViewController(pushSreing: PlaySingleVC.className(), videdoUrl: (ShareDataModel.share().qiniuHeader + model.video_url), pushModel: model, withImg: model.thumbnail != "" ? model.thumbnail  :  "1123.png", complete: { (result) in
                    if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
                        vc.starModel = self.starModel
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                })
                
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 175
    }
    @IBAction func titleViewButtonAction(_ sender: UIButton) {
        
        if self.dataSource != nil{
            self.dataSource?.removeAll()
            self.tableView.reloadData()
        }
        self.selectedButton?.isSelected = false
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor.init(rgbHex: 0xECECEC)
        self.selectedButton = sender
        if selectedButton == closeButton{
            type = false
            
        }else{
            type = true
        }
        self.didRequest(1)
    }
    
    override func didRequest(_ pageIndex: Int) {
        
        let model = UserAskRequestModel()
        model.aType = 1
        model.starcode = starModel.symbol
        model.pos = (pageIndex - 1) * 10
        model.pType = type ? 1 : 0
        model.pos = (pageIndex - 1) * 10
        AppAPIHelper.discoverAPI().useraskQuestion(requestModel: model, complete: { [weak self](result) in
            if let response = result as? UserAskList {
                self?.didRequestComplete(response.circle_list as AnyObject )
                
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            self.didRequestComplete(nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        return VideoHistoryCell.className()
    }
    
}
