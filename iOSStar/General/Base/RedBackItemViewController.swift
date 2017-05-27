//
//  RedBackItemViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/27.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class RedBackItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(selfBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hexString: AppConst.Color.main)
     }
    
    func selfBack() {
      _ = navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
