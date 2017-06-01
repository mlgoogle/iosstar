//
//  YD_SwipHeaderView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class YD_DynamicItem: NSObject {
    
}

class YD_SwipHeaderView: UIView {

    var panGes:UIPanGestureRecognizer?
    var animator:UIDynamicAnimator?
    var decelerationBehavior:UIDynamicItemBehavior?
    var springBehavior:UIAttachmentBehavior?
    
    var newFrame:CGRect?
    
    
    var tracking:Bool?
    var dragging:Bool?
    var decelerating:Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addGesture() {
        panGes = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGestureRecognizer:)))
        addGestureRecognizer(panGes!)
        panGes?.addObserver(self, forKeyPath: "state", options: .new, context: nil)

        animator = UIDynamicAnimator(referenceView: self)
        animator?.delegate = self
    }
    
    func handlePanGesture(panGestureRecognizer:UIPanGestureRecognizer) {
        
        switch panGestureRecognizer.state {
        case .began:
            endDecelerating()
            tracking = true
        case .changed:
            tracking = true
            dragging = true
            _ = frame
            
            
        case .ended:
            break
            
        default:
            break
        }
    }

    func endDecelerating() {
        animator?.removeAllBehaviors()
        decelerationBehavior = nil
        springBehavior = nil
        
    }
    
    func rubberBandRate(offset:CGFloat)->CGFloat {
        
        let constant:CGFloat = 0.15
        let dimension:CGFloat = 10.0
        let startRate:CGFloat = 0.85
        let result = dimension * startRate / (dimension + constant * fabs(offset))
        
        return result
    }
    
    deinit {
        panGes?.removeObserver(self, forKeyPath: "state")
    }
}
extension YD_SwipHeaderView:UIDynamicAnimatorDelegate {
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        decelerating = true
    }
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        decelerating = false
    }
}
