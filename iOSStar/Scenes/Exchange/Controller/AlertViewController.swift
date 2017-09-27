//
//  AlertViewController.swift
//  iOSStar
//
//  Created by MONSTER on 2017/5/27.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

// 屏幕宽高
private var kSCREEN_W : CGFloat = UIScreen.main.bounds.size.width
private var kSCREEN_H : CGFloat = UIScreen.main.bounds.size.height

class AlertViewController: UIViewController {
    
    // 对这个强引用
    var strongSelf:AlertViewController?
    
    // 按钮动作
    var completeAction:((_ button: UIButton) -> Void)? = nil
    
    // 内部控件
    var contentView = UIView()
    var closeButton = UIButton()
    var picImageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleTextView = UITextView();
    var completeButton = UIButton()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.7)
        self.view.addSubview(contentView)
        
        //强引用 不然按钮点击不能执行
        strongSelf = self
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK : - 初始化UI
    fileprivate func setupContentView() {
        
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0);
        contentView.layer.cornerRadius = 3.0
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        view.addSubview(contentView);
        
        
        contentView.addSubview(closeButton)
        contentView.addSubview(picImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleTextView)
        contentView.addSubview(completeButton)
    }
    
    //关闭按钮
    fileprivate func setupCloseButton() {
        
        closeButton.setImage((UIImage (named:"tangchuang_close")), for: .normal)
        self.closeButton.addTarget(self, action: #selector(closeButtonClick(_ :)), for: .touchUpInside);
        
    }
    
    // 图片
    fileprivate func setupPicImageView() {
        
        picImageView.contentMode = .scaleAspectFit
        
        
    }
    
    // 标题
    fileprivate func setupTitleLabel() {
        titleLabel.text = ""
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.colorFromRGB(0x333333)
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
    }
    
    // 文本
    fileprivate func setupSubTitleTextView() {
        subTitleTextView.text = ""
        // subTitleTextView.textAlignment = .center
         subTitleTextView.font = UIFont.systemFont(ofSize: 14.0)
        // subTitleTextView.textColor = UIColor.colorFromRGB(0x999999)
        subTitleTextView.isEditable = false
        subTitleTextView.isScrollEnabled = false
        subTitleTextView.isSelectable = false
        
    }
    // 按钮
    fileprivate func setupCompleteButton(){
        completeButton.backgroundColor = UIColor(hexString: AppConst.Color.main)
        completeButton.titleLabel?.textColor = UIColor.colorFromRGB(0xFAFAFA)
        completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        completeButton.addTarget(self, action: #selector(completeButtonButtonClick(_ :)), for: .touchUpInside)
    }
}

// MARK: -布局
extension AlertViewController {
    
    fileprivate func resizeAndLayout() {
        
        let mainScreenBounds = UIScreen.main.bounds
        self.view.frame.size = mainScreenBounds.size

        var kLEFT_MARGIN :CGFloat = 0
        var kTOP_MARGIN  :CGFloat = 0
        
        if kSCREEN_H == 568 {
             kLEFT_MARGIN = 19
             kTOP_MARGIN = 59
        } else {
            kLEFT_MARGIN  = 37
            kTOP_MARGIN   = 118
        }
        // let kLEFT_MARGIN :CGFloat = kSCREEN_W * 0.1
        // let kTOP_MARGIN : CGFloat = kSCREEN_H * 0.085

        contentView.frame = CGRect(x: kLEFT_MARGIN,
                                   y: kTOP_MARGIN,
                                   width: kSCREEN_W - (kLEFT_MARGIN * 2) ,
                                   height: kSCREEN_H - (kTOP_MARGIN * 2))
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(16)
        }
        
        //        picImageView.frame = CGRect(x: 69, y: 52, width: 164, height: 164)
        picImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(picImageView.snp.bottom).offset(20)
            
        }
        subTitleTextView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            
        }
        
        completeButton.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(contentView).offset(0)
            make.height.equalTo(51)
        }
        
        contentView.transform = CGAffineTransform(translationX: 0, y: -kSCREEN_H / 2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            self.contentView.transform = CGAffineTransform.identity
            
        }, completion: nil)
    }
}


// MARK: - show
extension AlertViewController {
    
    // show
    func showAlertVc(imageName : String , titleLabelText : String , subTitleText : String , completeButtonTitle : String , action:@escaping ((_ completeButton: UIButton) -> Void)) {
        
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubview(toFront: view)
        view.frame = window.bounds
        
        completeAction = action;
        
        setupContentView()
        setupCloseButton()
        setupPicImageView()
        setupTitleLabel()
        setupSubTitleTextView()
        setupCompleteButton()
        
        self.picImageView.image = UIImage(named: "\(imageName)")
        self.titleLabel.text = titleLabelText
        
        // 设置行间距?
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .center
        
        let attributes = [NSParagraphStyleAttributeName: paragraphStyle,
                          NSForegroundColorAttributeName:UIColor.colorFromRGB(0x999999)]
        self.subTitleTextView.attributedText = NSAttributedString(string: subTitleText, attributes: attributes)
        
        
        // self.subTitleTextView.text = subTitleText;
        self.completeButton.setTitle("\(completeButtonTitle)", for: .normal);
        
        resizeAndLayout()
    }
    
    // dismiss
    func dismissAlertVc() {
        
        UIView.animate(withDuration: 0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: kSCREEN_H)
            
        }) { (Bool) -> Void in
            self.view.removeFromSuperview()
            self.contentView.removeFromSuperview()
            self.contentView = UIView()
            self.strongSelf = nil
        }
    }
}

// MARK: - AlertViewController 点击事件
extension AlertViewController {
    
    
    func closeButtonClick(_ sender: UIButton) {
        
        dismissAlertVc()
        
    }
    
    func completeButtonButtonClick(_ sender : UIButton)  {
        
        if completeAction != nil {
            completeAction!(sender)
        }
    }
}

// MARK: - 点击任意位置退出dismiss
extension AlertViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismissAlertVc()
        
    }
}

extension UIColor {
    class func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

