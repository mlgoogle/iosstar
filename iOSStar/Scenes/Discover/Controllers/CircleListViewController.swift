//
//  CircleListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class CircleListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        requestCirCleList()
    }

    func requestCirCleList() {

        let requestModel = CircleListRequestModel()

        AppAPIHelper.discoverAPI().requestCircleList(requestModel: requestModel, complete: { (response) in
            if let models = response as? [CircleListModel] {

                for model in models {
                    

                    
                }
                
                
                
                
            }
            
            
        }) { (error) in
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
