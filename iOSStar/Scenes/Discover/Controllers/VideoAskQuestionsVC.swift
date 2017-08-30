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
    var starModel: StarSortListModel = StarSortListModel()
    var preview : String  = ""
    var totaltime = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "像提TA问"
        navright()
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
        inputText.text = textView.text
        if textView.text == "" {
            placeHolder.text = "输入你的问题，可选择公开或者私密，公开提问能呗其他用户所见 "
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
        
        if (textVStr.length > 100) {
            inputText.resignFirstResponder()
            return
        }else{
            textNumber.text = "\(textVStr.length)/100"
        }
        
    }
    
    @IBAction func videoBtnTapped(_ sender: UIButton) {
        //TakeMovieVC
        if inputText.text == ""{
//         SVProgressHUD.showErrorMessage(ErrorMessage: "请", ForDuration: <#T##Double#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        }
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: TakeMovieVC.className()) as? TakeMovieVC{
            vc.resultBlock = {  [weak self] (result) in
                if let response =  result as?  [String : AnyObject]{
                    
                    if let url = response["movieUrl"] as? String{
                        self?.preview  = url
                    }
                    if let time = response["totalTime"] as?  Int{
                        self?.totaltime  = time
                        
                    }

                
                }
            }
            //TakeMovieVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func publish(){
        if self.preview ==  ""{
         SVProgressHUD.showErrorMessage(ErrorMessage: "请输入视频内容", ForDuration: 2, completion: nil)
        }
        let request = AskRequestModel()
        request.pType = publicSwitch.isOn ? 0 : 1
        request.aType = 0
        request.starcode = starModel.symbol
        request.uask = inputText.text
        request.videoUrl = self.preview
        request.cType = totaltime
        AppAPIHelper.discoverAPI().videoAskQuestion(requestModel:request, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 0{
                     SVProgressHUD.showSuccessMessage(SuccessMessage: "视频问答成功", ForDuration: 1, completion: { 
                        self.navigationController?.popViewController(animated: true)
                     })
                }
                if model.result == 1{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "问答失败", ForDuration: 2, completion: nil)
                }
            }
        }) { (error) in
            self.didRequestError(error)
        }
    
        
    }
}
