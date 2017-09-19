//
//  StarDynamicCell.swift
//  iOSStar
//
//  Created by sum on 2017/8/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarDetailCircleCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet var collectView: UICollectionView!
    var datasource : StarDetailCircle?{
        didSet{
            collectView?.reloadData()
            
        }
        
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarDynamicVideoCell", for: indexPath) as! StarDynamicVideoCell
        if let data = datasource?.questions?[indexPath.row]{
            cell.qtitle.text = data.uask
            cell.qtitle.textAlignment = .center
            cell.Qimg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (data.thumbnail)), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            cell.qtitle.text = "----"
            
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (datasource?.questions?.count) ?? 3
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = CGFloat.init(leftConstant)
        layout.minimumInteritemSpacing = CGFloat.init(leftConstant)
        layout.itemSize = CGSize.init(width: (kScreenWidth - 10 * 3)/2.0, height: (kScreenWidth - 10 * 3)/2.0 )
        self.collectView.collectionViewLayout = layout
        
    }
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
