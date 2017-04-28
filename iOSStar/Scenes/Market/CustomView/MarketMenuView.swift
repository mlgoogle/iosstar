//
//  MarketMenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource{

    
    var items:[String]?
    var controllers:[UIViewController]?
    var menuCollectionView:UICollectionView?
    var subViewCollectionView:UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        menuCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        subViewCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        subViewCollectionView?.delegate = self
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)
        
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let layout = UICollectionViewFlowLayout()
        menuCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        subViewCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        subViewCollectionView?.delegate = self
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0 : items!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        return cell
    }
}
