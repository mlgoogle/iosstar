//
//  StarIntroduceViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/7.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class StarIntroduceViewController: UIViewController {


    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var appointmentButton: UIButton!

    var sectionHeights = [170, 18, 140]
    var identifers = [StarIntroduceCell.className(), MarketExperienceCell.className(), StarPhotoCell.className()]
    var images = [UIImage(named: "138415562044.jpg"), UIImage(named: "138415562044.jpg")]
    
  
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PubInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: PubInfoHeaderView.className())
        appointmentButton.layer.shadowColor = UIColor(hexString: "cccccc").cgColor
        appointmentButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        appointmentButton.layer.shadowRadius = 1
        appointmentButton.layer.shadowOpacity = 0.5
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    @IBAction func askToBuy(_ sender: Any) {
    }

    @IBAction func appointmentAction(_ sender: Any) {
    }

}
extension StarIntroduceViewController:UITableViewDelegate, UITableViewDataSource,MenuViewDelegate, MWPhotoBrowserDelegate, UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 25 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)

        }
    }
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return 1
    }
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        let photo = MWPhoto(image: images[Int(index)]!)
        
        return photo
    }

    func menuViewDidSelect(indexPath: IndexPath) {
    

        let vc = PhotoBrowserVC(delegate: self)
        present(vc!, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
        case 1:
            return 70
        case 2:
            return 25
        default:
            return 0.01
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if  section == 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PubInfoHeaderView") as? PubInfoHeaderView
            header?.setTitle(title:"个人介绍")
            return header
        }
        
        return nil
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return identifers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 10
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sectionHeights[indexPath.section])
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifers[indexPath.section]!, for: indexPath)
        switch indexPath.section {
        case 2:
            if let photoCell = cell as? StarPhotoCell {
                photoCell.setImageUrls(images: ["11","11"], delegate:self)
            }
        default:
            break
        }
        return cell
    }
}
