//
//  StarInteractiveViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class StarInteractiveViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var dataSource:[StarSortListModel]?
    var imageNames:[String]?
    override func viewDidLoad() {
        super.viewDidLoad()

        configImageNames()
        requestStar()
    }
    
    func configImageNames()  {
        imageNames = []
        for index in 0...10 {
            imageNames?.append("starList_back\(index)")
        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            let model = dataSource![indexPath.item]
            let vc = segue.destination
            if segue.identifier == "InterToIntroduce" {
                if let introVC = vc as? StarIntroduceViewController {
                    introVC.starModel = model
                }
            }
        }
    }

}
extension StarInteractiveViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarInfoCell.className(), for: indexPath) as! StarInfoCell
        cell.setStarModel(starModel:dataSource![indexPath.row])
        cell.setBackImage(imageName: (imageNames?[indexPath.row % 10])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "InterToIntroduce", sender: indexPath)
    }
}
