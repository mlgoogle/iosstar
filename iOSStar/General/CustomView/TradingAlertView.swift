//
//  TradingAlertView.swift
//  About
//
//  Created by MONSTER on 2017/6/15.
//  Copyright © 2017年 MONSTER. All rights reserved.
//

import UIKit
import Foundation

// 弹窗
class TradingAlertView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titileLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var detailLabel :UILabel!
    
    var isShow : Bool = false
    
    var messageAction : (() -> Void)? = nil
    
    // 记录次数
    // var recordNum : Int = 0
    
    // 默认高度
    var defaultHeight :CGFloat = 110
    
    var str : String? {
        didSet{
            // 计算高度
            detailLabel.text = str
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            paragraphStyle.alignment = .left
            let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14.0),
                              NSParagraphStyleAttributeName: paragraphStyle,
                              NSForegroundColorAttributeName:UIColor.colorFromRGB(0x666666)]
            let attributedString  = NSMutableAttributedString(string: str!, attributes: attributes)
            let attrs = [NSForegroundColorAttributeName:UIColor.colorFromRGB(0x8D0809)]
            attributedString.addAttributes(attrs, range: NSMakeRange(NSString(string:str!).length - 5, 4))
            detailLabel.attributedText = attributedString
            
            // 字体宽度
            let textWidth  = self.frame.size.width - 50
            // 高度
            let textHeight = detailLabel.attributedText?.boundingRect(with: CGSize(width:textWidth ,height:1000000),
                                                            options: .usesLineFragmentOrigin,
                                                            context: nil).size.height
//            let tempHeight = textHeight! - 30
//            self.defaultHeight += tempHeight
            self.defaultHeight = textHeight!
            self.frame = CGRect(x: 0,
                                y: -self.defaultHeight,
                                width: UIScreen.main.bounds.size.width,
                                height: self.defaultHeight)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect(x: 0,
                            y: -self.defaultHeight,
                            width: UIScreen.main.bounds.size.width,
                            height: self.defaultHeight)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.15
        
        // 手势点击
        let tap = UITapGestureRecognizer(target: self, action: #selector(messageClick))
        self.addGestureRecognizer(tap)
        
        // 清扫点击
        let swipe = UIScreenEdgePanGestureRecognizer(target:self, action:#selector(topSwipe(_:)))
        swipe.edges = UIRectEdge.top
        self.addGestureRecognizer(swipe)
    }
    
    // MARK: - Action事件传出去
    func messageClick() {
        
        if self.messageAction != nil {
            self.messageAction!()
            self.disMissAlertView()
        }
    }
    
    // 貌似没什么作用
    func topSwipe(_ recognizer:UIScreenEdgePanGestureRecognizer) {
        
        print("left edgeswipe ok")
        _=recognizer.location(in: self)
        self.disMissAlertView()
    }
    
    // 显示
    func showAlertView() {
        self.removeFromSuperview()
        
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.setStatusBarHidden(true, with: .fade)
        isShow = true
        // recordNum += 1
        ShareDataModel.share().isShowInWindows = true
        UIView.animate(withDuration: 0.25, animations: { 
            self.frame = CGRect(x: 0,
                                y: 0,
                                width: UIScreen.main.bounds.size.width,
                                height: self.defaultHeight)
        }) { (Bool) in
         
//            self.delay(2, task: {
//                
//                self.disMissAlertView()
//            })
            self.delay(2) {
                 self.disMissAlertView()
             }
        }
        
    }
    
    // hide
    func disMissAlertView() {
        UIApplication.shared.setStatusBarHidden(false, with: .fade)
        isShow = false
        // recordNum -= 1
        ShareDataModel.share().isShowInWindows = false
        UIView.animate(withDuration: 0.25, animations: {
            self.frame = CGRect(x: 0,
                                y: -self.defaultHeight,
                                width: UIScreen.main.bounds.size.width,
                                height: self.defaultHeight)
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
    
    // 是否显示在窗口
    func isShowingOnKeyWindow () -> Bool{
        
        let keyWindow = UIApplication.shared.keyWindow
        
        let newFrames = keyWindow?.convert(self.frame, to: self.superview)
        let winBounds = keyWindow?.bounds
        // 主窗口的bounds 是否有重叠
        let intersects = newFrames?.intersects(winBounds!)
        
        return !self.isHidden && self.alpha > 0.01 && self.window! == keyWindow && intersects!
        
    }
    
    
    // 延迟加载
    typealias Task = (_ cancel : Bool) -> Void
    func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
        
        func dispatch_later(block: @escaping ()->()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: Task?
        
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }
}



