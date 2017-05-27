//
//  MenuCollectionView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol BottomItemSelectDelegate {
    func itemDidSelectAtIndex(index:Int)
}

class ImageMenuView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    var delegate:BottomItemSelectDelegate?
    var images:[UIImage]?
    var titles:[String]? {
        didSet{
           collectionView?.reloadData()
        }
    }
    var collectionView:UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    convenience init(frame: CGRect, layout:UICollectionViewFlowLayout?) {
        self.init(frame:frame)
        
        var flowLayout:UICollectionViewFlowLayout?
        if layout == nil {
            flowLayout = UICollectionViewFlowLayout()
            flowLayout!.scrollDirection = .horizontal
            flowLayout!.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)
            flowLayout!.minimumLineSpacing = 24
            flowLayout!.minimumInteritemSpacing = 24
        } else {
            flowLayout = layout
        }
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout!)
        addSubview(collectionView!)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ImageMenuCell.self, forCellWithReuseIdentifier: "ImageMenuCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles == nil ? 0 : titles!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageMenuCell", for: indexPath) as! ImageMenuCell

        cell.setTitle(text: titles![indexPath.row])
      
        cell.setImage(image: images![indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemDidSelectAtIndex(index: indexPath.item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var flowLayout:UICollectionViewFlowLayout?
        flowLayout = UICollectionViewFlowLayout()
        flowLayout!.scrollDirection = .horizontal
        flowLayout!.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10)


        flowLayout?.itemSize = CGSize(width: 40, height: 30)
        
        
        flowLayout!.minimumLineSpacing = (kScreenWidth - 20 - 160) / 3
        flowLayout!.minimumInteritemSpacing =  (kScreenWidth - 20 - 160) / 3
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50), collectionViewLayout: flowLayout!)
        addSubview(collectionView!)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(ImageMenuCell.self, forCellWithReuseIdentifier: "ImageMenuCell")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
