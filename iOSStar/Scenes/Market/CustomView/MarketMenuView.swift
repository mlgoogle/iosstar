//
//  MarketMenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit



class MarketMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MenuViewDelegate,SubViewItemSelectDelegate{

    var delegate:SubViewItemSelectDelegate?
    var items:[String]? {
        didSet{
            menuView?.items = items
            subViewCollectionView?.reloadData()
        }
    }
    var types:[MarketClassifyModel]? {
        didSet {
            let indexPath = IndexPath(item: 0, section: 0)
            menuViewDidSelect(indexPath: indexPath)
            menuView?.selected(index: 0)
        }
    }
    var subViews:[UIView]?
    var selectIndexPath:IndexPath = IndexPath(item: 0, section: 0)
    lazy var infoView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FAFAFA")
        return view
    }()
    
    lazy var allLabel: UILabel = {
        let label = UILabel()
        label.text = "全部"
        label.textColor = UIColor(hexString: "333333")
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var priceTypeButton: UILabel = {
        let label = UILabel()
        label.setAttributeText(text: "最近价 元/秒", firstFont: 14.0, secondFont: 12.0, firstColor: UIColor(hexString: "333333"), secondColor: UIColor(hexString: "333333"), range: NSRange(location: 4, length: 3))
           return label
    }()
    lazy var priceChangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("涨跌幅", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hexString: "333333"), for: .normal)
        return button
    }()
    
    lazy var priceImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "market_price"))
        return imageView
    }()
    
    lazy var changeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "marketlist_down"))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: AppConst.Color.main)
        return view
    }()
    
    var sortType = AppConst.SortType.down
    var menuView:YD_VMenuView?
    var subViewCollectionView:UICollectionView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
     }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    func setupUI() {
//        setMenuCollectionView()
        setupInfoView()
        setSubCollectionView()

    }
    func setMenuCollectionView() {
        menuView = YD_VMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40),layout:nil)
        menuView?.delegate = self
        addSubview(menuView!)
    }
    func setSubCollectionView() {
        let subViewLayout = UICollectionViewFlowLayout()
        subViewLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - 90 - 64)
        subViewLayout.scrollDirection = .horizontal
        subViewLayout.minimumInteritemSpacing = 0
        subViewLayout.minimumLineSpacing = 0
//        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: menuView!.sd_height + infoView.sd_height, width: kScreenWidth, height: kScreenHeight - 90 - 64), collectionViewLayout: subViewLayout)
        
        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: infoView.sd_height, width: kScreenWidth, height: kScreenHeight - 90 - 64), collectionViewLayout: subViewLayout)

        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: infoView.sd_height, width: kScreenWidth, height: kScreenHeight - 90 - 64), collectionViewLayout: subViewLayout)

        subViewCollectionView?.delegate = self
        subViewCollectionView?.isPagingEnabled = true
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.bounces = false
        subViewCollectionView?.showsVerticalScrollIndicator = false
        subViewCollectionView?.showsHorizontalScrollIndicator = false
        subViewCollectionView?.backgroundColor = UIColor.white
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)
    }

    func setupInfoView() {
        addSubview(infoView)
//        infoView.frame = CGRect(x: 0, y: menuView!.sd_height, width: kScreenWidth, height: 50)
        infoView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 50)

        infoView.addSubview(allLabel)
        infoView.addSubview(priceTypeButton)
        infoView.addSubview(priceChangeButton)
        infoView.addSubview(priceImageView)
        infoView.addSubview(changeImageView)
        changeImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-18)
            make.height.equalTo(12)
            make.width.equalTo(9)
            make.centerY.equalTo(infoView)
        }
        priceChangeButton.snp.makeConstraints { (make) in
            make.right.equalTo(changeImageView.snp.left)
            make.centerY.equalTo(changeImageView)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        priceImageView.snp.makeConstraints { (make) in
            make.right.equalTo(priceChangeButton.snp.left).offset(-42)
            make.width.equalTo(9)
            make.height.equalTo(12)
            make.centerY.equalTo(infoView)
        }
        priceTypeButton.snp.makeConstraints { (make) in
            make.right.equalTo(priceImageView.snp.left).offset(-20)
            make.centerY.equalTo(priceImageView)
        }
        
        allLabel.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.width.equalTo(30)
            make.height.equalTo(14)
            make.centerY.equalTo(infoView)
        }

        priceChangeButton.addTarget(self, action: #selector(modfySortType), for: .touchUpInside)
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(modfySortType))
        changeImageView.addGestureRecognizer(tapGes)
        
        
    }
    func modfySortType() {
        if sortType.rawValue == 0 {
            sortType = AppConst.SortType.up
            changeImageView.image = UIImage(named: "marketlist_up")
        } else {
            sortType = AppConst.SortType.down
            changeImageView.image = UIImage(named: "marketlist_down")
        }
        requestDataWithIndexPath()
        
    }
    func requestDataWithIndexPath() {
        let cell = subViewCollectionView?.cellForItem(at: selectIndexPath) as? MenuSubViewCell
//        cell?.requestStarList(type: selectIndexPath.row, sortType:sortType)
        cell?.requestStarList(type: 1, sortType:sortType)
    }

    func menuViewDidSelect(indexPath: IndexPath) {
        subViewCollectionView?.scrollToItem(at: indexPath, at: .left, animated: true)
        selectIndexPath = indexPath
        perform(#selector(requestDataWithIndexPath), with: nil, afterDelay: 0.5)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0 : items!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuSubViewCell", for: indexPath) as! MenuSubViewCell
        cell.delegate = self
        return cell
    }
    func selectItem(starModel:MarketListStarModel) {
        
        delegate?.selectItem(starModel: starModel)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == subViewCollectionView {
            let index = Int(scrollView.contentOffset.x / kScreenWidth)
            let indexPath = IndexPath(item: index, section: 0)
            menuView?.selected(index: index)
            selectIndexPath = indexPath
            requestDataWithIndexPath()
        }
    }
}



