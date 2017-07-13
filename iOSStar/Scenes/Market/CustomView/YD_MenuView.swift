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
    var itemIdentifier = MenuItemCell.className()
    var itemClass:AnyClass = MenuItemCell.self
    //是否宽度为屏幕宽度, 默认不
    var isScreenWidth = false
    //是否选中放大，默认false
    var isSelectZoom = false
    var itemData:[AnyObject]?
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
        selfLayout?.scrollDirection = .horizontal
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), collectionViewLayout: flowLayout!)
        menuCollectionView?.showsHorizontalScrollIndicator = false
        menuCollectionView?.backgroundColor = UIColor.white
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self

        menuCollectionView?.register(itemClass, forCellWithReuseIdentifier: itemIdentifier!)
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

        guard isShowLineView else {
            return
        }
        menuCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let cell = menuCollectionView?.cellForItem(at: indexPath)
        guard cell != nil else {
            return
        }
        menuCollectionView?.reloadData()
        selectIndexPath = indexPath

        UIView.animate(withDuration: 0.3) {
            self.lineView.center = CGPoint(x: (cell?.center.x)!, y: self.lineView.center.y)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData == nil ? 0 : itemData!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemIdentifier!, for: indexPath) as! BaseItemCell
        
        
        cell.setData(data: itemData?[indexPath.row], colorString: indexPath.row == selectIndexPath.item ? AppConst.Color.main : "C2CFD8", isZoom:indexPath.row == selectIndexPath.item ? isSelectZoom : false)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveLineView(indexPath: indexPath)
        delegate?.menuViewDidSelect(indexPath: indexPath)
    }
    
    
    func reloadData() {
        menuCollectionView?.register(itemClass, forCellWithReuseIdentifier: itemIdentifier!)
        menuCollectionView?.reloadData()
        perform(#selector(redressLineViewOrigin), with: nil, afterDelay: 0.5)
    }
    
    func redressLineViewOrigin() {
        let indexPath = IndexPath(item: 0, section: 0)
        
        moveLineView(indexPath: indexPath)
    }
    
}


class BaseItemCell: UICollectionViewCell {
    func setData(data:AnyObject?, colorString:String?, isZoom:Bool) {
 
    }
}
