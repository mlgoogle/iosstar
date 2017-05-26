//
//  OrderStarCollectView.swift
//  iOSStar
//
//  Created by sum on 2017/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//
//
//import UIKit
//
//
//
//// MARK: - UICollectionView
//class OrderStarCollectView: UICollectionView {
//
//    required init?(coder aDecoder: NSCoder) {
//        
//        super.init(coder: aDecoder)
//        
//        setupInit()
//    }
//}
//
//// MARK: - 初始化
//extension OrderStarCollectView {
//    
//    func setupInit()  {
//        
//        self.delegate = self
//        self.dataSource = self
//        
//        // 布局
//        let flowLayout =   UICollectionViewFlowLayout.init()
//        flowLayout.itemSize = CGSize.init(width: ( UIScreen.main.bounds.size.width - 22 - 34 - 18)/4.0, height: 60)
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//        flowLayout.minimumLineSpacing = 5
//        flowLayout.minimumInteritemSpacing = 5
//        collectionViewLayout = flowLayout
//        flowLayout.scrollDirection = .horizontal
//    
//        self.showsVerticalScrollIndicator = false
//        self.showsHorizontalScrollIndicator = false
//        
//        self.isPagingEnabled = true
//        
//    }
//    
//}
//
//// MARK: - UICollectionView 数据源 AND 代理
//extension OrderStarCollectView : UICollectionViewDataSource,UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 30
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStarItem", for: indexPath)
//        
//        // 随机颜色测试
//        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
//        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
//        
//        cell.backgroundColor = colorRun
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        print("点击了\(indexPath.row)");
//    }
//}
//
