//
//  VoiceAskVC.swift
//  iOSStar
//
//  Created by mu on 2017/8/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class VoiceAskVC: BaseTableViewController {
    
    @IBOutlet weak var placeholdLabel: UILabel!
    @IBOutlet weak var contentText: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var voice15Btn: UIButton!
    @IBOutlet weak var voice30Btn: UIButton!
    @IBOutlet weak var voice60Btn: UIButton!
    
    private var lastVoiceBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "向TA定制"
        voiceBtnTapped(voice15Btn)
    }

    @IBAction func voiceBtnTapped(_ sender: UIButton) {
        lastVoiceBtn?.isSelected = false
        sender.isSelected = !sender.isSelected
        lastVoiceBtn = sender
    }

    @IBAction func openSwitch(_ sender: UISwitch) {
        
    }
    
}
