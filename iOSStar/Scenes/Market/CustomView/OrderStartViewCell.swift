//
//  OrderStartViewCell.swift
//  iOSStar
//
//  Created by MONSTER on 2017/5/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit


// MARK: - 自定义按钮
class OrderItemButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView?.contentMode = .center
        self.titleLabel?.textAlignment = .center
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 调整图片的位置
        self.imageView?.centerX = self.width * 0.5
        self.imageView?.y = 0 ;
        
        // 调整文字的位置
        self.titleLabel?.x = 0;
        self.titleLabel?.width = self.width;
        self.titleLabel?.y = (self.imageView?.height)!;
        self.titleLabel?.height = self.height - (self.imageView?.height)!;
    }
}


protocol CustomLayoutDataSource: class {
    func numberOfCols(_ customLayout: CustomLayout) -> Int
    func numberOfRols(_ customLayout: CustomLayout) -> Int
}

// MARK: - 自定义布局
class CustomLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CustomLayoutDataSource?
    
    fileprivate lazy var rols: Int? = {
        return self.dataSource?.numberOfRols(self)
    }()
    
    fileprivate lazy var cols: Int? = {
        return self.dataSource?.numberOfCols(self)
    }()
    
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        //        let page = indexPath.item%(rols*cols) == 0 ? indexPath.item/(rols*cols) : (indexPath.item/(cols*rols) + 1)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = indexPath.item / (cols * rols)//页数
        let cellW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(cols - 1) * minimumInteritemSpacing)) / CGFloat(cols)
        let itemRow = CGFloat((indexPath.item - page*(cols*rols)) / cols)//行数
        let itemCol = CGFloat((indexPath.item - page*(cols*rols)) % cols)//列数
        let cellX = CGFloat(page) * collectionView!.bounds.width + CGFloat(itemCol) * (cellW + 10) + sectionInset.left
        let cellH: CGFloat = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(rols - 1)) * minimumLineSpacing) / CGFloat(rols)
        let cellY = itemRow * (cellH + sectionInset.top) + sectionInset.top
        attribute.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            let attr = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            attrsArray.append(attr!)
        }
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = itemCount%(cols*rols) == 0 ? itemCount/(cols*rols) : itemCount/(cols*rols) + 1
        
        return CGSize(width: CGFloat(page) * collectionView!.bounds.width, height: 0)
    }
}


// MARK: - UICollectionViewCell
class OrderStarItem: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}



// MARK : - UITableViewCell
class OrderStartViewCell: UITableViewCell{

    // 分页控件
    @IBOutlet weak var pageControl: UIPageControl!
    
    // collectionView
    @IBOutlet weak var orderStartCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        setupInit();
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
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
        
        let layout = CustomLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // let flowLayout =   UICollectionViewFlowLayout.init()
        // flowLayout.itemSize = CGSize.init(width: ( UIScreen.main.bounds.size.width - 22 - 34 - 18)/4.0, height: 60)
        // flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        // flowLayout.minimumLineSpacing = 5
        // flowLayout.minimumInteritemSpacing = 5
        self.orderStartCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        
        self.orderStartCollectionView.showsVerticalScrollIndicator = false
        self.orderStartCollectionView.showsHorizontalScrollIndicator = false
        
        self.orderStartCollectionView.isPagingEnabled = true
        
        // self.pageControl.setValue(UIImage(named: "page_yuan"), forKey: "pageImage")
        // self.pageControl.setValue(UIImage(named: "page_tuoyuan"), forKey: "currentPageImage")
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

extension OrderStartViewCell : CustomLayoutDataSource {
    
    func numberOfCols(_ customLayout: CustomLayout) -> Int {
        return 4
    }
    func numberOfRols(_ customLayout: CustomLayout) -> Int {
        return 2
    }
}
