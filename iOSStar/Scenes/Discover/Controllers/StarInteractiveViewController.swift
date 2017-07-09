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

    var imageNames:[String]?
    override func viewDidLoad() {
        super.viewDidLoad()

        configImageNames()
    }
    
    func configImageNames()  {
        imageNames = []
        for index in 0...10 {
            imageNames?.append("starList_back\(index)")
        }
    }
    
    func requestStar() {

    }


}
extension StarInteractiveViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarInfoCell.className(), for: indexPath) as! StarInfoCell
        cell.setBackImage(imageName: (imageNames?[indexPath.row % 10])!)
        return cell
    }
    
}
