//
//  OrderStartViewCell.swift
//  iOSStar
//
//  Created by MONSTER on 2017/5/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewCell
class OrderStarItem: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(object: AnyObject, hiddle: Bool) {
        
    }
}

class OrderStartViewCell: UITableViewCell{

    // 分页控件
    @IBOutlet weak var pageControl: UIPageControl!
    
    // collectionView
    @IBOutlet weak var orderStartCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupInit();
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }

}

// MRAK: -布局UI
extension OrderStartViewCell {
    
    func setupInit() {
        
        orderStartCollectionView.delegate = self
        self.orderStartCollectionView.dataSource = self
        
        let flowLayout =   UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize.init(width: ( UIScreen.main.bounds.size.width - 22 - 34 - 18)/4.0, height: 60)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        self.orderStartCollectionView.collectionViewLayout = flowLayout
        flowLayout.scrollDirection = .horizontal
        
        self.orderStartCollectionView.showsVerticalScrollIndicator = false
        self.orderStartCollectionView.showsHorizontalScrollIndicator = false
        
        self.orderStartCollectionView.isPagingEnabled = true
    }
    
}

// MRAK: -UICollectionView  DataSource AND Delegate
extension OrderStartViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let pageNum = (30 - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderStarItem", for: indexPath)
        
        // 随机颜色测试
//        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
//        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
//        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
//        
//        cell.backgroundColor = colorRun
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("点击了\(indexPath.row)");
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
