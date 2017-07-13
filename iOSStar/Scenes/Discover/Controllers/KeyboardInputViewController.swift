//
//  KeyboardInputViewController.swift
//  YStar
//
//  Created by mu on 2017/7/13.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import YYText

//辅助视图toolbar
class YInputToolbar: UIView{
    let sw = UIScreen.main.bounds.width
    lazy var sendBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.system)
        btn.setTitle("发送", for: .normal)
        btn.frame = CGRect.init(x: self.sw - 50 , y: 8, width: 44, height: 44-16)
        return btn
    }()
    
    lazy var emothionBtn: UIButton = {
        let btn = UIButton.init(type: UIButtonType.contactAdd)
        btn.frame = CGRect.init(x: self.sendBtn.frame.minX - 44 , y: 8, width: 44-16, height: 44-16)
        return btn
    }()
    
    lazy var inputText: YYTextView = {
        let text = YYTextView.init(frame: CGRect.init(x: 8, y: 8, width: self.emothionBtn.frame.minX-12, height: 44-16))
        let parser = YYTextSimpleEmoticonParser()
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 44))
        backgroundColor = UIColor.init(rgbHex: 0xffffff)
        addSubview(sendBtn)
        addSubview(emothionBtn)
        addSubview(inputText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class KeyboardInputViewController: UIViewController, HHEmojiKeyboardDelegate {
    
    lazy var toolbar: YInputToolbar = {
        let bar = YInputToolbar.init(frame: CGRect.zero)
        return bar
    }()
    

    let emojiHeight = UIScreen.main.bounds.width*3/7
    lazy var ykeyboard: HHEmojiKeyboard = {
        
        let dic = HHEmojiManage.getEmojiAll()
        var emojiArr:[String] = []
        for arr in dic.allValues {
            emojiArr = arr as! [String]
            break
        }
        let layout = HHCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        let width:CGFloat = self.view.frame.size.width
        let frame = CGRect(x: 0, y: self.view.frame.size.height - self.emojiHeight, width: width, height: self.emojiHeight)
        let keyboard = HHEmojiKeyboard(frame: frame, collectionViewLayout: layout, stringArr: emojiArr, isShowDelete: true)
        keyboard.emojiKeyboardDelegate = self
        keyboard.backgroundColor = UIColor.white
        return keyboard
    }()
    
    var sendMessage: CompleteBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加键盘监听
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main, using: { [weak self] (notice) in
            if let info = notice.userInfo{
                if let frame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect{
                    self?.toolbar.y =  frame.minY - 44
                }
                
            }
        })
        
        configKeyboard()
        
    }
    
    func configKeyboard() {
        toolbar.inputText.becomeFirstResponder()
        toolbar.sendBtn.addTarget(self, action: #selector(sendBtnTapped(_:)), for: .touchUpInside)
        toolbar.emothionBtn.addTarget(self, action: #selector(emothionBtnTapped(_:)), for: .touchUpInside)
        //添加emoji表情
        view.addSubview(ykeyboard)
        //添加辅助视图toolbar
        view.addSubview(toolbar)
    }
    
    func sendBtnTapped(_ btn: UIButton) {
        if sendMessage != nil {
            sendMessage!(toolbar.inputText.text as AnyObject?)
        }
        dismissController()
    }
    
    func emothionBtnTapped(_ btn: UIButton)  {
        view.endEditing(true)
        toolbar.y = UIScreen.main.bounds.height - emojiHeight - 44
    }
    // MARK: - HHEmojiKeyboardDelegate
    func emojiKeyboard(_ emojiKeyboard:HHEmojiKeyboard,didSelectEmoji emoji:String){
        toolbar.inputText.text?.append(emoji)
    }
    func emojiKeyboardDidSelectDelete(_ emojiKeyboard:HHEmojiKeyboard){
        toolbar.inputText.deleteBackward()
    }
    func emojiKeyboard(_ emojiKeyboard: HHEmojiKeyboard, scrollDidTo pageIndex: Int) {
        print(pageIndex)
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissController()
    }
    func matrixTransformation(_ arr:[String],column:Int) -> [String] {
        var matrix:[String] = []
        var min = 1
        var preNum = -column
        for _ in 0..<arr.count {
            var num = preNum + column
            if num >= arr.count {
                num = min
                min += 1
            }
            matrix.append(arr[num])
            preNum = num
            
        }
        return matrix
    }
}
