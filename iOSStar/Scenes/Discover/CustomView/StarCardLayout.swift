//
//  StarCardLayout.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
public let ItemWidth:CGFloat = kScreenWidth - 88
public let ItemHeight:CGFloat = kScreenHeight - 44 - 40 - 64
let scaleFactor:CGFloat = 0.5
let activeDistance:CGFloat = kScreenWidth + 400
class StarCardLayout: UICollectionViewFlowLayout {
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func prepare() {
        super.prepare()
   
        itemSize = CGSize(width: ItemWidth, height: ItemHeight)
        sectionInset = UIEdgeInsets(top: 53, left: 50, bottom: 60, right: 50)
        scrollDirection = .horizontal
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {

        return true
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var lastRect = CGRect()
        lastRect.origin = proposedContentOffset
        lastRect.size = collectionView!.frame.size
        let centerX = proposedContentOffset.x + collectionView!.frame.size.width * 0.5
        let array = layoutAttributesForElements(in: lastRect)
        var adjustOffsetX = CGFloat(MAXFLOAT)
        for attrs in array! {
            if (abs(attrs.center.x - centerX)) < abs(adjustOffsetX) {
                adjustOffsetX = attrs.center.x - centerX
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visiableRect = CGRect()
        visiableRect.size = collectionView!.frame.size
        visiableRect.origin = collectionView!.contentOffset
        let array = super.layoutAttributesForElements(in: rect)
        let centerX = collectionView!.contentOffset.x + collectionView!.frame.size.width * 0.5
        for attrs in array! {
            guard visiableRect.intersects(attrs.frame) else {
                continue
            }
            let itemCenterX = attrs.center.x
            let scale = 1 - 0.3 * (abs(itemCenterX - centerX) / activeDistance)
            attrs.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
        return array
    }
    
    
}
