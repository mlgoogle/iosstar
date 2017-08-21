//
//  TakeMovieVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import PLShortVideoKit
class TakeMovieVC: UIViewController ,PLShortVideoRecorderDelegate{

    
    var didTap = false
    var index  = 1
    var shortVideoRecorder : PLShortVideoRecorder?
    
    //设置按住松开的view
    lazy var ProgressView  :  OProgressView = {
      let  Progress = OProgressView.init(frame: CGRect.init(x: self.view.center.x - 50, y: kScreenHeight - 120, width: 100, height: 100))
        return Progress
    }()
    
     //切换摄像头
    lazy var switchBtn : UIButton = {
        let resetBtn = UIButton.init(type: .custom)
        resetBtn.frame = CGRect.init(x: 50, y: 30, width: 60, height: 60)
        resetBtn.setImage(UIImage.init(named: "frontBack"), for: .normal)
        resetBtn.addTarget(self , action: #selector(switchbtn), for: .touchUpInside)
        return resetBtn
    }()
    
    //退出按钮
    lazy var closeBtn: UIButton = {
        let resetBtn = UIButton.init(type: .custom)
        resetBtn.frame = CGRect.init(x: kScreenWidth - 100, y: 30, width: 60, height: 60)
        resetBtn.setImage(UIImage.init(named: "videoCloseØ"), for: .normal)
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
        tap()
        self.shortVideoRecorder?.startCaptureSession()
        self.view.addSubview(resetBtn)
        self.view.addSubview(switchBtn)
        self.view.addSubview(sureBtn)
    }
    
    //MARK: -添加手势
    func tap(){
        self.view.addSubview(ProgressView)
        ProgressView.backgroundColor = UIColor.clear
        let longpressGesutre = UILongPressGestureRecognizer.init(target: self, action: #selector(start(_ :)))
        //所需触摸1次
        longpressGesutre.numberOfTouchesRequired = 1
        ProgressView.addGestureRecognizer(longpressGesutre)
    }
    
    //确定按钮
    func didsure(){
        let asset : AVAsset = self.shortVideoRecorder!.assetRepresentingAllFiles()
 
        let outputSettings = ["PLSStartTimeKey" : NSNumber.init(value: 0),"PLSDurationKey" : self.shortVideoRecorder?.getTotalDuration()] as [String : Any]
        let vc = PlayVC()
        vc.asset = asset
        vc.settings = outputSettings as [String : AnyObject]
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func switchbtn(){
        self.shortVideoRecorder?.toggleCamera()
    }
    
    func exit(){
        _ = navigationController?.popViewController(animated: true)
    }

    //重置按钮
    func didreset(){
        resetBtn.isHidden = true
        sureBtn.isHidden = true
        ProgressView.isHidden = false
        self.shortVideoRecorder?.cancelRecording()
        self.shortVideoRecorder?.stopRecording()

        ProgressView.setProgress(0, animated: true)
    }

    func start( _ sender: UIRotationGestureRecognizer){
       
        if sender.state == .began {
             self.shortVideoRecorder?.startRecording()
        }
        if sender.state == .ended {
            self.shortVideoRecorder?.stopRecording()
        }
        
    }
    //MARK: -配置段视频链接
    func configViedeo(){
        let videoConfiguration = PLSVideoConfiguration.default()
        let audioConfiguration = PLSAudioConfiguration.default()
        self.shortVideoRecorder = PLShortVideoRecorder.init(videoConfiguration: videoConfiguration!, audioConfiguration: audioConfiguration!)
        self.view.addSubview((self.shortVideoRecorder?.previewView)!)
       
        self.shortVideoRecorder?.toggleCamera()
        self.shortVideoRecorder?.maxDuration = 15.0
        self.shortVideoRecorder?.minDuration = 1.0
        self.shortVideoRecorder?.delegate = self
        self.shortVideoRecorder?.setBeautify(1)
        self.shortVideoRecorder?.setBeautifyModeOn(true)
    }
  


}
extension TakeMovieVC  {
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
       
        ProgressView.setProgress(ProgressView.progress + 0.4, animated: true)
    }
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingMaxDuration maxDuration: CGFloat) {
         ProgressView.isHidden = true
        self.shortVideoRecorder?.stopRecording()
         sureBtn.isHidden = false
         resetBtn.isHidden = false
         ProgressView.setProgress(0, animated: true)
    }
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
        ProgressView.isHidden = true
        self.shortVideoRecorder?.stopRecording()
        sureBtn.isHidden = false
        resetBtn.isHidden = false
        ProgressView.setProgress(0, animated: true)
        
    }
}
