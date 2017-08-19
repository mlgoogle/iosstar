//
//  AskQuestionsVC.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class AskQuestionsVC: UIViewController ,UITextViewDelegate{
    
    @IBOutlet var publicSwitch: UISwitch!
    @IBOutlet var inputText: UITextView!
    @IBOutlet var placeHolder: UILabel!
    @IBOutlet var textNumber: UILabel!
    @IBOutlet weak var videoBtn: UIButton!
    
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
        if let vc = UIStoryboard.init(name: "Discover", bundle: nil).instantiateViewController(withIdentifier: TakeMovieVC.className()) as? TakeMovieVC{
            //TakeMovieVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func publish(){
        
    }
}
