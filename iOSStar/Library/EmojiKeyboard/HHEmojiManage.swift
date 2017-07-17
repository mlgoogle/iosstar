//
//  HHEmojiManage.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation


class HHEmojiManage:NSObject {
    
    class func getEmojiAll() -> NSDictionary{
        if let path = Bundle.main.path(forResource: "EmojisList", ofType: "plist"){
            if let dic = NSDictionary(contentsOfFile: path as String){
                return dic
            }
        }
       return NSDictionary()
    }
    
    class func getYEmoji() -> NSArray{
        if let bundlePath = Bundle.main.path(forResource: "NIMKitEmoticon", ofType: "bundle"){
            if let path = Bundle.init(path: bundlePath)?.path(forResource: "emoji", ofType: "plist", inDirectory: "Emoji"){
                if let arr  = NSArray.init(contentsOfFile: path){
                    if let dic = arr[0] as? NSDictionary{
                        if let emojiArray = dic["data"] as? NSArray{
                            return emojiArray
                        }
                    }
                }

            }

        }
        return NSArray()
    }
    
}
