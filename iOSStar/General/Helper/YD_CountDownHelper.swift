//
//  YD_CountDownHelper.swift
//  TestCountDown
//
//  Created by J-bb on 17/2/9.
//  Copyright © 2017年 J-bb. All rights reserved.
//

import UIKit

class YD_CountDownHelper: NSObject {

    
    static let shared = YD_CountDownHelper()
    var timer:CADisplayLink?
    private var isCountDown = false
    private override init() {}
    var finishBlock: CompleteBlock?

    func countDown() {

    }
    

    
    func getResidueCount(closeTime:Int) -> Int {
        let diffTime = 0
        return  closeTime - Int(NSDate().timeIntervalSince1970) - diffTime
    }
    func getTextWithStartTime(closeTime:Int) -> String{
        
        let count = getResidueCount(closeTime: closeTime)
        
        return getTextWithTimeCount(timeCount: count)
    }
    func getTextWithTimeCount(timeCount:Int) -> String {
        
        let hours = timeCount / 3600
        let minutes = (timeCount % 3600) / 60
        let seconds = timeCount % 60
        return String(format: "%.2d:%.2d:%.2ds", hours, minutes, seconds)
    }
    
    
    func resetDataSource() {

//        table?.dataArray = DealModel.getAllPositionModel()
//        table?.reloadData()
//        if table?.dataArray?.count == 0 {
//            timer?.invalidate()
//        }
        if let finish = finishBlock{
            finish(nil)
        }

    }
    func reStart() {

        resetDataSource()
        if timer != nil {
            start()
        }
    }
    
    func start() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = CADisplayLink(target: self, selector: #selector(countDown))
        timer?.frameInterval = 60
        timer?.add(to: RunLoop.current, forMode: .commonModes)
        isCountDown = true
    }
    
    func pause() {
        isCountDown = false
        timer?.invalidate()
    }
    func stop() {
        isCountDown = false
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
}
