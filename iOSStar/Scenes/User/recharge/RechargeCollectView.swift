//
//  RechargeCollectView.swift
//  iOSStar
//
//  Created by sum on 2017/6/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class RechargeCollectViewCell: UICollectionViewCell {

    @IBOutlet var title: UILabel!
   
    override func awakeFromNib(){
    
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.init(hexString: AppConst.Color.orange).cgColor
     
         title.textColor = UIColor.init(hexString: AppConst.Color.orange)
        
        
//        self.layer.backgroundColor = 
    
    }
}
class RechargeCollectView: UICollectionView ,UICollectionViewDelegate,UICollectionViewDataSource,CustomLayoutDataSource{
     var selectPath : IndexPath? = nil
     var titleArr = ["1","10","100","1000","10000","500000"]
    var setSelect  = "" {
        didSet {
            if selectPath != nil{
                let cell = self.cellForItem(at: selectPath! as IndexPath) as! RechargeCollectViewCell
                cell.backgroundColor = UIColor.white
                cell.title.textColor = UIColor.init(hexString: AppConst.Color.orange)
            }
        }
    }
    var resultBlock: CompleteBlock?
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        // 自定义布局
        let layout = CustomLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        self.collectionViewLayout = layout
        layout.scrollDirection = .horizontal

        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
    }
    func numberOfRols(_ customLayout: CustomLayout) -> Int {
        return 2
    }
    
    func numberOfCols(_ customLayout: CustomLayout) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    
        return 6
    
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RechargeCollectViewCell", for: indexPath) as! RechargeCollectViewCell
           cell.title.text = titleArr[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectPath != nil{
         let cell = collectionView.cellForItem(at: selectPath! as IndexPath) as! RechargeCollectViewCell
            cell.backgroundColor = UIColor.white
            cell.title.textColor = UIColor.init(hexString: AppConst.Color.orange)
        }
         let cell = collectionView.cellForItem(at: indexPath) as! RechargeCollectViewCell
         cell.backgroundColor = UIColor.init(hexString: AppConst.Color.orange)
    
        cell.title.textColor = UIColor.white
        selectPath = indexPath as IndexPath
   
        self.resultBlock!(cell.title.text as AnyObject)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
