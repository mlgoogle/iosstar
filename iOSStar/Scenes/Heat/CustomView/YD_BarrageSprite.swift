//
//  YD_BarrageSprite.swift
//  BarrageRendererDemo
//
//  Created by J-bb on 17/7/14.
//  Copyright © 2017年 ExBye Inc. All rights reserved.
//

import Foundation
import BarrageRenderer

class YD_BarrageSprite: BarrageWalkSprite {

    override init() {
        super.init()
        trackNumber = 5
        setValue("SpriteView", forKey: "viewClassName")
    }
    func estimateActiveTime() -> CGFloat {
        let x = position.x + view.frame.size.width * 2 + 200

        return x / speed
    }
    

    override func valid(withTime time: TimeInterval) -> Bool {
        return estimateActiveTime() > 0
    }
    override func origin(inBounds rect: CGRect, withSprites sprites: [Any]!) -> CGPoint {

        guard sprites != nil else {
            setValue(CGPoint(x: 0, y: UIScreen.main.bounds.size.width), forKey: "destination")
            return CGPoint(x: UIScreen.main.bounds.size.width, y: 0)
        }
        var synclasticSprites = [YD_BarrageSprite]()
        for data in sprites {
            if let sprite = data as? YD_BarrageSprite {
                if sprite.direction.rawValue == direction.rawValue  {
                    synclasticSprites.append(sprite)
                }
            }
        }
        
        let AVAERAGE_STRATEGY = true
        
        var stripMaxActiveTimes = [Int:CGFloat]()
        
        var stripSpriteNumbers = [Int:Int]()
        let stripNum = Int(trackNumber)
        let stripHeight = rect.size.height / CGFloat(stripNum)
        let overlandStripNum = 1
        let maxActiveTime = size.height / speed
        var availableFrom = 0
        var leastActiveTimeStrip = 0 //最小时间的行
        var leastActiveSpriteStrip = 0 //最小网格的行
        for i in 0...stripNum {
            
            let stripFrom = CGFloat(i) * stripHeight
            var lastDistanceAllOut = true
            for sprite in synclasticSprites {
                let spriteFrom = sprite.origin.y
                if spriteFrom == stripFrom{
                    if stripSpriteNumbers[Int(i)] == nil {
                        stripSpriteNumbers[Int(i)] = 1
                    } else {
                        stripSpriteNumbers[Int(i)] = stripSpriteNumbers[Int(i)]! + 1
                    }
                    let activeTime = sprite.estimateActiveTime()
                    if activeTime > stripMaxActiveTimes[Int(i)] ?? 0.0 {
                        stripMaxActiveTimes[Int(i)] = activeTime
                        let distance = fabs(sprite.position.x - sprite.origin.x)
                        lastDistanceAllOut = distance > sprite.size.width
                    }
                    
                }
                
            }
            
            if stripMaxActiveTimes[Int(i)] ?? 0 > maxActiveTime || !lastDistanceAllOut {
                availableFrom = Int(i) + 1
            } else if ((Int(i) - availableFrom) > overlandStripNum) || ((Int(i) - availableFrom) == overlandStripNum)  {
                break
            }
            if  Int(i) < (stripNum - overlandStripNum) || Int(i) == (stripNum - overlandStripNum) {
             
                if stripMaxActiveTimes[Int(i)] ?? 0 < stripMaxActiveTimes[Int(leastActiveTimeStrip)] ?? 0 {
                    leastActiveTimeStrip = i
                }
                if (stripSpriteNumbers[i] ?? 0 < stripSpriteNumbers[leastActiveSpriteStrip] ?? 0) {
                    leastActiveSpriteStrip = i
                }
            }
            
        }

        if availableFrom > stripNum - overlandStripNum {
            availableFrom = AVAERAGE_STRATEGY ? leastActiveSpriteStrip : leastActiveTimeStrip
        }
        
        var orgin = CGPoint()
        let dey = stripHeight * CGFloat(availableFrom) + UIScreen.main.bounds.size.width
        let dex = rect.origin.x - size.width
        setValue(CGPoint(x: dex, y: dey), forKey: "destination")
        orgin.y = stripHeight * CGFloat(availableFrom)
        orgin.x = rect.origin.x + rect.size.width

        return orgin
    }
}
