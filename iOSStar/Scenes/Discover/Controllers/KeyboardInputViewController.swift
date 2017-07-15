//
//  KeyboardInputViewController.swift
//  YStar
//
//  Created by mu on 2017/7/13.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import UIKit
import YYText

class YParser: YYTextSimpleEmoticonParser {
    static let parser = { () -> YYTextSimpleEmoticonParser in 
        let parser = YYTextSimpleEmoticonParser()
        let emojiArray = HHEmojiManage.getYEmoji()
        var mapper: [String: UIImage] = [:]
        for emoji in emojiArray{
            if let emojiDic  = emoji as? NSDictionary{
                if let imageName = emojiDic["file"] as? String{
                    let emojiImage = getEmojiImage(imageName)
                    let imageTag = emojiDic["tag"] as? String
                    mapper[imageTag!] = emojiImage

                }
            }
        }
        parser.emoticonMapper = mapper
        return parser
    }()
    class func share() -> YYTextSimpleEmoticonParser{
        
        return parser
    }
    
    class func getEmojiImage(_ imageName: String) -> UIImage?{
        if let bundlePath = Bundle.main.path(forResource: "NIMKitEmoticon", ofType: "bundle"){
            let imageStr = NSString.init(string: imageName)
            let resultImage = imageStr.substring(to: imageName.length() - 4 ).appending("@2x.png")
            if let path = Bundle.init(path: bundlePath)?.path(forResource: resultImage, ofType: nil, inDirectory: "Emoji"){
                return UIImage.init(contentsOfFile: path)
            }
            
        }
        return nil
    }
}

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
        let parser = YParser.share()
        text.textParser = parser
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: -0.5, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width+1, height: 44))
        backgroundColor = UIColor.init(rgbHex: 0xffffff)
        layer.borderColor = UIColor.init(rgbHex: 0x999999).cgColor
        layer.borderWidth = 0.5
        addSubview(sendBtn)
        addSubview(emothionBtn)
        addSubview(inputText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EmojiHelpView: UIView{
    lazy var emojiBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(YParser.getEmojiImage("emoji_00.png"), for: .normal)
        btn.backgroundColor = UIColor.init(rgbHex: 0xececec)
        btn.frame = CGRect.init(x: 0, y: 0, width: 44, height: 30)
        return btn
    }()
    
    lazy var pagePoints: UIPageControl = {
        let pageIndex = UIPageControl.init(frame: CGRect.init(x: 0, y: self.frame.height - 44 - 30, width: UIScreen.main.bounds.width, height: 44))
        pageIndex.pageIndicatorTintColor = UIColor.init(rgbHex: 0x999999)
        pageIndex.currentPageIndicatorTintColor = UIColor.init(rgbHex: 0x666666)
        pageIndex.numberOfPages = 7
        return pageIndex
    }()
    
    lazy var bottom: UIView = {
        let bottomView = UIView.init(frame: CGRect.init(x: -0.5, y: self.frame.height - 30, width: UIScreen.main.bounds.size.width+1, height: 30.5))
        bottomView.backgroundColor = UIColor.init(rgbHex: 0xfafafa)
        bottomView.layer.borderColor = UIColor.init(rgbHex: 0x999999).cgColor
        bottomView.layer.borderWidth = 0.5
        bottomView.addSubview(self.emojiBtn)
        return bottomView

    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        backgroundColor = UIColor.white
        addSubview(bottom)
        addSubview(pagePoints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class KeyboardInputViewController: UIViewController, HHEmojiKeyboardDelegate {
    
    let emojiHeight = UIScreen.main.bounds.width*3/7
    var sendMessage: CompleteBlock?
    var toolbarSwitch = true
    
    lazy var toolbar: YInputToolbar = {
        let bar = YInputToolbar.init(frame: CGRect.zero)
        return bar
    }()
    
    lazy var helpView: EmojiHelpView = {
        let help = EmojiHelpView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 256 + self.emojiHeight, width: UIScreen.main.bounds.width, height: 256-self.emojiHeight))
        return help
    }()
    
    lazy var ykeyboard: HHEmojiKeyboard = {
        let emojiArray = HHEmojiManage.getYEmoji()
        let layout = HHCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        let width:CGFloat = self.view.frame.size.width
        let frame = CGRect(x: 0, y: self.view.frame.size.height - 256, width: width, height: self.emojiHeight)
        let keyboard = HHEmojiKeyboard(frame: frame, collectionViewLayout: layout, stringArr: emojiArray, isShowDelete: false)
        keyboard.emojiKeyboardDelegate = self
        keyboard.backgroundColor = UIColor.white
        return keyboard
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加键盘监听
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main, using: { [weak self] (notice) in
            if let info = notice.userInfo{
                if let frame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect{
                    if self != nil && (self?.toolbarSwitch)! {
                        self?.toolbar.y =  frame.minY - 44
                    }
                }
            }
        })
        configKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //添加emoji表情
        view.addSubview(ykeyboard)
        //添加辅助视图
        view.addSubview(helpView)
    }
    
    func configKeyboard() {
        toolbar.inputText.becomeFirstResponder()
        toolbar.sendBtn.addTarget(self, action: #selector(sendBtnTapped(_:)), for: .touchUpInside)
        toolbar.emothionBtn.addTarget(self, action: #selector(emothionBtnTapped(_:)), for: .touchUpInside)
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
        toolbarSwitch = false
        view.endEditing(false)
        toolbar.y = UIScreen.main.bounds.height - 300
        toolbarSwitch = true
    }
    
    // MARK: - HHEmojiKeyboardDelegate
    func emojiKeyboard(_ emojiKeyboard:HHEmojiKeyboard,didSelectEmoji emoji:String){
        toolbar.inputText.text?.append(emoji)
    }
    
    func emojiKeyboardDidSelectDelete(_ emojiKeyboard:HHEmojiKeyboard){
        toolbar.inputText.deleteBackward()
    }
    
    func emojiKeyboard(_ emojiKeyboard: HHEmojiKeyboard, scrollDidTo pageIndex: Int) {
        helpView.pagePoints.currentPage = pageIndex
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissController()
    }
}
