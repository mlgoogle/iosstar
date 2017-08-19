//
//  PLPlayerHelper.swift
//  iOSStar
//
//  Created by mu on 2017/8/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class PLPlayerHelper: NSObject, PLPlayerDelegate {
    static let helper = PLPlayerHelper()
    class func shared() -> PLPlayerHelper{
        return helper
    }
    
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
        let player = PLPlayer.init(url: nil, option: option)
        player?.delegate = helper
        return player!
    }()
    
    lazy var avPlayer: AVPlayer = {
        let player =  AVPlayer.init()
        return player
    }()
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        print(state)
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        if error != nil{
            print(error!)
        }
    }
 
    func avplayNewUrl(_ urlStr: String)  {
        let item = AVPlayerItem.init(url: URL.init(string: urlStr)!)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
    }
}
