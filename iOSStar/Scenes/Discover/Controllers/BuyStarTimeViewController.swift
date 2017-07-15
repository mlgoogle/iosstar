//
//  BuyStarTimeViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import RealmSwift

class BuyStarTimeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!


    lazy var backView: UIView = {
        let view = UIView(frame: self.collectionView.frame)
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(effectView)
        return view
    }()
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "138415562044.jpg"))
        imageView.frame = CGRect(x: 50, y: 50
            , width: self.collectionView.frame.size.width - 100, height: self.collectionView.frame.size.height - 240)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var dataSouce:[StarSortListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
     
        requestStarList()
        backView.addSubview(backImageView)
        backView.sendSubview(toBack: backImageView)
        collectionView.backgroundView = backView
        collectionView.register(StarCardView.self, forCellWithReuseIdentifier: StarCardView.className())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func requestStarList() {
        let requestModel = StarSortListRequestModel()
        AppAPIHelper.discoverAPI().requestScrollStarList(requestModel: requestModel, complete: { (response) in
            
            if let models = response as? [StarSortListModel]{
                self.dataSouce = models
                self.collectionView.reloadData()
                self.perform(#selector(self.replaceBackImage(index:)), with: nil, afterDelay: 0.5)
                
            }
        }) { (error) in
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        if let indexPath = sender as? IndexPath {
            let model = dataSouce![indexPath.item]
            let vc = segue.destination
            if segue.identifier == "ToSelling" {
                if let sellingVC = vc as? SellingViewController {
                    sellingVC.starModel = model
                }
            } else {
                if let introVC = vc as? StarIntroduceViewController {
                    introVC.starModel = model
                }
            }
        }
        
    }
}

extension BuyStarTimeViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    


    
    func replaceBackImage(index:Int = 0) {
        
        let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? StarCardView
        
        
        backImageView.image = cell?.backImage
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x - 6) / 287
        replaceBackImage(index: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSouce?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCardView.className(), for: indexPath)
        if let card = cell as? StarCardView {
            
            card.setStarModel(starModel: dataSouce![indexPath.row])
        }
         return cell
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let starModel = dataSouce![indexPath.row]
//        var segueString = "ToSelling"
        var segueString = "StarNewsVC"
        switch starModel.pushlish_type {
        case 1:
            segueString = StarNewsVC.className()
        case 2:
            segueString = "ToIntroduce"
        default:
            break
        }
        performSegue(withIdentifier: segueString, sender: indexPath)

    }
}
