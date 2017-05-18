//
//  OrderStarCollectView.swift
//  iOSStar
//
//  Created by sum on 2017/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class OrderStarItem: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(object: AnyObject, hiddle: Bool) {
        
    }
}
class OrderStarCollectView: UICollectionView , UICollectionViewDelegate, UICollectionViewDataSource{

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        let flowLayout =   UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: ( UIScreen.main.bounds.size.width - 22 - 34 - 18)/4.0, height: 60)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false

        
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        collectionViewLayout = flowLayout
        flowLayout.scrollDirection = .horizontal
        self.isPagingEnabled = true
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStarItem", for: indexPath)
//        cell.backgroundColor = UIColor.red
        return cell
        
    }

}
