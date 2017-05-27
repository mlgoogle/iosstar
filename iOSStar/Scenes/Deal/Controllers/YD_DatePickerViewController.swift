//
//  YD_DatePickerViewController.swift
//  渐变色
//
//  Created by J-bb on 17/5/24.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

protocol SureActionDelegate {
    
    func sureAction(date:Date)
    
}

class YD_DatePickerViewController: UIViewController {
    var picker:UIDatePicker = {
        let picker = UIDatePicker(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200))
        picker.datePickerMode = .date
        picker.backgroundColor = UIColor.white
        return picker
    }()
    var delegate:SureActionDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        view.addSubview(picker)
        picker.maximumDate = Date()
        
        let menuView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200 - 40, width: UIScreen.main.bounds.size.width, height: 40))
        view.addSubview(menuView)
        menuView.backgroundColor = UIColor.white
        
        let cancelButton = UIButton(frame: CGRect(x: 25, y: 0, width: 40, height: 40))
        
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.green, for: .normal)
        menuView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        let sureButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - 25 - 40, y: 0, width: 40, height: 40))
        sureButton.addTarget(self, action: #selector(sureButtonAction), for: .touchUpInside)
        sureButton.setTitleColor(UIColor.green, for: .normal)
        sureButton.setTitle("确定", for: .normal)
        menuView.addSubview(sureButton)
    }
    
    func cancelButtonAction()  {
        dismiss(animated: true, completion: nil)
    }
    func sureButtonAction() {
        
        delegate?.sureAction(date: picker.date)
        dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
