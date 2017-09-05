//
//  StarDynamicCell.swift
//  iOSStar
//
//  Created by sum on 2017/8/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol StarDynamicCellDelegate {
    
    func starask(_select : UserAskDetailList)
    
}

class StarDynamicCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{
    
   
    @IBOutlet var collectView: UICollectionView!
    var datasource : StarDetailCircle?{
        didSet{
            collectView?.reloadData()
        
        }
        
    }
    var delegate : StarDynamicCellDelegate?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarDynamicVideoCell", for: indexPath) as! StarDynamicVideoCell
         cell.Qimg.image = UIImage(named: "novideo")
        if let data = datasource?.questions?[indexPath.row]{
        cell.qtitle.text = data.uask
         cell.qtitle.textAlignment = .center
        cell.Qimg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (data.thumbnailS)), placeholder: UIImage(named: "novideo"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
         cell.qtitle.text = ""
         
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
        layout.itemSize = CGSize.init(width: (kScreenWidth - 15 * 4)/3.0, height: 100 )
        self.collectView.collectionViewLayout = layout
        
    }

   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let data = datasource?.questions?[indexPath.row]{
        delegate?.starask(_select: data)
        }
        
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
