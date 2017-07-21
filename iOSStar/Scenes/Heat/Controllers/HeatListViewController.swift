//
//  HeatListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/11.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class HeatListViewController: BasePageListTableViewController {
    var imageNames:[String]?
//    var dataSource:[StarSortListModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        configImageNames()
        requestStar()
        setupNav()
    }

    override func didRequest(_ pageIndex: Int) {
        let requestModel = StarSortListRequestModel()
         requestModel.pos = Int64((pageIndex - 1) * 10)
        requestModel.count = 10
        AppAPIHelper.discoverAPI().requestStarList(requestModel: requestModel, complete: { (response) in
            if let models = response as? [StarSortListModel] {
              
               self.didRequestComplete(models as AnyObject )
                self.tableView.reloadData()
            }
            
        }) { (error) in
            self.didRequestComplete(nil )
        }
    }
    func requestStar() {
        
      
        
    }
    @IBAction func searchAction(_ sender: Any) {
        let stroyBoard = UIStoryboard(name: AppConst.StoryBoardName.Markt.rawValue, bundle: nil)
        let vc =  stroyBoard.instantiateViewController(withIdentifier: MarketSearchViewController.className())
        navigationController?.pushViewController(vc, animated: true)
    }
    func configImageNames()  {
        imageNames = []
        for index in 0...10 {
            imageNames?.append("starList_back\(index)")
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeatListCell.className(), for: indexPath) as! HeatListCell
        cell.update(dataSource![indexPath.row])
        cell.setBackImage(imageName: (imageNames?[indexPath.row % 10])!)
        return cell
    }
    func setupNav() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named:"white_back"), for: .normal)
        button.tintColor = UIColor.white
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let item = UIBarButtonItem(customView: button)
        navigationItem.backBarButtonItem = item
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        self.performSegue(withIdentifier: "ToDeal", sender: indexPath)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDeal" {
            let indexPath = sender as! IndexPath
            if let vc = segue.destination as? HeatDetailViewController {

                vc.imageName = imageNames![indexPath.row % 10]
                vc.starListModel = dataSource![indexPath.row] as? StarSortListModel

            }
            
        }
    }




}
