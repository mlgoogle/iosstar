//
//  IntroduceTableVC.swift
//  iOSStar
//
//  Created by mu on 2017/9/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
import MWPhotoBrowser

class IntroduceTableVC: BaseTableViewController {
    @IBOutlet weak var introduceCell: StarIntroduceCell!
    @IBOutlet weak var experienceCell: MarketExperienceCell!
    @IBOutlet weak var circleCell: StarCirCleCell!
    @IBOutlet weak var dynamicCell: StarDynamicCell!
    @IBOutlet weak var detaiCirCellCell: StarDetailCirCell!
    @IBOutlet weak var photoCell: StarPhotoCell!
    
    var starModel:StarSortListModel?
    var images:[String] = []
    var selectImage = ""
    var rowHeights: [CGFloat] = [170,0,150,150,150,150,150,150]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "网红简介"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        initDelegate()
        requestStarDetailInfo()
        requestExperience()
        requeseDetail()
    }
    
    func initDelegate() {
        experienceCell.delegate = self
        circleCell.delegate = self
        dynamicCell.delegate = self
        detaiCirCellCell.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row ==  1{
            return UITableViewAutomaticDimension
        }
        return rowHeights[indexPath.row]
    }
}

//MARK: - introduceCell && PhotoCell
extension IntroduceTableVC: MWPhotoBrowserDelegate,MenuViewDelegate{
    
    func requestStarDetailInfo() {
        guard starModel != nil else {
            return
        }
        let requestModel = StarDetaiInfoRequestModel()
        requestModel.star_code = starModel!.symbol
        AppAPIHelper.discoverAPI().requestStarDetailInfo(requestModel: requestModel, complete: { (response) in
            if let model = response as? StarIntroduceResult {
                self.introduceCell.setData(model: model.resultvalue!)
                self.checkImages(model.resultvalue)
            }
        },error: nil)
    }
    
    func checkImages(_ starDetailModel: StarDetaiInfoModel?) {
        
        if checkUrl(url: starDetailModel?.portray1_tail) {
            images.append(ShareDataModel.share().qiniuHeader + starDetailModel!.portray1_tail)
        }
        if checkUrl(url: starDetailModel?.portray2_tail) {
            images.append(ShareDataModel.share().qiniuHeader + starDetailModel!.portray2_tail)
        }
        if checkUrl(url: starDetailModel?.portray3_tail) {
            images.append(ShareDataModel.share().qiniuHeader + starDetailModel!.portray3_tail)
        }
        if checkUrl(url: starDetailModel?.portray4_tail) {
            images.append(ShareDataModel.share().qiniuHeader + starDetailModel!.portray4_tail)
        }
        photoCell.setImageUrls(images: images, delegate:self)
    }
    
    func checkUrl(url:String?)-> Bool {
        if url == nil {return false}
        return url!.length()>0 ? true : false
    }
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return 1
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        var urlString = images[Int(index)]
        if  !urlString.hasPrefix("http") {
            urlString = ShareDataModel.share().qiniuHeader + urlString
        }
        let photo = MWPhoto(url:URL(string: selectImage))
        return photo
    }
    
    func menuViewDidSelect(indexPath: IndexPath) {
        selectImage = images[indexPath.row]
        let vc = PhotoBrowserVC(delegate: self)
        present(vc!, animated: true, completion: nil)
    }
}

//MARK: - Experise
extension IntroduceTableVC: MarketExperienceCellDelegate{
    func requestExperience() {
        guard starModel != nil else {
            return
        }
        AppAPIHelper.marketAPI().requestStarExperience(code: starModel!.symbol, complete: { (response) in
            if let models =  response as? [ExperienceModel] {
                var totalExperience = ""
                for model in models{
                    totalExperience += model.experience + "\\n"
                }
                self.experienceCell.setTitle(title: totalExperience)
            }
        },error:nil)
    }
    
    func showMore() {
        tableView.reloadData()
    }
    
    func Packup() {
        tableView.reloadData()
    }
}

//MARK: - Circle&&Dynamic
extension IntroduceTableVC: StarCirCleCellDelegate, StarDynamicCellDelegate,StarDetailCirCellDelegate{
    func requeseDetail(){
        guard starModel != nil else {
            return
        }
        let model = CirCleStarDetail()
        model.starcode = self.starModel!.symbol
        model.aType = 1
        model.pType = 1
        AppAPIHelper.discoverAPI().requestStarDetail(requestModel: model, complete: { (result) in
            if let response = result as? StarDetailCircle{
                self.detaiCirCellCell.datasource = response
                self.dynamicCell.datasource =  response
            }
        },error:nil)
    }
    
    func starask(_select: UserAskDetailList) {
        let model  = _select
        if model.purchased == 1{
            if model.video_url != ""{
                self.pushcontroller(pushSreing: PlayVideoVC.className(), model: model, playString: model.video_url)
            }
            else{
                self.pushcontroller(pushSreing: PlaySingleVC.className(), model: model, playString: model.sanswer)
            }
        }else{
            let request = PeepVideoOrvoice()
            request.qid = Int(model.id)
            request.starcode = (starModel?.symbol)!
            request.cType = model.c_type
            request.askUid = model.uid
            AppAPIHelper.discoverAPI().peepAnswer(requestModel: request, complete: { (result) in
                if let response = result as? ResultModel{
                    if response.result == 0{
                        model.purchased = 1
                        
                        if model.video_url != ""{
                            self.pushcontroller(pushSreing: PlayVideoVC.className(), model: model, playString: model.video_url)
                        }
                        else{
                            self.pushcontroller(pushSreing: PlaySingleVC.className(), model: model, playString: model.sanswer)
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
    
    func showBigImg(_select: CircleListModel) {
        //showCirCleUrl = String(ShareDataModel.share().qiniuHeader + _select.pic_url_tail)
        let vc = PhotoBrowserVC(delegate: self)
        present(vc!, animated: true, completion: nil)
    }
    
    func starask(){
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VideoManagerVC.className()) as? VideoManagerVC{
            vc.starModel = starModel!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func voice(){
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VoiceManagerVC") as? VoiceManagerVC{
            vc.starModel = starModel!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func staractive(){
        ShareDataModel.share().selectStarCode = (starModel?.symbol)!
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: StarNewsVC.className()) as? StarNewsVC{
            vc.starModel = starModel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


