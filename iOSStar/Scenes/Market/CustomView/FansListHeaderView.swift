//
//  FansListHeaderView.swift
//  iOSStar
//
//  Created by J-bb on 17/5/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
protocol SelectFansDelegate {
    func selectAtIndex(index:Int)
}
class FansListHeaderView: UITableViewHeaderFooterView {
    
    var delegate:SelectFansDelegate?
    lazy var buyButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 2222
        button.setTitle("求购榜单", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitleColor(UIColor(hexString: "333333"), for: .normal)
        return button
    }()
    lazy var sellButton:UIButton = {
       let button = UIButton(type: .custom)
        button.tag = 2223
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        button.setTitle("转让榜单", for: .normal)
        button.setTitleColor(UIColor(hexString: "333333"), for: .normal)
        return button
    }()
    
    lazy var backView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(hexString: "ECECEC")
        return view
    }()
    
    lazy var imageView:UIImageView = {
       let imageView = UIImageView(image: UIImage.init(named: "8"))
        return imageView
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(buyButton)
        addSubview(sellButton)
        addSubview(backView)
        backView.addSubview(imageView)
        buyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenWidth / 4)
            make.centerY.equalTo(self)
        }
        sellButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenWidth / 4 * 3)
            make.centerY.equalTo(buyButton)
        }
        backView.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenWidth / 4)
            make.centerY.equalTo(buyButton)
            make.width.equalTo(110)
            make.height.equalTo(25)
        }
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(backView.snp.left)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.bottom.equalTo(backView.snp.bottom).inset(5)
        }
        bringSubview(toFront: buyButton)
        bringSubview(toFront: sellButton)
        buyButton.addTarget(self, action: #selector(selectAtIndex(sender:)), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(selectAtIndex(sender:)), for: .touchUpInside)
    }
    func selectAtIndex(sender:UIButton) {
        let index = sender.tag - 2222
        var x:CGFloat = 0.0
        if index == 0 {
            x = kScreenWidth * 0.25
        } else {
            x = kScreenWidth * 0.75
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.backView.center = CGPoint(x: x, y: self.backView.center.y)
            
        }) { (finished) in
            print(finished)
        }
        delegate?.selectAtIndex(index: index)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
