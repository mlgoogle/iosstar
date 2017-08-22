//
//  StarIntroduceViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MWPhotoBrowser
import SVProgressHUD
class StarIntroduceViewController: UIViewController {
    
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var appointmentButton: UIButton!
    var showMoreIntroduce  = true
    var index = 0
    var headerImg = UIImageView()
    var starModel:StarSortListModel?
    var sectionHeights = [170,18 , 120, 220 , 150]
    var identifers = [StarIntroduceCell.className(),MarketExperienceCell.className(), StarCirCleCell.className(), StarDynamicCell.className() ,StarPhotoCell.className()]
    var images:[String] = []
    var starDetailModel:StarDetaiInfoModel?
    var expericences:[ExperienceModel]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBarBgAlpha = 0.0
        
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: PubInfoHeaderView.className())
        appointmentButton.layer.shadowColor = UIColor(hexString: "cccccc").cgColor
        appointmentButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        appointmentButton.layer.shadowRadius = 1
        tableView.estimatedRowHeight = 20
        appointmentButton.layer.shadowOpacity = 0.5
        requestStarDetailInfo()
        requestExperience()
        //        let share = UIButton.init(type: .custom)
        //        share.setImage(UIImage.init(named: "star_share"), for: .normal)
        //        share.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        //        share.addTarget(self, action: #selector(sharetothird), for: .touchUpInside)
        //        let item = UIBarButtonItem.init(customView: share)
        //        self.navigationItem.rightBarButtonItem = item
        
        
        
    }
    func sharetothird(){
        if let model = expericences?[0]{
          
            
            let share  = Share()
            let vc = UIStoryboard.init(name: "Market", bundle: nil).instantiateViewController(withIdentifier: "ShareVC") as? ShareVC
            vc?.modalPresentationStyle = .custom
            share.titlestr = (starDetailModel?.star_name)! + "(正在星享时光 出售TA的时间)"
            share.Image = headerImg.image
            share.descr = model.experience
            share.work = (starDetailModel?.work)!
            share.star_code = (starDetailModel?.star_code)!
            share.name = (starDetailModel?.star_name)!
            vc?.share = share
            share.webpageUrl = "https://fir.im/starShareUser?uid=\(StarUserModel.getCurrentUser()?.userinfo?.id ?? 0)"
            vc?.modalTransitionStyle = .crossDissolve
            present(vc!, animated: true, completion: nil)
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        if let _ = UserDefaults.standard.value(forKey: AppConst.guideKey.StarIntroduce.rawValue) as? String {
            
        }else{
            showGuideVC(.StarIntroduce, handle: { (vc)in
                if let guideVC = vc as? GuideVC{
                    if guideVC.guideType == AppConst.guideKey.StarIntroduce{
                        guideVC.dismiss(animated: true, completion:nil)
                        UserDefaults.standard.set("ok", forKey: AppConst.guideKey.StarIntroduce.rawValue)
                    }
                }
            })
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func requestStarDetailInfo() {
        guard starModel != nil else {
            return
        }
        let requestModel = StarDetaiInfoRequestModel()
        requestModel.star_code = starModel!.symbol
        AppAPIHelper.discoverAPI().requestStarDetailInfo(requestModel: requestModel, complete: { (response) in
            if let model = response as? StarIntroduceResult {
                self.starDetailModel = model.resultvalue
                self.checkImages()
                self.tableView.reloadData()
            }
        }) { (error) in
            
            
        }
    }
    
    func checkImages() {
        
        if checkUrl(url: starDetailModel?.portray1) {
            images.append(starDetailModel!.portray1)
        }
        if checkUrl(url: starDetailModel?.portray2) {
            images.append(starDetailModel!.portray2)
        }
        if checkUrl(url: starDetailModel?.portray3) {
            images.append(starDetailModel!.portray3)
        }
        if checkUrl(url: starDetailModel?.portray4) {
            images.append(starDetailModel!.portray4)
        }
        self.tableView.reloadData()
        
    }
    
    func checkUrl(url:String?)-> Bool {
        if url == nil {return false}
        return url!.hasPrefix("http")
    }
    func requestExperience() {
        guard starModel != nil else {
            return
        }
        AppAPIHelper.marketAPI().requestStarExperience(code: starModel!.symbol, complete: { (response) in
            if let models =  response as? [ExperienceModel] {
                self.expericences = models
                self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
            }
        }) { (error) in
            
        }
        
    }
    @IBAction func askToBuy(_ sender: Any) {
        
        if self.starDetailModel?.publish_type !=  2 {
            return
        }
        let storyBoard = UIStoryboard(name: "Heat", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HeatDetailViewController") as! HeatDetailViewController
        vc.starListModel = starModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func appointmentAction(_ sender: Any) {
        if starDetailModel == nil{
            return
        }
        
        if self.starDetailModel?.publish_type !=  2 {
            return
        }
        
        let storyBoard = UIStoryboard(name: "Market", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OrderStarViewController") as! OrderStarViewController
        starModel?.home_pic_tail = (starDetailModel?.back_pic_tail)!
        vc.starInfo = starModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func requestPositionCount() {
        guard starModel != nil else {
            return
        }
        if self.starDetailModel?.publish_type == 0 {
         return
        }
        let r = PositionCountRequestModel()
        r.starcode = starModel!.symbol
        AppAPIHelper.marketAPI().requestPositionCount(requestModel: r, complete: { (response) in
            if let model = response as? PositionCountModel {
                if model.star_time > 0 {
                    
                    let session = NIMSession(self.starDetailModel?.acc_id ?? "", type: .P2P)
                    let vc = YDSSessionViewController(session: session)
                    
                    vc?.starcode = self.starModel?.symbol ?? ""
                    
                    vc?.starname = (self.starDetailModel?.star_name)!
                    self.navigationController?.pushViewController(vc!, animated: true)
                } else {
                    
                    SVProgressHUD.showErrorMessage(ErrorMessage: "未持有该明星时间", ForDuration: 1.0, completion: nil)
                    
                }
            }
        }) { (error) in
            SVProgressHUD.showErrorMessage(ErrorMessage: "未持有该明星时间", ForDuration: 1.0, completion: nil)
        }
    }
    
}
extension StarIntroduceViewController:UITableViewDelegate, UITableViewDataSource,MenuViewDelegate, MWPhotoBrowserDelegate, UIScrollViewDelegate, PopVCDelegate,MarketExperienceCellDelegate,StarCirCleCellDelegate,StarDynamicCellDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 170 {
            self.navBarBgAlpha = 1.0
            title = self.starModel?.name
        } else {
            self.navBarBgAlpha = 0.0
            title =   ""
            
        }
    }
    func back() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func chat() {
        
        requestPositionCount()
    }
    func share() {
        sharetothird()
    }
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return 1
    }
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let photo = MWPhoto(url:URL(string:ShareDataModel.share().qiniuHeader + images[Int(self.index)]))
        return photo
    }
    
    func menuViewDidSelect(indexPath: IndexPath) {
        index = indexPath.item
        let vc = PhotoBrowserVC(delegate: self)
        present(vc!, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
        case 1:
            return 70
        case 2:
            return 0.001
        case 3:
            return 70
        case 4:
            return 70
        default:
            return 0.01
        }
    }
    func showMore() {
        showMoreIntroduce = false
        self.tableView.reloadSections(IndexSet.init(integer: 1), with: .fade)
    }
    func Packup() {
        showMoreIntroduce = true
        self.tableView.reloadSections(IndexSet.init(integer: 1), with: .fade)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if  section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as? PubInfoHeaderView
            header?.setTitle(title:"个人介绍")
            header?.contentView.backgroundColor = UIColor(hexString: "fafafa")
            return header
            
            
        }
        else  if  section == 2 {
            let view = UIView()
            view.backgroundColor = UIColor.init(hexString: "fafafa")
            return view
        }
      else  if  section == 4 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as? PubInfoHeaderView
            header?.setTitle(title:"个人写真")
            header?.contentView.backgroundColor = UIColor(hexString: "fafafa")
            return header
        }
        else  if  section == 3 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as? PubInfoHeaderView
            header?.setTitle(title:"最新动态")
            header?.contentView.backgroundColor = UIColor(hexString: "fafafa")
            return header
        }
        else {
            let view = UIView()
            view.backgroundColor = UIColor.init(hexString: "fafafa")
            return view
        }
        
        
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return identifers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if showMoreIntroduce{
                if expericences != nil{
                    return 1
                }
                
            }else{
                return expericences?.count ?? 0
            }
            
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return UITableViewAutomaticDimension
        }
        return CGFloat(sectionHeights[indexPath.section])
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers[indexPath.section]!, for: indexPath)
        switch indexPath.section {
        case 0:
            if let introCell = cell as? StarIntroduceCell {
                introCell.delegate = self
                guard starDetailModel != nil else {
                    return cell
                }
                
                introCell.setData(model: starDetailModel!)
                headerImg = introCell.iconImageView
            }
        case 1:
            if let expericencesCell = cell as? MarketExperienceCell {
                
                expericencesCell.delegate = self
                if showMoreIntroduce{
                    expericencesCell.show.isHidden = false
                    expericencesCell.showHeight.constant = 15
                    
                }else{
                    //最后一区
                    if indexPath.row == (expericences?.count)! - 1{
                        expericencesCell.show.isHidden = false
                        expericencesCell.show.setTitle("点击收起", for: .normal)
                        expericencesCell.showHeight.constant = 15
                    }else{
                        expericencesCell.show.isHidden = true
                        expericencesCell.showHeight.constant = 0
                    }
                    
                    
                }
                if expericences != nil {
                    let model = expericences![indexPath.row]
                    
                    expericencesCell.setTitle(title: model.experience)
                }
                
            }
        case 2:
            if let StarCirCle = cell as? StarCirCleCell {
                StarCirCle.delegate = self
                StarCirCle.backgroundColor = UIColor.clear
//                photoCell.setImageUrls(images: images, delegate:self)
            }
            
        case 3:
            if let photoCell = cell as? StarDynamicCell {
//                photoCell.setImageUrls(images: images, delegate:self)
                photoCell.delegate = self
            }
        case 4:
            if let photoCell = cell as? StarPhotoCell {
                photoCell.setImageUrls(images: images, delegate:self)
            }
        default:
            break
        }
        return cell
    }
    func starask(){
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: VideoQuestionsVC.className()) as? VideoQuestionsVC{
            vc.starModel = starModel!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func voice(){
        
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: "VoiceQuestionVC") as? VoiceQuestionVC{
            vc.starModel = starModel!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
     func staractive(){
        
        //TakeMovieVC
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: StarNewsVC.className()) as? StarNewsVC{
            //TakeMovieVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func starask(_select: Int) {
        print(_select)
    }
}


