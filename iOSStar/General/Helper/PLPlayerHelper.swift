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
    var resultBlock: CompleteBlock?
    var count = 0
    var resultCountDown: CompleteBlock?
    class func shared() -> PLPlayerHelper{
        
        return helper
    }
    func doChanggeStatus(_ timecount : Int) {
         count =  timecount
        if count == 4{
            return
        }
        if (count == 3  ){
            count = 0
            
        }
         count = count + 1
        self.perform(#selector(changeImg), with: self, afterDelay: 0.5)
        
    }
    func changeImg(){
        if count == 4{
            return
        }
        if self.resultCountDown != nil{
        self.doChanggeStatus(count)
            
        self.resultCountDown!(count as AnyObject)
        }
        
    }
    lazy var player: PLPlayer = {
        let option = PLPlayerOption.default()
     
        let player = PLPlayer.init(url: nil, option: option)
//       PLPlayerHelper.shared().play(isRecord: false)
        player?.delegate = helper
        return player!
    }()
    
    lazy var avPlayer: AVPlayer = {
        let player =  AVPlayer.init()
        return player
    }()
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        if self.resultBlock != nil{
         self.resultBlock!(state as AnyObject)
        }
        print(state.hashValue)
    }
    
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
       
        if error != nil{
            print(error!)
        }
    }
 
    func avplayNewUrl(_ urlStr: String)  {
        let item = AVPlayerItem.init(url: URL(string:ShareDataModel.share().qiniuHeader +   urlStr)!)
        avPlayer.replaceCurrentItem(with: item)
        avPlayer.play()
        
    }
    func play(isRecord:Bool){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let cat = isRecord ? AVAudioSessionCategoryPlayAndRecord : AVAudioSessionCategoryPlayback
            try audioSession.setCategory(cat)
        } catch {
            
        }
    }
}
