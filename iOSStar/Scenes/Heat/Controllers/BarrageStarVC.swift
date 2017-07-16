//
//  BarrageStarVC.swift
//  iOSStar
//
//  Created by sum on 2017/7/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

import BarrageRenderer
let leftConstant = 15
class OrderItem: UICollectionViewCell {

    @IBOutlet var nameLb: UILabel!
    @IBOutlet var starImg: UIImageView!
    
    func updata(_ data : AnyObject){
    
        if let response = data as? StartModel{
        
            nameLb.text = response.name
             self.starImg.kf.setImage(with: URL(string: response.pic_url))
        }
    
    }
    
}
class BarrageStarVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var renderer:BarrageRenderer!
    var headerview = UIView()
    var index = 0
    var allData = [StartModel]()
    var dataArry = [StartModel]()
    @IBOutlet var collective: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        title = "粉丝榜"
        setupInit()
        buildDanMu()
        initdata()
        customer()
        // Do any additional setup after loading the view.
    }
     //Mark :创建renderer
    func buildDanMu() {
        self.renderer = BarrageRenderer.init()

        self.renderer.canvasMargin = UIEdgeInsetsMake( 0, 0,40, 0)
         self.renderer.view.backgroundColor = UIColor.init(hexString: "FAFAFA")
    }
     //Mark :更新view
    func autoSenderBarrage() {
         index = index + 1
        if index == allData.count{
          index = 0
        }
         renderer.receive(walkTextSpriteDescriptorWithDirection(direction: BarrageWalkDirection.R2L.rawValue, data: allData[index]))
    }
    //Mark :数据加载
    func walkTextSpriteDescriptorWithDirection(direction:UInt,data : StartModel) -> BarrageDescriptor{
        
        let descriptor:BarrageDescriptor = BarrageDescriptor()
        descriptor.spriteName = NSStringFromClass(BarrageWalkImageTextSprite.self)

        let attachment = NSTextAttachment()
        let img  = UIImage.init(named: "QQ")
        
        attachment.image = img?.barrageImageScaleToSize(CGSize.init(width: 15, height: 15))
        
        let attributed = NSMutableAttributedString.init(string: "  " + " 小姜求购" +  data.name + " ")
        attributed.insert(NSAttributedString.init(attachment: attachment), at: 1)
        descriptor.params["attributedText"] = attributed;
        descriptor.params["backgroundColor"] = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
     
        descriptor.params["fontSize"] = 13
        descriptor.params["cornerRadius"] = 10
        descriptor.params["textColor"] = UIColor.white
        descriptor.params["speed"] = Int(arc4random()%100) + 50
        descriptor.params["direction"] = direction
        return descriptor
    }
    // MARK: 数据请求
    func initdata(){
        
        index = 0
        let requestModel = FanListRequestModel()
        requestModel.buySell = 0
        requestModel.symbol = "1004"
//        AppAPIHelper.marketAPI().requestOrderFansList(requestModel: requestModel, complete: { [weak self](response) in
//            if let models = response as? [OrderFansListModel]{
//                
////                self?.allData = models
////                _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self?.autoSenderBarrage), userInfo: nil, repeats: true)
//                
////                self?.renderer.start()
//                
//            }
//        }) { (error) in
//           
//        }
    }
    // MARK: 本地加载数据
    func  customer(){
    
        for _ in 0...100 {
            
            let model = StartModel()
           
            model.name = "**888购买"
             model.price = 1000

            allData.append(model)
           
        }
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.autoSenderBarrage), userInfo: nil, repeats: true)
        
        self.renderer.start()
    
    }
     // MARK: 自定义布局
    func setupInit() {

        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.size.width, height: 300)
        layout.footerReferenceSize = CGSize.init(width: self.view.frame.size.width, height: 0)
        layout.minimumLineSpacing = CGFloat.init(leftConstant)
        layout.minimumInteritemSpacing = CGFloat.init(leftConstant)
        layout.itemSize = CGSize.init(width: (self.view.frame.size.width - CGFloat.init(leftConstant) * 5)/4, height: (self.view.frame.size.width - CGFloat.init(leftConstant) * 5)/4 + 20)

        self.collective.collectionViewLayout = layout
        layout.scrollDirection = .vertical
        StartModel.getallStartName { [weak self](result) in

            if let model =  result as? [StartModel]{
              self?.dataArry = model
              self?.collective.reloadData()
            }
        }
        self.collective.showsVerticalScrollIndicator = false
        self.collective.showsHorizontalScrollIndicator = false

        
    }
 
     // MARK: collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStarItem", for: indexPath) as! OrderItem
        cell.updata(dataArry[indexPath.row])
        return cell
       
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: CGFloat.init(leftConstant), bottom: 5, right: CGFloat.init(leftConstant))
    
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
        headerview = view
//        if (add){
        headerview.addSubview(renderer.view)
//        }
//        headerview.backgroundColor = UIColor.red
        return view
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return self.dataArry.count
    }
}
