//
//  StarDetailCirCell.swift
//  iOSStar
//
//  Created by sum on 2017/9/1.
//  Copyright © 2017年 YunDian. All rights reserved.
//
protocol StarDetailCirCellDelegate {
    
    func showBigImg(_select : CircleListModel)
    
}
class StarDetailCirCell: UITableViewCell ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    @IBOutlet var collectView: UICollectionView!
    var delegate :StarDetailCirCellDelegate?

    var datasource : StarDetailCircle?{
        didSet{
            collectView?.reloadData()
            
        }
        
    }
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
        
       
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let data = datasource?.circles?[indexPath.row]{
            delegate?.showBigImg(_select: data)
        }
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = CGFloat.init(leftConstant)
        layout.minimumInteritemSpacing = CGFloat.init(leftConstant)
        layout.itemSize = CGSize.init(width: (kScreenWidth - 15 * 3)/2.0, height:  120 )
        self.collectView.collectionViewLayout = layout
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
}
}
