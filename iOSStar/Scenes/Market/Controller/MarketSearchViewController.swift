//
//  MarketSearchViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/5/10.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import SVProgressHUD
class MarketSearchViewController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var searchTextField: UITextField!
    
    lazy var requestModel: MarketSearhModel = {
        let model = MarketSearhModel()
        return model
    }()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!
    var dataArry = [SearchResultModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        backView.layer.cornerRadius = 1
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        title = "搜索"
        searchTextField.addTarget(self , action:#selector(textfiledchange(_:)), for: .editingChanged)
        searchTextField.delegate = self
    }

    func textfiledchange(_ textField: UITextField){
        
        if textField.text == "" {
            dataArry.removeAll()
            tableView.reloadData()
            return
        }
        searchText(text: textField.text!)

    }
    
    func searchText(text:String) {
    
        requestModel.message = text

        AppAPIHelper.marketAPI().searchstar(requestModel: requestModel, complete: { [weak self](result) in
            if let models = result as? [SearchResultModel]{
                self?.dataArry = models
                self?.tableView.reloadData()
            }
        }) { (error) in
            self.dataArry.removeAll()
            self.tableView.reloadData()
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            dataArry.removeAll()
            tableView.reloadData()
            return false
        }
        searchText(text: textField.text!)
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MarketSearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        cell.update(dataArry[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyBoard = UIStoryboard(name: "Heat", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "HeatDetailViewController") as! HeatDetailViewController
        let starModel = StarSortListModel()
        let model = dataArry[indexPath.row]
        starModel.name = model.name
        starModel.symbol = model.symbol
        starModel.pic_tail = model.pic_tail
        vc.starListModel = starModel
        navigationController?.pushViewController(vc, animated: true)

    }
}
