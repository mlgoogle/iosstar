//
//  BarrageStarVC.swift
//  iOSStar
//
//  Created by sum on 2017/7/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh
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

    var headerview = UIView()
    var dataArry = [StartModel]()
    @IBOutlet var collective: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupInit() {
        

        
        // 自定义布局
        let layout = UICollectionViewFlowLayout()
       
//        layout.dataSource = self
        layout.headerReferenceSize = CGSize.init(width: self.view.frame.size.width, height: 200)
        layout.footerReferenceSize = CGSize.init(width: self.view.frame.size.width, height: 0)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize.init(width: (self.view.frame.size.width - 150)/4, height: (self.view.frame.size.width - 150)/4 + 20)

        self.collective.collectionViewLayout = layout
        layout.scrollDirection = .vertical
//        self.collective.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
//            
//        })
  
        StartModel.getallStartName { [weak self](result) in
//            self?.dataArry = result
            if let model =  result as? [StartModel]{
              self?.dataArry = model
              self?.collective.reloadData()
            }
//            print(result)
        }
        self.collective.showsVerticalScrollIndicator = false
        self.collective.showsHorizontalScrollIndicator = false

        
    }
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStarItem", for: indexPath) as! OrderItem
        cell.updata(dataArry[indexPath.row])
        return cell
       
    }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 30, bottom: 5, right: 30)
    
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
        headerview = view
        headerview.backgroundColor = UIColor.red
        return view
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return self.dataArry.count
    }
}
