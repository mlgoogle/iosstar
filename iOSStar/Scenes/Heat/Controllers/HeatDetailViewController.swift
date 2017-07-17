
//
//  HeatDetailViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/16.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import BarrageRenderer

class HeatDetailViewController: UIViewController {
    @IBOutlet weak var sellButton: UIButton!

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var backImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var iconImageVie: UIImageView!
    var statusModel:AuctionStatusModel?

    var starListModel:StarSortListModel?
    lazy var renderer: BarrageRenderer = {
        
        let renderer = BarrageRenderer()
        
        renderer.canvasMargin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        renderer.view.backgroundColor = UIColor.clear
        return renderer
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "时间交易"
        view.addSubview(renderer.view)

        backImageVIew.clipsToBounds = true
        

        setData()
        
        buyButton.layer.cornerRadius = 6
        sellButton.layer.cornerRadius = 6

        YD_CountDownHelper.shared.auctionRefresh = { (result)in
            let fans = FansListModel()
            let user = FansInfoModel()
            user.nickname = "hahhah"
            user.headUrl = "http://tva2.sinaimg.cn/crop.0.0.180.180.180/71bf6552jw1e8qgp5bmzyj2050050aa8.jpg"
            fans.user = user
            self.renderer.receive(self.walkTextSpriteDescriptorWithDirection(direction: 0, data: fans))
        }
        YD_CountDownHelper.shared.start()
        renderer.start()
    }
    func requestAuctionSattus() {
        guard starListModel != nil else {
            return
        }
        let model = AuctionStatusRequestModel()
        model.symbol = starListModel!.symbol
        AppAPIHelper.marketAPI().requestAuctionStatus(requestModel: model, complete: { (response) in
            if let model = response as? AuctionStatusModel {
                self.statusModel = model
                
            }
        }) { (error) in

        }
    }
    func setData() {
        
        priceLabel.text = String(format: "%.2f", starListModel?.currentPrice ?? 0)
        iconImageVie.kf.setImage(with: URL(string: starListModel?.pic ?? ""), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = starListModel?.name
    }
    deinit {
        renderer.stop()
    }
    func walkTextSpriteDescriptorWithDirection(direction:UInt,data : FansListModel) -> BarrageDescriptor{
        
        let descriptor:BarrageDescriptor = BarrageDescriptor()
        descriptor.spriteName = NSStringFromClass(YD_BarrageSprite.self)
        descriptor.params["imageUrl"] = data.user?.headUrl
        descriptor.params["name"] = data.user?.nickname
        descriptor.params["speed"] = Int(arc4random()%30) + 50
        descriptor.params["direction"] = direction
        return descriptor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func back(_ sender: Any) {
   
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        pushToDealPage(index: 0)
        
    }

    @IBAction func sellAction(_ sender: Any) {
        pushToDealPage(index: 1)
    }

    func pushToDealPage(index:Int) {
        let storyBoard = UIStoryboard(name: AppConst.StoryBoardName.Deal.rawValue, bundle: nil)
        
        if let vc = storyBoard.instantiateViewController(withIdentifier: "DealViewController") as? DealViewController {
            vc.index = index
            vc.starListModel = starListModel
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }

}
