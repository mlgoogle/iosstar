//
//  BuyStarTimeViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/7/6.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
class BuyStarTimeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!


    lazy var backView: UIView = {
        let view = UIView(frame: self.collectionView.frame)
        let imageView = UIImageView(image: UIImage(named: "138415562044.jpg"))
        imageView.frame = CGRect(x: 50, y: 50
            , width: view.frame.size.width - 100, height: view.frame.size.height - 240)
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(imageView)
        view.addSubview(effectView)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView.backgroundView = backView
        collectionView.register(StarCardView.self, forCellWithReuseIdentifier: StarCardView.className())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension BuyStarTimeViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StarCardView.className(), for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToSelling", sender: nil)
        
    }
}
