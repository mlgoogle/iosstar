//
//  StarDetailCirCell.swift
//  iOSStar
//
//  Created by sum on 2017/9/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//
class StarDetailCirCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet var collectView: UICollectionView!
    var datasource : StarDetailCircle?{
        didSet{
            collectView?.reloadData()
            
        }
        
    }
    var delegate : StarDynamicCellDelegate?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarDynamicVideoCell", for: indexPath) as! StarDynamicVideoCell
        cell.Qimg.image = UIImage(named: "novideo")
        if let data = datasource?.circles?[indexPath.row]{
            cell.qtitle.text = data.content
            cell.qtitle.textAlignment = .center
            cell.Qimg.kf.setImage(with: URL(string : ShareDataModel.share().qiniuHeader + (data.pic_url_tail)), placeholder: UIImage(named: "novideo"), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            cell.qtitle.text = ""
          
            
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if datasource?.circles != nil{
            if (datasource?.circles?.count)! > 2 {
              return 2
            }
            return (datasource?.circles?.count)!
        }
        return 2
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = CGFloat.init(leftConstant)
        layout.minimumInteritemSpacing = CGFloat.init(leftConstant)
        layout.itemSize = CGSize.init(width: (kScreenWidth - 15 * 3)/2.0, height: (kScreenWidth - 20 * 3)/3.0 )
        self.collectView.collectionViewLayout = layout
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
}
}
