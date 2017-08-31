//
//  VideoQuestionsVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/18.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
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
            contentLabel.text = response.uask
            iconImage.kf.setImage(with: URL(string : response.headUrl), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            nameLabel.text = response.nickName
            if response.purchased == 1{
                let attr = NSMutableAttributedString.init(string: "点击观看")
                priceLabel.attributedText = attr
            }else{
                let attr = NSMutableAttributedString.init(string: "花费\(response.c_type)秒观看回答")
                attr.addAttributes([NSForegroundColorAttributeName: UIColor.init(rgbHex: 0xfb9938)], range: NSRange.init(location: 2, length: "\(response.c_type)".length()))
                priceLabel.attributedText = attr
            }
           
            timeLabel.text = Date.yt_convertDateStrWithTimestempWithSecond(Int(response.ask_t), format: "YYYY-MM-dd")
            countLabel.text = "观看\(response.s_total)"
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
        model.aType = 1
        model.pType = 1
        AppAPIHelper.discoverAPI().staraskQuestion(requestModel: model, complete: { [weak self](result) in
            if let response = result as? UserAskList {
                self?.didRequestComplete([response.circle_list] as AnyObject )
                
                self?.tableView.reloadData()
            }
            
        }) { (error) in
            self.didRequestComplete(nil)
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
        if let arr = self.dataSource?[0] as? Array<AnyObject>{
            if let model = arr[indexPath.row] as? UserAskDetailList{
                
                if model.purchased == 1{
                    if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "PlayVideoVC") as? PlayVideoVC{
                        vc.startModel = model
                        present(vc, animated: true, completion: {
                            vc.play(ShareDataModel.share().qiniuHeader + model.sanswer)
                        })
                    }
                }
                else{
                    let request = PeepVideoOrvoice()
                    request.qid = Int(model.id)
                    request.starcode = starModel.symbol
                    request.cType = model.c_type
                    AppAPIHelper.discoverAPI().peepAnswer(requestModel: request, complete: { (result) in
                        if let response = result as? ResultModel{
                            if response.result == 0{
                                model.purchased = 1
                                tableView.reloadRows(at: [indexPath], with: .none)
                                if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "PlayVideoVC") as? PlayVideoVC{
                                    vc.startModel = model
                                    self.present(vc, animated: true, completion: {
                                        vc.play(ShareDataModel.share().qiniuHeader + model.sanswer)
                                    })
                                }
                            }else{
                                SVProgressHUD.showWainningMessage(WainningMessage: "您持有的时间不足", ForDuration: 1, completion: nil)
                            }
                        }
                    }, error: { (error) in
                        self.didRequestError(error)
                    })
                    
                }
            }
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
