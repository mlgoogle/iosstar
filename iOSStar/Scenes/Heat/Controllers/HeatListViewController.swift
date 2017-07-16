//
//  HeatListViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/11.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class HeatListViewController: UITableViewController {
    var imageNames:[String]?
    var dataSource:[StarSortListModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        configImageNames()
        requestStar()
        
    }
    
    func requestStar() {
        
        let requestModel = StarSortListRequestModel()
        AppAPIHelper.discoverAPI().requestStarList(requestModel: requestModel, complete: { (response) in
            if let models = response as? [StarSortListModel] {
                self.dataSource = models
                self.tableView.reloadData()
            }
            
        }) { (error) in
            
        }
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "ToDeal", sender: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
