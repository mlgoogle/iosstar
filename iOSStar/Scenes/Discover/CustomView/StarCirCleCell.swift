//
//  StarCirCleCell.swift
//  iOSStar
//
//  Created by sum on 2017/8/15.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol StarCirCleCellDelegate {
    
    func starask()
    func voice()
    func staractive()
    
}
class StarCirCleCell: UITableViewCell ,UICollectionViewDelegate ,UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectViewCell", for: indexPath)
        return cell
    }

   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }


    @IBOutlet var collectView: UICollectionView!
    var delegate : StarCirCleCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
 
    @IBAction func ask(sender: AnyObject) {
        delegate?.starask()
    }
   
    @IBAction func voice(sender: AnyObject) {
         delegate?.voice()
    }
    @IBAction func staractive(sender: AnyObject) {
         delegate?.staractive()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension StarCirCleCell  {

}

