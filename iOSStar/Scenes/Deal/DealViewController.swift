//
//  DealViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

import UIKit

class DealViewController: UIViewController ,UIScrollViewDelegate{

    // 定义一个scrollview
    var scrollView : UIScrollView?
    // 定义一个scrollview
    var line : UILabel?
    // 定义一个scrollview
    var selectBtn : UIButton?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "买卖"
        initscrollView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: -- 设置scrollView
    func initscrollView(){
        self.automaticallyAdjustsScrollViewInsets = false;
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y:  31, width: self.view.frame.size.width, height: self.view.frame.size.height - 64-44-32))
        scrollView?.contentSize = CGSize.init(width: self.view.frame.size.width * 5, height: 0)
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
        for i in 0...4 {
            let vi = UIView.init(frame: CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!)))))
            let lb = UILabel.init(frame: CGRect.init(x: 30, y:vi.frame.size.height - 100, width: 100, height: 100))
            lb.text = "123"
            lb.backgroundColor = UIColor.yellow
            vi.addSubview(lb)
            vi.backgroundColor = UIColor.blue
            if i == 4{
            
                let story = UIStoryboard.init(name: "Deal", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "DetailTableViewVC")
                scrollView?.addSubview(vc.view)
                vc.view.frame =  CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!))))
              self.addChildViewController(vc)
            }
         else   if i == 1{
                
                let story = UIStoryboard.init(name: "Deal", bundle: nil)
                let vc : BuyVC = story.instantiateViewController(withIdentifier: "BuyVC") as! BuyVC
                vc.isSellout = true
                scrollView?.addSubview(vc.view)
                vc.view.frame =  CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!))))
                self.addChildViewController(vc)
            }
            else   if i == 0{
                
                let story = UIStoryboard.init(name: "Deal", bundle: nil)
                let vc : BuyVC = story.instantiateViewController(withIdentifier: "BuyVC") as! BuyVC
                vc.isSellout = false
                scrollView?.addSubview(vc.view)
                vc.view.frame =  CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!))))
                self.addChildViewController(vc)
            }
            else   if i == 2{
                
                let story = UIStoryboard.init(name: "Deal", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "OrderListVC")
                scrollView?.addSubview(vc.view)
                vc.view.frame =  CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!))))
                self.addChildViewController(vc)
            }
            else   if i == 3{
                
                let story = UIStoryboard.init(name: "Deal", bundle: nil)
                let vc = story.instantiateViewController(withIdentifier: "AlreadyBuyVC")
                scrollView?.addSubview(vc.view)
                vc.view.frame =  CGRect.init(x: (CGFloat.init(i)) * (self.view.frame.size.width), y: 0, width: self.view.frame.size.width, height: ((CGFloat.init((scrollView?.frame.size.height)!))))
                self.addChildViewController(vc)
            }
            else{
             scrollView?.addSubview(vi)
            }
           
           
        }
        view.addSubview(scrollView!)
        let arr = ["购买","转让","订单","已购","明细"]
        
        for i in 0...4 {
            let btn = UIButton.init()
            btn.frame = CGRect.init(x: (CGFloat.init(i))*(self.view.frame.size.width)/5.0, y: 0, width: (self.view.frame.size.width)/5.0, height: 28)
            btn.setTitle(arr[i], for: .normal)
            self.view.addSubview(btn)
            btn.backgroundColor = UIColor.white
            btn.setTitleColor(UIColor.gray, for: .normal)
            btn.setTitleColor(UIColor.blue, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(doclick(_:)), for: .touchUpInside)
            btn.tag = 1000 + i
            
            if i == 0{
             line = UILabel.init(frame: CGRect.init(x: 0, y: 93, width: (self.view.frame.size.width)/5.0 - 20, height: 1))
             line?.backgroundColor = UIColor.gray
             view.addSubview(line!)
             line?.center = CGPoint.init(x: btn.center.x, y: btn.center.y + 14)
             selectBtn = btn
             btn.isSelected = true
            }
        }
    }

    func doclick(_ anyobject : UIButton){
         selectBtn?.isSelected = false
         anyobject.isSelected = true
         line?.center = CGPoint.init(x: anyobject.center.x, y: anyobject.center.y + 14)
         selectBtn = anyobject
       scrollView?.setContentOffset(CGPoint.init(x: CGFloat.init((anyobject.tag - 1000)) * self.view.frame.size.width, y: 0), animated: true)
        
    }
      //MARK: -- scrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        selectBtn?.isSelected = false
        let aa : Int = Int.init(scrollView.contentOffset.x / view.frame.size.width)
        let btn : UIButton =  view.viewWithTag( aa + 1000) as! UIButton
        btn.isSelected = true
        line?.center = CGPoint.init(x: btn.center.x, y: btn.center.y + 14)
        selectBtn = btn
    }


}
