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
    var selectIndexPath:IndexPath?
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
    lazy var priceTypeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor(hexString: "333333"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("最近价 元/小时", for: .normal)
        return button
    }()
    lazy var priceChangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("涨跌幅", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(hexString: "333333"), for: .normal)
        return button
    }()
    var menuCollectionView:UICollectionView?
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
        setMenuCollectionView()
        setupInfoView()
        setSubCollectionView()

    }
    func setMenuCollectionView() {
        let layout = MenuWidthLayout()
        layout.delegate = self
        layout.scrollDirection = .horizontal
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40), collectionViewLayout: layout)
        menuCollectionView?.backgroundColor = UIColor.white
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        addSubview(infoView)
    }
    func setSubCollectionView() {
        let subViewLayout = UICollectionViewFlowLayout()
        subViewLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight - 90)
        subViewLayout.scrollDirection = .horizontal
        subViewLayout.minimumInteritemSpacing = 0
        subViewLayout.minimumLineSpacing = 0
        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: menuCollectionView!.sd_height + infoView.sd_height, width: kScreenWidth, height: kScreenHeight - 90 - 64), collectionViewLayout: subViewLayout)
        subViewCollectionView?.delegate = self
        subViewCollectionView?.isPagingEnabled = true
        subViewCollectionView?.dataSource = self
        subViewCollectionView?.bounces = false
        subViewCollectionView?.showsVerticalScrollIndicator = false
        subViewCollectionView?.showsHorizontalScrollIndicator = false
        subViewCollectionView?.register(MenuSubViewCell.self, forCellWithReuseIdentifier: "MenuSubViewCell")
        addSubview(subViewCollectionView!)
    }

    func setupInfoView() {
        infoView.frame = CGRect(x: 0, y: menuCollectionView!.sd_height, width: kScreenWidth, height: 50)
        infoView.addSubview(allLabel)
        infoView.addSubview(priceTypeButton)
        infoView.addSubview(priceChangeButton)
        allLabel.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.width.equalTo(30)
            make.height.equalTo(14)
            make.centerY.equalTo(infoView)
        }
        priceTypeButton.snp.makeConstraints { (make) in
            make.center.equalTo(infoView)
        }
        priceChangeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-36)
            make.centerY.equalTo(infoView)
        }
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
