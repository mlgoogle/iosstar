//
//  MarketCommentViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MJRefresh

protocol RefreshListDelegate {
    func refreshList(dataSource:[CommentModel]?, totalCount:Int)
}

class MarketCommentViewController: MarketBaseViewController, UITextFieldDelegate{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var currentY:CGFloat = 0
    var dataSource:[CommentModel]?
    var totalCount = 0
    var isDetail = true
    var isRefresh = true
    var header:MJRefreshNormalHeader?
    var footer:MJRefreshAutoNormalFooter?
    
    var refreshDelegate:RefreshListDelegate?
    

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
            tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 450))

        }
        registerNotification()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(NoDataCell.self, forCellReuseIdentifier: NoDataCell.className())
        tableView.estimatedRowHeight = 100
        requestCommentList()
        setupRefresh()


        
    }
    
    func setupRefresh() {
        header = MJRefreshNormalHeader(refreshingBlock: {
            self.isRefresh = true
            self.requestCommentList()
        })
        footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.isRefresh = false
            self.requestCommentList()
        })
        tableView.mj_header = header
        tableView.mj_footer = footer
        footer?.isHidden = true
    }
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    func keyboardWillShow(notification: NSNotification?) {
        let rect = notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        var y:CGFloat = -286.0
        if rect != nil {
        
            y = -rect!.size.height
        }
        UIView.animate(withDuration: 0.5) {
            self.view.frame = CGRect(x: self.view.frame.origin.x, y: y, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
    func endRefresh() {
        if header?.state == .refreshing {
            header?.endRefreshing()
        }
        if  footer?.state == .refreshing {
            footer?.endRefreshing()
        }
    }
    
    func requestCommentList() {

        guard starCode != nil else {
            return
        }
        let requestModel = CommentListRequestModel()
        requestModel.symbol = starCode!
        if !isRefresh {
            requestModel.startPos = dataSource?.count ?? 0
        }
        AppAPIHelper.marketAPI().requestCommentList(requestModel: requestModel, complete: { (response) in
            self.endRefresh()
            if let dict = response as? [String : Any] {
                let array:[Any]? = dict["commentsinfo"] as? [Any]
                if let totalCount = dict["total_count"] as? Int {
                    self.totalCount = totalCount
                }
                if array != nil  {
                    let responseObject = try! OEZJsonModelAdapter.models(of: CommentModel.self, fromJSONArray: array) as AnyObject?
                    let models = responseObject as! [CommentModel]
                    if self.isRefresh {
                        self.dataSource = models
                    } else {
                        self.dataSource?.append(contentsOf: models)
                    }
                    if models.count == 10 {
                        self.footer?.isHidden = false
                    }
                    self.tableView.reloadData()
                }
            }
            if self.dataSource?.count ?? 0 == 0 {
                self.addNodataButton()
            }
            self.refreshDelegate?.refreshList(dataSource: self.dataSource, totalCount: self.totalCount)
        }) { (error) in
            self.addNodataButton()
        }
        
    }
    func addNodataButton() {
        endRefresh()

    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return checkLogin()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.endEditing(true)
        if textField.text != nil {
            sendComment(commentText: textField.text!)
        }
        textField.text = ""

        return true
    }
    
    func sendComment(commentText:String) {
    
        guard starCode != nil && commentText != "" else {
            return
        }
        let requestModel = SendCommentModel()
        requestModel.comments = commentText
        requestModel.symbol = starCode!
        AppAPIHelper.marketAPI().sendComment(requestModel: requestModel, complete: { (response) in
            self.header?.beginRefreshing()
        }) { (error) in
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MarketCommentViewController:UITableViewDataSource, UITableViewDelegate, RefreshListDelegate{
    
    func refreshList(dataSource: [CommentModel]?, totalCount:Int) {
        self.dataSource = dataSource
        self.totalCount = totalCount
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource?.count ?? 0 == 0 {
            
            return 500
        }
        
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if dataSource?.count ?? 0  == 0 {
            return nil
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MarketDetailCommentHeaderView.className())  as? MarketDetailCommentHeaderView
        header?.contentView.backgroundColor = UIColor(hexString: "FAFAFA")
        header?.setCount(count: totalCount)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataSource?.count ?? 0 == 0 {
            return 0.001
        }
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataSource?.count ?? 0 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.className(), for: indexPath) as! NoDataCell
            
            cell.setImageAndTitle(image: UIImage(named: "nodata_comment"), title: "当前没有相关评论")
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCommentCell", for: indexPath) as! MarketCommentCell
        cell.setData(model: dataSource![indexPath.row])
        return cell 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToDetail()
    }
    
    func pushToDetail() {
        
        if !isDetail {
            if checkLogin() {
                textField.becomeFirstResponder()
            }
        } else {
            let vc = MarketCommentViewController.storyboardInit(identifier:MarketCommentViewController.className(), storyboardName:AppConst.StoryBoardName.Markt.rawValue) as? MarketCommentViewController
            vc?.isDetail = false
            vc?.isSubView = false
            vc?.refreshDelegate = self
            vc?.starCode = starCode
            guard vc != nil else {
                return
            }
            parent?.navigationController?.pushViewController(vc!, animated: true)
        }

    }
}
