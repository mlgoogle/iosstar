//
//  UIButton+Extension.swift
//  iOSStar
//
//  Created by mu on 2017/6/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation


extension UIButton{
    private struct controlKeys{
        static var acceptEventInterval = "controlInterval"
        static var acceptEventTime = "controlTime"
    }
    var controlInterval: TimeInterval{
        get{
            if let interval = objc_getAssociatedObject(self, &controlKeys.acceptEventInterval) as? TimeInterval{
                return interval
            }
            return 1.0
        }
        set{
            objc_setAssociatedObject(self, &controlKeys.acceptEventInterval, newValue as TimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var controlTime: TimeInterval{
        get{
            if let time = objc_getAssociatedObject(self, &controlKeys.acceptEventTime) as? TimeInterval{
                return time
            }
            return 3.0
        }
        set{
            objc_setAssociatedObject(self, &controlKeys.acceptEventTime, newValue as TimeInterval, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open class func initialize(){
        return
        if self == UIButton.self {
            let sysSel = #selector(UIButton.sendAction(_:to:for:))
            let sysMethod: Method = class_getInstanceMethod(self, sysSel)
            let oldSel = #selector(UIButton.sendAction(_:to:for:))
            let oldMethod: Method = class_getInstanceMethod(self, sysSel)
            let newSel = #selector(UIButton.y_sendAction(_:to:for:))
            let newMethod: Method = class_getInstanceMethod(self, newSel)
            method_exchangeImplementations(sysMethod, newMethod)
            return
        }
    }
    
    func y_sendAction(_ action: Selector, to target: AnyObject?, for event: UIEvent?)  {
        if self.classForCoder != UIButton.self{
            
//            self.sendAction(action, to: target, for: event)
            
            return
        }
        
        if ShareDataModel.share().controlSwitch == false{
            NotificationCenter.default.post(name: Notification.Name.init(rawValue: AppConst.NoticeKey.frozeUser.rawValue), object: nil, userInfo: nil)
            return
        }
        
        if NSDate().timeIntervalSince1970 - self.controlTime < self.controlInterval{
            return
        }
        
        self.controlTime = NSDate().timeIntervalSince1970
        
        y_sendAction(action, to: target, for:event)
    }
}
