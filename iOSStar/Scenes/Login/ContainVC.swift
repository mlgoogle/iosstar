//
//  ContainVC.swift
//  iOSStar
//
//  Created by sum on 2017/5/5.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
enum doStateClick{
    case doRegist
    case doLogin
    case doResetPwd
 
}
class ContainVC: UIViewController {

    var scrollView : UIScrollView?
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       initUI()
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
    
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y:  0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.scrollView?.isScrollEnabled = false
        scrollView?.isPagingEnabled = true
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView?.contentSize = CGSize.init(width: self.view.frame.size.width*3, height: 0)
        view.addSubview(scrollView!)
        scrollView?.isPagingEnabled = true
        let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        vc.resultBlock = { [weak self](result) in
            
            switch result as! doStateClick {
            case .doResetPwd:
                
                let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FotgotPwdVC")
                self?.navigationController?.pushViewController(vc, animated: true)
                break
                //
            default:
                  self?.scrollView?.setContentOffset(CGPoint.init(x: (self?.scrollView?.frame.size.width)!, y: 0), animated: true)
            }
         
            return nil
        }
        scrollView?.backgroundColor = UIColor.clear
        scrollView?.addSubview(vc.view)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: (self.scrollView?.frame.size.height)!)
        
        self.addChildViewController(vc)
        //
        let rvc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RegistVC") as! RegistVC
        self.scrollView?.addSubview(rvc.view)
        rvc.view.frame = CGRect.init(x:  vc.view.frame.size.width, y: 0, width: vc.view.frame.size.width, height: (self.scrollView?.frame.size.height)!)
        rvc.resultBlock = { [weak self](result) in
            switch result as! doStateClick {
            case .doResetPwd:
                
                let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FotgotPwdVC")
                self?.navigationController?.pushViewController(vc, animated: true)
                break
            //
            default:
                self?.scrollView?.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            }
           
            return nil
        }
        self.addChildViewController(rvc)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
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
