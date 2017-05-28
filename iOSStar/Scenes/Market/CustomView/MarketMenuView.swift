//
//  MarketMenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/4/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
    
    func menuViewDidSelect(indexPath:IndexPath)
}
class YD_VMenuView: UIView , UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //item宽度是否为整个屏幕宽度均分。默认false，刷新数据前配置
    var isShowLineView = true {
        didSet{
            lineView.isHidden = true
        }
    }
    //是否宽度为屏幕宽度
    var isScreenWidth = false
    //是否选中放大，默认false
    var isSelectZoom = false
    var items:[String]?
    private var selfLayout:UICollectionViewFlowLayout?
    private var selectIndexPath:IndexPath = IndexPath(item: 0, section: 0)
    var menuCollectionView:UICollectionView?
    var delegate:MenuViewDelegate?
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: AppConst.Color.main)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame:CGRect,layout:UICollectionViewFlowLayout?) {
        self.init(frame:frame)
        setMenuCollectionView(layout:layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setMenuCollectionView(layout: nil)
    }
    func setMenuCollectionView(layout:UICollectionViewFlowLayout?) {
        
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
        selfLayout = flowLayout
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: flowLayout!)
        menuCollectionView?.showsHorizontalScrollIndicator = false
        menuCollectionView?.backgroundColor = UIColor.white
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuCollectionView?.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        addSubview(menuCollectionView!)
        lineView.frame = CGRect(x: flowLayout!.itemSize.width / 2 + flowLayout!.sectionInset.left, y: menuCollectionView!.sd_height - 3, width: 20, height: 3)
        menuCollectionView?.addSubview(lineView)
        menuCollectionView?.bringSubview(toFront: lineView)
    }
    

    
    //外部调用调整选中item
    public func selected(index:Int) {
        let indexPath = IndexPath(item: index, section: 0)
        moveLineView(indexPath: indexPath)
    }
    private func moveLineView(indexPath:IndexPath) {
        menuCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let cell = menuCollectionView?.cellForItem(at: indexPath)
        guard cell != nil else {
            return
        }
        menuCollectionView?.reloadData()
        selectIndexPath = indexPath
        guard isShowLineView else {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.lineView.center = CGPoint(x: (cell?.center.x)!, y: self.lineView.center.y)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items == nil ? 0 : items!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell

        cell.setTitle(title: items![indexPath.item], colorString: indexPath.row == selectIndexPath.item ? AppConst.Color.main : "C2CFD8", isZoom:indexPath.row == selectIndexPath.item ? isSelectZoom : false)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveLineView(indexPath: indexPath)
        delegate?.menuViewDidSelect(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return selfLayout!.minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return selfLayout!.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isScreenWidth {
            let margin = selfLayout!.sectionInset.left + selfLayout!.sectionInset.right + frame.origin.x
            let size = CGSize(width: (kScreenWidth - margin - selfLayout!.minimumInteritemSpacing * (CGFloat(items!.count) - 1) ) / CGFloat(items!.count), height: 15)
            print(size)
            return size
        } else {
            let title = items?[indexPath.row]
            guard title != nil else {
                return CGSize(width: 0, height: 0)
            }
            return CGSize(width: (title?.boundingRectWithSize(CGSize(width: 0, height: 20), font: UIFont.systemFont(ofSize: 16)).size.width)!, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return selfLayout!.sectionInset
    }
    
    func reloadData() {
        menuCollectionView?.reloadData()
        
        perform(#selector(redressLineViewOrigin), with: nil, afterDelay: 0.5)
    }
    
    func redressLineViewOrigin() {
        menuCollectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}

class MarketMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MenuViewDelegate,SubViewItemSelectDelegate{

    
    var items:[String]? {
        didSet{
            menuView?.items = items
            menuView?.selected(index: 1)
            subViewCollectionView?.reloadData()
        }
    }
    var types:[MarketClassifyModel]? {
        didSet {
            let indexPath = IndexPath(item: 1, section: 0)
            menuViewDidSelect(indexPath: indexPath)
            menuView?.selected(index: 1)
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
        let imageView = UIImageView(image: UIImage(named: "market_price"))
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: AppConst.Color.main)
        return view
    }()
    var menuView:YD_VMenuView?
    var subViewCollectionView:UICollectionView?
    var navigationController:UINavigationController?
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
        subViewCollectionView = UICollectionView(frame: CGRect(x: 0, y: menuView!.sd_height + infoView.sd_height, width: kScreenWidth, height: kScreenHeight - 90 - 64), collectionViewLayout: subViewLayout)
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
        addSubview(infoView)
        infoView.frame = CGRect(x: 0, y: menuView!.sd_height, width: kScreenWidth, height: 50)
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
            make.right.equalTo(changeImageView.snp.left).offset(-9)
            make.centerY.equalTo(changeImageView)
            make.width.equalTo(43)
            make.height.equalTo(15)
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

    }
    func requestDataWithIndexPath() {

        guard types != nil else {
            return
        }
        let cell = subViewCollectionView?.cellForItem(at: selectIndexPath) as? MenuSubViewCell
        let model = types![selectIndexPath.item]
        cell?.requestStarList(type: model.type)
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
        let storyBoard = UIStoryboard(name: "Market", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MarketDetail") as! MarketDetailViewController
        vc.starModel = starModel
        navigationController?.pushViewController(vc, animated: true)
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



