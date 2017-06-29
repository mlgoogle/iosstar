//
//  YD_MenuView.swift
//  iOSStar
//
//  Created by J-bb on 17/6/5.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

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
            let width = (kScreenWidth - margin - selfLayout!.minimumInteritemSpacing * (CGFloat(items!.count) - 1) ) / CGFloat(items!.count)
            let size = CGSize(width: (width > 0 ? width : 0), height: 15)
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
