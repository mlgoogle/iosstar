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
   
    
    @IBOutlet var status: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var header: UIImageView!
    @IBOutlet var askBtn: UIButton!
    
    override func awakeFromNib() {
        
    }
    
    override func update(_ data: Any!) {
        if let response = data as? UserAskDetailList{
            contentLabel.text = response.uask
            timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(response.ask_t), format: "YYYY-MM-dd")
            voiceCountLabel.text = "\(response.s_total)看过"
            askBtn.isHidden = response.video_url == "" ? true : false
            if response.isall == 1{
                if response.answer_t == 0{
                    status.text = "明星未回复"
                }else{
                    status.text = "已定制"
                }
                StartModel.getStartName(startCode: response.starcode) { [weak self](response) in
                    if let star = response as? StartModel {
                        self?.header.kf.setImage(with: URL(string:ShareDataModel.share().qiniuHeader + star.pic_url_tail))
                        self?.name.text = star.name
                    }
                    
                }

            }
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
        titleViewButtonAction(openButton)
    }
    
    func tableView(_ tableView: UITableView!, rowAt indexPath: IndexPath!, didAction action: Int, data: Any!){
        if action ==  1{
            if let model = dataSource?[indexPath.row] as? UserAskDetailList{
                
                if model.answer_t == 0{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "明星还没回复", ForDuration: 2, completion: nil)
                    return
                }
                self.pushViewController(pushSreing: PlaySingleVC.className(), videdoUrl: (ShareDataModel.share().qiniuHeader + model.sanswer), pushModel: model, withImg: model.thumbnailS != "" ? model.thumbnailS  :  "1123.png", complete: { (result) in
                    if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VideoAskQuestionsVC") as? VideoAskQuestionsVC{
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                })
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
        if let model = dataSource?[indexPath.row] as? UserAskDetailList{
            return model.cellHeight
        }
       return 175
    }
    
    @IBAction func titleViewButtonAction(_ sender: UIButton) {
        
        if self.dataSource != nil{
            self.dataSource?.removeAll()
            self.tableView.reloadData()
        }
        self.selectedButton?.isSelected = false
        self.selectedButton?.backgroundColor = UIColor.clear
        sender.backgroundColor = UIColor(hexString: "ffffff")
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
        if starModel.symbol == ""{
         
        }else{
        model.starcode = starModel.symbol
        }
        model.pos =  pageIndex == 1 ? 1 : dataSource?.count ?? 0
        model.pType = type ? 1 : 0
        model.pos = (pageIndex - 1) * 10
        AppAPIHelper.discoverAPI().useraskQuestion(requestModel: model, complete: { [weak self](result) in
            if let response = result as? UserAskList {
                for model in response.circle_list!{
                    model.calculateCellHeight()
                }
                self?.didRequestComplete(response.circle_list as AnyObject )
            }
            
        }) { (error) in
            self.didRequestComplete(nil)
        }
    }

    override func tableView(_ tableView: UITableView, cellIdentifierForRowAtIndexPath indexPath: IndexPath) -> String? {
        let model = dataSource?[indexPath.row] as! UserAskDetailList
        if model.isall == 1{
            return "VideoShowImgCell"
        }
        //
        return VideoHistoryCell.className()
    }
    
}
