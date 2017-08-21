//
//  StarDynamicCell.swift
//  iOSStar
//
//  Created by sum on 2017/8/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol StarDynamicCellDelegate {
    
    func starask(_select : Int)
    
}

class StarDynamicCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{
    @IBOutlet var activeRight: UIButton!
    @IBOutlet var collectView: UICollectionView!
    
    @IBOutlet var active: UIButton!
    var delegate : StarDynamicCellDelegate?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarDynamicVideoCell", for: indexPath)
        return cell
        
        
    }

   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }


   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = CGFloat.init(leftConstant)
        layout.minimumInteritemSpacing = CGFloat.init(leftConstant)
        layout.itemSize = CGSize.init(width: (self.frame.size.width - 20 * 4)/3, height: (self.frame.size.width - 20 * 4)/3 )
        self.collectView.collectionViewLayout = layout
        
    }

    @IBAction func actiewSelect(_ sender: Any) {
        
        let btn = sender as! UIButton
        delegate?.starask(_select: btn.tag)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.starask(_select: indexPath.row)
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
