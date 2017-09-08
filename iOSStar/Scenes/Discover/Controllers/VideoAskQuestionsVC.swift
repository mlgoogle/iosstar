//
//  VideoAskQuestionsVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class VideoAskQuestionsVC: UIViewController ,UITextViewDelegate{
    
    @IBOutlet var publicSwitch: UISwitch!
    var shortVideoplay : PLShortVideoEditor?
    @IBOutlet var inputText: UITextView!
    @IBOutlet var placeHolder: UILabel!
    @IBOutlet var textNumber: UILabel!
    @IBOutlet weak var videoBtn: UIButton!
    @IBOutlet weak var voice15Btn: UIButton!
    @IBOutlet weak var voice30Btn: UIButton!
    @IBOutlet weak var voice60Btn: UIButton!
    var starModel: StarSortListModel = StarSortListModel()
    var preview : String  = ""
    var thumbnail =  ""
    var totaltime = 0
    private var lastVoiceBtn: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "向TA提问"
        voiceSelectBtnTapped(voice15Btn)
        navright()
    }
    
    @IBAction func voiceSelectBtnTapped(_ sender: UIButton) {
        lastVoiceBtn?.isSelected = false
        sender.isSelected = !sender.isSelected
        lastVoiceBtn = sender
    }
    func navright(){
        let share = UIButton.init(type: .custom)
        share.frame = CGRect.init(x: 0, y: 0, width: 70, height: 30)
        share.setTitle("发布", for: .normal)
        share.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        share.setTitleColor(UIColor.init(hexString: AppConst.Color.main), for: .normal)
        share.addTarget(self, action: #selector(publish), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: share)
        self.navigationItem.rightBarButtonItem = item
        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotifitionAction), name: NSNotification.Name.UITextViewTextDidChange, object: nil);
    }
    
    func textViewDidChange(_ textView: UITextView) {
       
        if textView.text == "" {
            placeHolder.text = "输入你的问题，可选择公开或者私密，公开提问能被其他用户所见 "
            placeHolder.isHidden = false
        } else {
            placeHolder.text = ""
            placeHolder.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    // 限制不超过200字
    func textViewNotifitionAction(userInfo:NSNotification){
        let textVStr = inputText.text as NSString;
        
        if ((textVStr.length) > 100) {
            inputText.text = inputText.text.substring(to: inputText.text.index(inputText.text.startIndex, offsetBy: 100))
            inputText.resignFirstResponder()
            return
        }else{
            textNumber.text = "\(textVStr.length)/100"
        }
        
    }
    
    @IBAction func videoBtnTapped(_ sender: UIButton) {
        //TakeMovieVC
         inputText.resignFirstResponder()
        if  inputText.text == ""{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入问题", ForDuration: 2, completion: nil)
            return
        }
        
        
        if !AppConfigHelper.shared().getAVAuthorizationStatusRestricted(){
            let alertVC = UIAlertController(title: "提示", message: "请在设备的\"设置-隐私-麦克风\"中允许使用麦克风", preferredStyle: UIAlertControllerStyle.alert)
            let alertActionOK = UIAlertAction(title: "确定", style: .default, handler: nil)
//                action in
//                  UIApplication.shared.openURL(URL(string: "prefs:root=Privacy&path=CAMERA")!)
//            )
            let alertActionCancel = UIAlertAction(title: "取消", style: .default, handler: nil)
            alertVC.addAction(alertActionCancel)
            alertVC.addAction(alertActionOK)
        
            self.present(alertVC, animated: true, completion: nil)
           
             return

        }
        if !AppConfigHelper.shared().getcameraAuthorizationStatusRestricted(){
            let alertVC = UIAlertController(title: "提示", message: "请在设备的\"设置-隐私-相机\"中允许访问相机", preferredStyle: .alert)
            let alertActionOK = UIAlertAction(title: "确定", style: .default, handler: nil)
//            let alertActionCancel = UIAlertAction(title: "取消", style: .default, handler:  {
//                action in
//                 UIApplication.shared.openURL(URL(string: "prefs:root=Privacy&path=CAMERA")!)
//                })
//            alertVC.addAction(alertActionCancel)
            alertVC.addAction(alertActionOK)
            self.present(alertVC, animated: true, completion: nil)
          return
           
        }
        
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: TakeMovieVC.className()) as? TakeMovieVC{
            vc.q_content = inputText.text
            vc.resultBlock = {  [weak self] (result) in
                if let response =  result as?  [String : AnyObject]{
                    
                    if let url = response["movieUrl"] as? String{
                        self?.preview  = url
                    }
                    if let time = response["totalTime"] as?  Int{
                        self?.totaltime  = time
                    }
                    if let time = response["thumbnail"] as?  String{
                        self?.thumbnail  = time
                    }
                }
            }
            //TakeMovieVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func publish(){
        if self.inputText.text ==  ""{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入问答内容", ForDuration: 2, completion: nil)
            return
        }
        
        
        let request = AskRequestModel()
        request.pType = publicSwitch.isOn ? 1 : 0
        request.aType = 1
        request.thumbnail = self.thumbnail
        request.starcode = starModel.symbol
        request.uask = inputText.text
        request.videoUrl = self.preview
        request.cType =  voice15Btn.isSelected ? 0 : (voice30Btn.isSelected ? 1 : (voice60Btn.isSelected ? 3 : 1))
        AppAPIHelper.discoverAPI().videoAskQuestion(requestModel:request, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 0{
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "视频问答成功", ForDuration: 1, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                if model.result == 1{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "用户时间不足", ForDuration: 2, completion: nil)
                }
            }
        }) { (error) in
            self.didRequestError(error)
        }
        
        
    }
}
