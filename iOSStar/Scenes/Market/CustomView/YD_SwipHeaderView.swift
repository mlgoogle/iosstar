//
//  YD_SwipHeaderView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/22.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit


protocol YD_SwipHeaderDelegate {
    func minHeaderViewFrameOrgin() -> CGPoint
    func maxHeaderViewFrameOrgin() -> CGPoint
}

class YD_DynamicItem: NSObject, UIDynamicItem {
 
    var center: CGPoint = CGPoint(x: 0, y: 0)
    var bounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var transform: CGAffineTransform = CGAffineTransform()
    
    override init() {
        super.init()
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
    }
    
}

class YD_SwipHeaderView: UIView {

    var panGes:UIPanGestureRecognizer?
    var animator:UIDynamicAnimator?
    var decelerationBehavior:UIDynamicItemBehavior?
    var springBehavior:UIAttachmentBehavior?
    
     var newFrame:CGRect?
    
    lazy var dynamicItem:YD_DynamicItem = {
        let item = YD_DynamicItem()
        
        return item
    }()
    var delegate:YD_SwipHeaderDelegate?
    var tracking:Bool?
    var dragging:Bool?
    var decelerating:Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGesture()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGesture()
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
            var frame = self.frame
            let translation = panGestureRecognizer.translation(in: superview)
            let newFrameOrginY = frame.origin.y + translation.y
            let minFrameOrigin = minFrameOrgin()
            let maxFrameOrigin = maxFrameOrgin()
            
            let minFrameOrginY = minFrameOrigin.y
            let maxFrameOrginY = maxFrameOrigin.y
        
            
            let constrainedOrignY = fmax(minFrameOrginY, maxFrameOrginY)
        
            let rubberRate = rubberBandRate(offset: newFrameOrginY - constrainedOrignY)
            
            frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y + translation.y * rubberRate)
            
            newFrame = frame
            panGestureRecognizer.setTranslation(CGPoint(x: translation.x, y: 0), in: superview)
        case .ended:
            tracking = false
            dragging = false
            var velocity = panGestureRecognizer.velocity(in: self)
            velocity.x = 0

            decelerationBehavior = UIDynamicItemBehavior(items: [dynamicItem])
            decelerationBehavior?.addLinearVelocity(velocity, for: dynamicItem)
            decelerationBehavior?.resistance = 2
            decelerationBehavior?.action = {[weak self] in
                var center = self?.dynamicItem.center
                center?.x = (self?.frame.origin.x)!
                var frame = self?.frame
                frame?.origin = center!
                self?.newFrame = frame
            }
            animator?.addBehavior(decelerationBehavior!)
        default:
            tracking = false
            dragging = false
        }
        

    }

    func minFrameOrgin() -> CGPoint {
        var orgin = CGPoint(x: 0, y: 0)
        
        if delegate != nil {
            orgin = delegate!.minHeaderViewFrameOrgin()
        }
        return orgin
    }
    func maxFrameOrgin() -> CGPoint {
        var orgin = CGPoint(x: 0, y: 0)
        
        if delegate != nil {
            orgin = delegate!.maxHeaderViewFrameOrgin()
        }
        return orgin
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
    
    func setNewFrames(frame:CGRect) {
        self.frame = frame
        let minFrameOrgin = self.minFrameOrgin()
        let maxFrameOrgin = self.maxFrameOrgin()
        let outsideFrameMinimum = frame.origin.y < minFrameOrgin.y
        let outsideFrameMaximum = frame.origin.y > maxFrameOrgin.y
        if decelerationBehavior != nil && springBehavior == nil {
            if outsideFrameMinimum || outsideFrameMaximum {
                var target = frame.origin
                if outsideFrameMinimum {
                    target.x = fmax(target.x, minFrameOrgin.x)
                    target.y = fmax(target.y, minFrameOrgin.y)
            
                } else {
                    target.x = fmin(target.x, minFrameOrgin.x)
                    target.y = fmin(target.y, minFrameOrgin.y)
                }
                
                springBehavior = UIAttachmentBehavior(item: dynamicItem, attachedToAnchor: target)
                springBehavior?.length = 0
                springBehavior?.damping = 1
                springBehavior?.frequency = 2
                animator?.addBehavior(springBehavior!)
            }
            
        }
        
    }
    
    deinit {
        panGes?.removeObserver(self, forKeyPath: "state")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        self.endDecelerating()
        if bounds.contains(point) {
            return self
        }
        return view
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
