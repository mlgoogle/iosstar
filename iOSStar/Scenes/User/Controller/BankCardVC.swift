//
//  BankCardVC.swift
//  wp
//
//  Created by sum on 2017/1/11.
//  Copyright © 2017年 com.yundian. All rights reserved.
//

import SVProgressHUD

class BindingBankVCCell: OEZTableViewCell {
    // 银行名称
    @IBOutlet weak var bankName: UILabel!
    // 银行名称
    @IBOutlet weak var cardNum: UILabel!
     @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var banklogo: UIImageView!
    @IBOutlet weak var close: UIButton!
    // 刷新cell
    override func update(_ data: Any!) {
        
        if let model = data as? BankListModel{
        
            let dataModel = BankCardListRequestModel()
            dataModel.cardNo = model.cardNo
            AppAPIHelper.user().bankcardifo(requestModel: dataModel, complete: { [weak self](result) in
                if let dataBank =  result as? BankInfo{
                self?.bankName.text = dataBank.bankName
                self?.cardType.text = dataBank.cardName
                }
                
            }, error: { (error) in
                
            })
            bankName.text = model.bank
            
            let index = model.cardNo.index(model.cardNo.startIndex,  offsetBy: 4)
            let index1 = model.cardNo.index(model.cardNo.startIndex,  offsetBy: model.cardNo.length()-3)
            cardNum.text =  model.cardNo.substring(to: index) + "  ****   ****   *** " + model.cardNo.substring(from: index1)
          
        }
    }
    @IBAction func close(_ sender: Any) {
//       didSelectRowAction(5, data: nil)
    }
}

class BankCardVC: BasePageListTableViewController {

    var dataArry = [BankListModel]()
    override func viewDidLoad() {
        
        self.title = "我的银行卡"
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
     
    }
  
    override func didRequest(_ pageIndex: Int) {
        let model = BankCardListRequestModel()
        AppAPIHelper.user().bankcardList(requestModel: model, complete: { [weak self](result) in
            if let model =  result as? BankListModel{
                if (self?.dataArry.count)!>0{
                  self?.dataArry.removeAll()
                }
               self?.dataArry.append(model)
               self?.didRequestComplete( self?.dataArry as AnyObject)
               self?.tableView.reloadData()
            }
         
        }) { (error ) in
            self.didRequestError(error)
        }
    }
     //MARK:- tableView的代理和数据源的设置
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCardVCCell") as! BindingBankVCCell
        let model = self.dataArry[indexPath.row]
        cell.update(model as AnyObject)
        cell.close.addTarget(self, action: #selector(deletebank), for: .touchUpInside)
        return cell
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .normal, title: "删除") { action, index  in
            self.deletebank()
            tableView.reloadData()
        }
        share.backgroundColor = UIColor.init(hexString: "F98D8D")
        return [share]
    }
   //MARK:- 删除银行卡
    func deletebank(){
        let model = UnbindCardListRequestModel()
        
        AppAPIHelper.user().unbindcard(requestModel: model, complete: { (resule) in
            SVProgressHUD.showSuccessMessage(SuccessMessage: "解绑成功", ForDuration: 2, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }) { (error ) in
            self.didRequestError(error)
        }
    }

    
 
}
