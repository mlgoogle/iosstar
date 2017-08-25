
//
//  TakeMovieVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import PLShortVideoKit
import Qiniu
class TakeMovieVC: UIViewController ,PLShortVideoRecorderDelegate ,PLShortVideoUploaderDelegate ,PLPlayerDelegate{
    
    
    var didTap = false
    var index  = 1
    var shortVideoRecorder : PLShortVideoRecorder?
    var resultBlock: CompleteBlock?
    var filePath : URL?
    var player : PLPlayer?
    var canle : Bool = false
    //设置按住松开的view
    lazy var ProgressView  :  OProgressView = {
        let  Progress = OProgressView.init(frame: CGRect.init(x: self.view.center.x - 50, y: kScreenHeight - 120, width: 100, height: 100))
        return Progress
    }()
    //确定按钮
    lazy var showStartImg : UIImageView = {
        let sureBtn = UIImageView.init()
        sureBtn.frame = CGRect.init(x: 0 , y: 0 , width: kScreenWidth, height: kScreenHeight)
        
        sureBtn.isHidden = true
        return sureBtn
    }()
    //showView
    lazy var bgView : UIView = {
        let stopView = UIView.init(frame: self.view.frame)
        stopView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        return stopView
    }()
    //切换摄像头
    lazy var switchBtn : UIButton = {
        let resetBtn = UIButton.init(type: .custom)
        resetBtn.frame = CGRect.init(x: 30, y: 30, width: 60, height: 60)
        resetBtn.setImage(UIImage.init(named: "frontBack"), for: .normal)
        resetBtn.addTarget(self , action: #selector(switchbtn), for: .touchUpInside)
        return resetBtn
    }()
    
    //暂停按钮
    lazy var stopBtn: UIButton = {
        let stop = UIButton.init(type: .custom)
        stop.frame = CGRect.init(x: self.view.center.x - 30, y: self.view.center.y - 30, width: 60, height: 60)
        //        stop.setImage(UIImage.init(named: "frontBack"), for: .normal)
        stop.backgroundColor = UIColor.red
        stop.isHidden = true
        stop.addTarget(self , action: #selector(doplay), for: .touchUpInside)
        return stop
    }()
    
    //退出按钮
    lazy var closeBtn: UIButton = {
        let resetBtn = UIButton.init(type: .custom)
        resetBtn.frame = CGRect.init(x: kScreenWidth - 100, y: 30, width: 25, height: 25)
        resetBtn.setImage(UIImage.init(named: "close"), for: .normal)
        resetBtn.addTarget(self , action: #selector(exit), for: .touchUpInside)
        return resetBtn
    }()
    
    //重置按钮
    lazy var resetBtn : UIButton = {
        let resetBtn = UIButton.init(type: .custom)
        resetBtn.frame = CGRect.init(x: 20, y: kScreenHeight - 100, width: 60, height: 60)
        resetBtn.setImage(UIImage.init(named: "videoBack"), for: .normal)
        resetBtn.addTarget(self , action: #selector(didreset), for: .touchUpInside)
        resetBtn.isHidden = true
        return resetBtn
    }()
    
    //确定按钮
    lazy var sureBtn : UIButton = {
        let sureBtn = UIButton.init(type: .custom)
        sureBtn.frame = CGRect.init(x: kScreenWidth - 100, y: kScreenHeight - 100, width: 60, height: 60)
        sureBtn.setImage(UIImage.init(named: "videoSure"), for: .normal)
        sureBtn.isHidden = true
        sureBtn.addTarget(self , action: #selector(didsure), for: .touchUpInside)
        return sureBtn
    }()
    
    // 录制视频的video
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViedeo()
        initView()
        tap()
        
        
    }
    func initView(){
        self.view.addSubview(showStartImg)
        self.view.addSubview(resetBtn)
        self.view.addSubview(stopBtn)
        self.view.addSubview(closeBtn)
        self.view.addSubview(switchBtn)
        self.view.addSubview(sureBtn)
        self.view.addSubview(ProgressView)
        //
    }
    //MARK: -配置段视频链接
    func configViedeo(){
        let videoConfiguration = PLSVideoConfiguration.default()
        let audioConfiguration = PLSAudioConfiguration.default()
        self.shortVideoRecorder = PLShortVideoRecorder.init(videoConfiguration: videoConfiguration!, audioConfiguration: audioConfiguration!)
        self.view.addSubview((self.shortVideoRecorder?.previewView)!)
        //        self.shortVideoRecorder?.toggleCamera()
        self.shortVideoRecorder?.maxDuration = 15.0
        self.shortVideoRecorder?.minDuration = 1.0
        self.shortVideoRecorder?.delegate = self
        self.shortVideoRecorder?.setBeautify(1)
        self.shortVideoRecorder?.setBeautifyModeOn(true)
        self.shortVideoRecorder?.startCaptureSession()
    }
    //MARK: -添加手势
    func tap(){
        ProgressView.backgroundColor = UIColor.clear
        let longpressGesutre = UILongPressGestureRecognizer.init(target: self, action: #selector(start(_ :)))
        //所需触摸1次
        longpressGesutre.numberOfTouchesRequired = 1
        ProgressView.addGestureRecognizer(longpressGesutre)
    }
    func doplay(){
        stopBtn.isHidden = true
        player?.play()
    }
    //确定按钮
    func didsure(){
        
        QiniuTool.qiniuUploadVideo(filePath: (self.filePath?.path)!, videoName: "short_video", complete: { (result) in
            if self.resultBlock != nil{
                if let response = result as? String{
                    let outputSettings = ["PLSStartTimeKey" : NSNumber.init(value: 0),"PLSDurationKey" : self.shortVideoRecorder?.getTotalDuration() ?? 123, "movieUrl" : response ,"AVAsset" : self.shortVideoRecorder!.assetRepresentingAllFiles() ] as [String : Any]
                    self.resultBlock!(outputSettings as AnyObject)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }) { (error) in
        }
    }
    func switchbtn(){
        self.shortVideoRecorder?.toggleCamera()
    }
    func exit(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    //重置按钮
    func didreset(){
        //播放器停止
        
        if (player?.isPlaying == true){
            canle = true
            player?.stop()
        }
        resetBtn.isHidden = true
        sureBtn.isHidden = true
        stopBtn.isHidden = true
        ProgressView.isHidden = false
        self.switchBtn.isHidden = false
        self.closeBtn.isHidden = false
        self.showStartImg.isHidden = true
        self.shortVideoRecorder?.previewView?.isHidden = false
        self.view.bringSubview(toFront: (self.shortVideoRecorder?.previewView)!)
        self.view.bringSubview(toFront: sureBtn)
        self.view.bringSubview(toFront: resetBtn)
        self.view.bringSubview(toFront: ProgressView)
        self.view.bringSubview(toFront: switchBtn)
        self.view.bringSubview(toFront: closeBtn)
        self.shortVideoRecorder?.cancelRecording()
        self.shortVideoRecorder?.stopRecording()
        ProgressView.setProgress(0, animated: true)
    }
    
    func start( _ sender: UIRotationGestureRecognizer){
        if sender.state == .began {
            canle = false
            self.shortVideoRecorder?.startRecording()
        }
        if sender.state == .ended {
            self.shortVideoRecorder?.stopRecording()
        }
    }
}
extension TakeMovieVC  {
    
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        if state == .statusStopped{
            if !canle{
                stopBtn.isHidden = false
                self.view.bringSubview(toFront: self.stopBtn)
            }else{
                stopBtn.isHidden = true
                self.view.bringSubview(toFront: self.stopBtn)
            }
        }
        if state == .statusPaused{
            stopBtn.isHidden = true
        }
    }
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
        ProgressView.setProgress(ProgressView.progress + 0.4, animated: true)
    }
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingMaxDuration maxDuration: CGFloat) {
        ProgressView.isHidden = true
        self.shortVideoRecorder?.stopRecording()
        sureBtn.isHidden = false
        self.view.bringSubview(toFront: sureBtn)
        self.view.bringSubview(toFront: resetBtn)
        self.view.bringSubview(toFront: (player?.playerView)!)
        resetBtn.isHidden = false
        ProgressView.setProgress(0, animated: true)
    }
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
        ProgressView.isHidden = true
        self.shortVideoRecorder?.stopRecording()
        UIView.animate(withDuration: 0.23) {
            self.sureBtn.isHidden = false
            self.resetBtn.isHidden = false
        }
        self.filePath = fileURL
        self.shortVideoRecorder?.previewView?.isHidden = true
        getScreenImg()
        ProgressView.setProgress(0, animated: true)
        if (player == nil){
            player = PLPlayer.init(url: fileURL, option: nil)
            self.view.addSubview((player?.playerView)!)
            self.showStartImg.isHidden = false
            stopBtn.isHidden = true
            self.view.bringSubview(toFront: (player?.playerView)!)
            self.view.bringSubview(toFront: stopBtn)
            self.switchBtn.isHidden = true
            self.closeBtn.isHidden = true
            self.view.bringSubview(toFront: sureBtn)
            player?.delegate = self
            player?.play()
//            player?.launchView?.image = self.showStartImg.image
            self.view.bringSubview(toFront: resetBtn)
        }else{
            player?.play(with: fileURL)
            self.showStartImg.isHidden = false
            stopBtn.isHidden = true
            self.switchBtn.isHidden = true
            self.closeBtn.isHidden = true
//             player?.launchView = self.showStartImg.image
            self.view.bringSubview(toFront: stopBtn)
            self.view.bringSubview(toFront: (player?.playerView)!)
            self.view.bringSubview(toFront: sureBtn)
            self.view.bringSubview(toFront: resetBtn)
        }
    }
    //    //获取屏幕截图
    func getScreenImg(){
        let avAsset = AVAsset(url : self.filePath!)
        let generator = AVAssetImageGenerator(asset: avAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(0.0,600)
        var actualTime:CMTime = CMTimeMake(0,0)
        let imageRef:CGImage = try! generator.copyCGImage(at: time, actualTime: &actualTime)
        let frameImg = UIImage(cgImage:imageRef )
        showStartImg.image = frameImg
    }
    
}
