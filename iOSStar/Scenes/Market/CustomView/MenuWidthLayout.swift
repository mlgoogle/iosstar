//
//  SkillWidthLayout.swift
//  HappyTravel
//
//  Created by J-bb on 16/11/5.
//  Copyright © 2016年 陈奕涛. All rights reserved.
//

import UIKit
protocol MenuWidthLayoutDelegate : NSObjectProtocol {

    func autoLayout(layout:MenuWidthLayout, atIndexPath:IndexPath)->Float
}

class MenuWidthLayout: UICollectionViewFlowLayout {

    
    /**
     默认属性 可外部修改
     */

    var columnMargin:CGFloat = 0.0
    var rowMargin:CGFloat = 6.0
    var menuSectionInset = UIEdgeInsetsMake(16.0, 20.0, 16.0, 20.0)
    var itemHeight:CGFloat = 24.0
    /*
     需实现代理方法获取width 
     */
    weak var delegate:MenuWidthLayoutDelegate?

    
   private var currentX:Float = 0.0
   private var currentY:Float = 0.0
   private var currentMaxX:Float = 0.0
   private var attributedAry:Array<UICollectionViewLayoutAttributes>?
    
    
    
    override init() {
        super.init()
        
         columnMargin = 20.0
         rowMargin = 10.0
         menuSectionInset = UIEdgeInsetsMake(16.0, 23.0, 16.0, 20.0)
         itemHeight = 24.0
         attributedAry =  Array()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
        重写layout
     */
    
    
    override func prepare() {
        currentX = Float(menuSectionInset.left)
        currentY = Float(menuSectionInset.top)
        currentMaxX = currentX
        attributedAry?.removeAll()
        if let count = collectionView?.numberOfItems(inSection: 0) {
            for index in 0..<count {
                
                let atr = layoutAttributesForItem(at: IndexPath(item: index, section: 0))
                
                attributedAry?.append(atr!)
                
            }
        }

    }
    
    /**
     
     判断是否需要重新计算layout
     - parameter newBounds:
     
     - returns:
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {

        let oldBounds = collectionView?.bounds
        if oldBounds!.width != newBounds.width {
            
            return true
        } else {
            return false
        }
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let itemW = delegate!.autoLayout(layout: self, atIndexPath:indexPath)
        let atr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        atr.frame = CGRect(x: CGFloat(currentX), y:  CGFloat(menuSectionInset.top), width: CGFloat(itemW), height: itemHeight)
            currentX = currentX + itemW + Float(columnMargin)
        return atr
    }

    

    
    /**
     
     layout数据源
     - parameter rect:
     
     - returns:
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributedAry
    }
    
}

