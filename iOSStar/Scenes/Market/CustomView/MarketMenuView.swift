//
//  MarketMenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, MenuWidthLayoutDelegate{

    
    var items:[String]? {
        didSet{
            menuCollectionView?.reloadData()
            subViewCollectionView?.reloadData()
        }
    }
    var menuCollectionView:UICollectionView?
    var subViewCollectionView:UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = MenuWidthLayout()
        layout.delegate = self
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40), collectionViewLayout: layout)
        menuCollectionView?.backgroundColor = UIColor.white
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        
        let subViewLayout = UICollectionViewFlowLayout()
        subViewLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - 40)
        subViewLayout.scrollDirection = .horizontal
        subViewLayout.minimumInteritemSpacing = 0
        subViewLayout.minimumLineSpacing = 0
        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight - 40), collectionViewLayout: subViewLayout)
        subViewCollectionView?.delegate = self
        subViewCollectionView?.isPagingEnabled = true
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.bounces = false
        subViewCollectionView?.showsVerticalScrollIndicator = false
        subViewCollectionView?.showsHorizontalScrollIndicator = false
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)
        
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 40)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40), collectionViewLayout: layout)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        
        let subViewLayout = UICollectionViewFlowLayout()
        subViewLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - 40)
        subViewLayout.scrollDirection = .horizontal
        subViewLayout.minimumInteritemSpacing = 0
        subViewLayout.minimumLineSpacing = 0
        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight - 40), collectionViewLayout: subViewLayout)
        subViewCollectionView?.delegate = self
        subViewCollectionView?.isPagingEnabled = true
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.bounces = false
        subViewCollectionView?.showsVerticalScrollIndicator = false
        subViewCollectionView?.showsHorizontalScrollIndicator = false
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0 : items!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == subViewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSubViewCell", for: indexPath)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        cell.setTitle(title: items![indexPath.row])
        return cell
    }
    func autoLayout(layout:MenuWidthLayout, atIndexPath:IndexPath)->Float {
        
        let title = items?[atIndexPath.row]
        guard title != nil else {
            return 0
        }
        
        return Float((title?.boundingRectWithSize(CGSize(width: 0, height: 20), font: UIFont.systemFont(ofSize: 16)).size.width)!)
    }
    
}
