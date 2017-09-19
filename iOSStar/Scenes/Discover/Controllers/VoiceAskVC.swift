//
//  VoiceAskVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class VoiceAskVC: BaseTableViewController ,UITextViewDelegate{
    
   
    @IBOutlet var contentText: UITextView!
 
    @IBOutlet var placeholdLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var voice15Btn: UIButton!
    @IBOutlet weak var voice30Btn: UIButton!
    @IBOutlet weak var voice60Btn: UIButton!
    @IBOutlet var switchopen: UISwitch!
    var starModel: StarSortListModel = StarSortListModel()
    private var lastVoiceBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "向TA定制"
        voiceBtnTapped(voice15Btn)
        navright()
    }
    
    @IBAction func voiceBtnTapped(_ sender: UIButton) {
        lastVoiceBtn?.isSelected = false
        sender.isSelected = !sender.isSelected
        lastVoiceBtn = sender
    }
    func navright(){
        let share = UIButton.init(type: .custom)
        share.frame = CGRect.init(x: 0, y: 0, width: 70, height: 30)
        share.setTitle("发布", for: .normal)
        share.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        share.setTitleColor(UIColor.init(hexString: AppConst.Color.main), for: .normal)
        share.addTarget(self, action: #selector(publish), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: share)
        self.navigationItem.rightBarButtonItem = item
        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotifitionAction), name: NSNotification.Name.UITextViewTextDidChange, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(textViewNotifitionAction), name: NSNotification.Name.UITextViewTextDidChange, object: nil);
    }
    func publish(){
        if contentText.text == ""{
            SVProgressHUD.showErrorMessage(ErrorMessage: "请输入问答内容", ForDuration: 2, completion: nil)
            return
        }
        let request = AskRequestModel()
        request.pType = switchopen.isOn ? 1 : 0
        request.aType = 2
        request.starcode = starModel.symbol
        request.uask = contentText.text!
        request.videoUrl = ""
        request.cType = voice15Btn.isSelected ? 0 : (voice30Btn.isSelected ? 1 : (voice60Btn.isSelected ? 3 : 1))
        AppAPIHelper.discoverAPI().videoAskQuestion(requestModel:request, complete: { (result) in
            if let model = result as? ResultModel{
                if model.result == 0{
                    SVProgressHUD.showSuccessMessage(SuccessMessage: "语音问答成功", ForDuration: 1, completion: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                if model.result == 1{
                    SVProgressHUD.showErrorMessage(ErrorMessage: "时间不足", ForDuration: 2, completion: nil)
                }
            }
        }) { (error) in
            self.didRequestError(error)
        }
        
        
    }
    // 限制不超过200字
    
    func textViewNotifitionAction(userInfo:NSNotification){
        let textVStr = contentText.text as! NSString
        
        if ((textVStr.length) > 100) {
            contentText.text = contentText.text.substring(to: contentText.text.index(contentText.text.startIndex, offsetBy: 100))
            contentText.resignFirstResponder()
            return
        }else{
            countLabel.text = "\(textVStr.length)/100"
        }
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (contentText.text.length() > 100){
          return false
        }
         return true
    }
    func textViewDidChange(_ textView: UITextView) {
//        contentText.text = textView.text
        if textView.text == "" {
            placeholdLabel.text = "输入你的问题，可选择公开或者私密，公开提问能被其他用户所见 "
            placeholdLabel.isHidden = false
        } else {
            placeholdLabel.text = ""
            placeholdLabel.isHidden = true
        }
    }
}
