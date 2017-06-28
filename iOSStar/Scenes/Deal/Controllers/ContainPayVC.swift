//
//  ContainPayVC.swift
//  iOSStar
//
//  Created by sum on 2017/6/13.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

   class ContainPayVC: UIViewController {
    var scrollView : UIScrollView?
    var showAll : Bool = true 
    var resultBlock: CompleteBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        if showAll{
         initUI()
        }else{
         initAllView()
        }
        view.backgroundColor = UIColor.clear
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func initAllView(){
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.scrollView?.isScrollEnabled = false
        scrollView?.isPagingEnabled = true
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView?.contentSize = CGSize.init(width: self.view.frame.size.width*2, height: 0)
        view.addSubview(scrollView!)
        
        scrollView?.isPagingEnabled = true
        scrollView?.backgroundColor = UIColor.clear
        
        //进入交易密码界面
        let rvc = UIStoryboard.init(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "InputPassVC") as! InputPassVC
        self.scrollView?.addSubview(rvc.view)
        rvc.resultBlock = { [weak self](result) in
            
            if ((result as? String) != nil){
                
                self?.resultBlock?(result )
                //result 的值就是
                //                    self?.dismissController()
            }else{
                //忘记密码
                switch result as! doStateClick {
                case .close:
                     self?.resultBlock?(result )
                    self?.dismissController()
                    break
                default:
                    let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            
        }
        self.addChildViewController(rvc)
        //确认订单
        let vc = UIStoryboard.init(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SurePayAllOrderVC") as! SurePayAllOrderVC
        vc.resultBlock = { [weak self](result) in
            
            switch result as! doStateClick{
            case .close:
                self?.resultBlock?(result )
                self?.dismissController()
                break
            default:
                rvc.textField.resignFirstResponder()
                self?.scrollView?.setContentOffset(CGPoint.init(x: (self?.scrollView?.frame.size.width)!, y: 0), animated: true)
                rvc.textField.becomeFirstResponder()
                
            }
            
            
        }
        
        vc.view.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: ((self.scrollView?.frame.size.height)!+10))
        scrollView?.addSubview(vc.view)
        rvc.view.frame = CGRect.init(x:  vc.view.frame.size.width, y: -10, width: vc.view.frame.size.width, height: ((self.scrollView?.frame.size.height)!+10))
        self.addChildViewController(vc)
        
        
    }
    func initUI(){
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.scrollView?.isScrollEnabled = false
        scrollView?.isPagingEnabled = true
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView?.contentSize = CGSize.init(width: self.view.frame.size.width*2, height: 0)
        view.addSubview(scrollView!)
        
        scrollView?.isPagingEnabled = true
        scrollView?.backgroundColor = UIColor.clear
       
        //进入交易密码界面
        let rvc = UIStoryboard.init(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "InputPassVC") as! InputPassVC
        self.scrollView?.addSubview(rvc.view)
             rvc.resultBlock = { [weak self](result) in
        
                if ((result as? String) != nil){
                
                     self?.resultBlock?(result )
                    //result 的值就是
//                    self?.dismissController()
                }else{
                //忘记密码
                    switch result as! doStateClick {
                    case .close:
                        self?.dismissController()
                        break
                    default:
                        let vc = UIStoryboard.init(name: "User", bundle: nil).instantiateViewController(withIdentifier: "ResetTradePassVC")
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                   
                }
                
                }
        self.addChildViewController(rvc)
         //确认订单
        let vc = UIStoryboard.init(name: "Order", bundle: nil).instantiateViewController(withIdentifier: "SurePayOrderVC") as! SurePayOrderVC
             vc.resultBlock = { [weak self](result) in
            
                switch result as! doStateClick{
                case .close:
                    self?.dismissController()
                    break
                default:
                    rvc.textField.resignFirstResponder()
                    self?.scrollView?.setContentOffset(CGPoint.init(x: (self?.scrollView?.frame.size.width)!, y: 0), animated: true)
                    rvc.textField.becomeFirstResponder()
                    
                }
                
            
        }
        
        vc.view.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: ((self.scrollView?.frame.size.height)!+10))
        scrollView?.addSubview(vc.view)
        rvc.view.frame = CGRect.init(x:  vc.view.frame.size.width, y: -10, width: vc.view.frame.size.width, height: ((self.scrollView?.frame.size.height)!+10))
        self.addChildViewController(vc)

        
    }


}
