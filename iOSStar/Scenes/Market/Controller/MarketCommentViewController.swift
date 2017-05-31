//
//  MarketCommentViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class MarketCommentViewController: MarketBaseViewController {
    @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var currentY:CGFloat = 0
    
    var isDetail = true
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = tableView
        automaticallyAdjustsScrollViewInsets = false
        setCustomTitle(title: "评论")
        tableView.register(MarketDetailCommentHeaderView.self, forHeaderFooterViewReuseIdentifier: MarketDetailCommentHeaderView.className())
        requestCommentList()
        if isDetail {
            bottomMargin.constant = 0
            inputViewHeight.constant = 0
        }
        registerNotification()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func keyboardWillShow(notification: NSNotification?) {
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -286, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    func keyboardWillHide(notification: NSNotification?) {
        
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func requestCommentList() {
        guard starCode != nil else {
            return
        }
        AppAPIHelper.marketAPI().requestCommentList(starcode: starCode!, complete: { (resonse) in
            
            
        }, error: errorBlockFunc())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MarketCommentViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MarketDetailCommentHeaderView.className())
        header?.contentView.backgroundColor = UIColor(hexString: "FAFAFA")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCommentCell", for: indexPath)
        
        return cell 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = MarketCommentViewController.storyboardInit(identifier:MarketCommentViewController.className(), storyboardName:AppConst.StoryBoardName.Markt.rawValue) as? MarketCommentViewController
        vc?.isDetail = false
        vc?.isSubView = false
        guard vc != nil else {
            return
        }
        parent?.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
