//
//  HHEmojiKeyboard.swift
//  HHEmojiKeyboard
//
//  Created by xoxo on 16/6/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

let HHEmojiKeyboard_Column:CGFloat = 7

// MARK: - HHEmojiKeyboardDelegate 协议
protocol HHEmojiKeyboardDelegate:NSObjectProtocol {
    /**
     点击选择表情
     
     - parameter emojiKeyboard: emoji键盘
     - parameter emoji:         emoji表情
     */
    func emojiKeyboard(_ emojiKeyboard:HHEmojiKeyboard,didSelectEmoji emoji:String)
    
    /**
     点击删除按钮
     
     - parameter emojiKeyboard: emoji键盘
     */
    func emojiKeyboardDidSelectDelete(_ emojiKeyboard:HHEmojiKeyboard)
    
    /**
     翻页
     
     - parameter emojiKeyboard: emoji键盘
     - parameter pageIndex:     页面的下标从0开始
     */
    func emojiKeyboard(_ emojiKeyboard:HHEmojiKeyboard,scrollDidTo pageIndex:Int)
}

class HHEmojiKeyboard: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
     /// 数据源
    var dataArr:NSArray!
     /// 是否显示删除按钮
    var delete:Bool = false
     /// 协议
    weak var emojiKeyboardDelegate:HHEmojiKeyboardDelegate?
     /// 每页emoji表情的总数,这里加上了删除按钮
    var pageEmojiCount:Int!{
        get{
            /// 行数
            let line = self.frame.size.height / (self.frame.width / HHEmojiKeyboard_Column)
            /// 一页的表情数
            let pageEmojiCount = Int(line) * Int(HHEmojiKeyboard_Column)
            return pageEmojiCount
        }
    }
    var sections = 0
    
    /**
     构造方法
     
     - parameter frame:  位置大小
     - parameter layout: 布局
     - parameter arr:    [String]数据,需要处理
     - parameter delete: 是否显示删除按钮
     
     - returns: HHEmojiKeyboard实例
     */
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout ,stringArr arr:NSArray!,isShowDelete delete:Bool) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(HHEmojiKeyboardCell.self, forCellWithReuseIdentifier: "HHEmojiKeyboardCell")
        self.register(HHImageKeyboardCell.self, forCellWithReuseIdentifier: "HHImageKeyboardCell")
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.delete = delete
        self.dataArr = arr
    }
    
    /**
     构造方法
     
     - parameter frame:  位置大小
     - parameter layout: 布局
     - parameter arr:    分组数据
     - parameter delete: 是否显示删除按钮
     
     - returns: HHEmojiKeyboard实例
     */
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout ,groupingArr arr:NSArray!,isShowDelete delete:Bool){
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(HHEmojiKeyboardCell.self, forCellWithReuseIdentifier: "HHEmojiKeyboardCell")
        self.register(HHImageKeyboardCell.self, forCellWithReuseIdentifier: "HHImageKeyboardCell")
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.delete = delete
        self.dataArr = arr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.pageEmojiCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HHImageKeyboardCell", for: indexPath) as!  HHImageKeyboardCell
        let emojiIndex = indexPath.section * pageEmojiCount + indexPath.row
        if emojiIndex < dataArr.count{
            if let emojiDic = dataArr[emojiIndex] as? NSDictionary{
                if let imageName = emojiDic["file"] as? String{
                    let emojiImage = getEmojiImage(imageName)
                    cell.imgView.image = emojiImage
                }
            }
        }
        return cell
    }
    
    func getEmojiImage(_ imageName: String) -> UIImage?{
        if let bundlePath = Bundle.main.path(forResource: "NIMKitEmoticon", ofType: "bundle"){
            let imageStr = NSString.init(string: imageName)
            let resultImage = imageStr.substring(to: imageName.length() - 4 ).appending("@2x.png")
            if let path = Bundle.init(path: bundlePath)?.path(forResource: resultImage, ofType: nil, inDirectory: "Emoji"){
                return UIImage.init(contentsOfFile: path)
            }
            
        }
        return nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
//        return self.dataArr.count
        let oldSections = dataArr.count/pageEmojiCount
        sections = dataArr.count%pageEmojiCount == 0 ? oldSections : oldSections + 1
        return sections
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        if let delegate = self.emojiKeyboardDelegate {
//            if let cell = collectionView.cellForItem(at: indexPath){
//                if cell.isKind(of: HHEmojiKeyboardCell.self){
//                    if let content = (cell as! HHEmojiKeyboardCell).emojiLabel.text {
//                        if content.characters.count > 0{
//                            delegate.emojiKeyboard(self, didSelectEmoji: content)
//                        }
//                    }
//                }else if cell.isKind(of: HHImageKeyboardCell.self){
//                    delegate.emojiKeyboardDidSelectDelete(self)
//                }
//            }
//        }
        if let delegate = self.emojiKeyboardDelegate {
            let emojiIndex = indexPath.section * pageEmojiCount + indexPath.row
            if emojiIndex < dataArr.count{
                if let emojiDic = dataArr[emojiIndex] as? NSDictionary{
                    if let imageTag = emojiDic["tag"] as? String{
                        delegate.emojiKeyboard(self, didSelectEmoji: imageTag)
                    }
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
        return CGSize(width: self.frame.size.width / HHEmojiKeyboard_Column, height: self.frame.size.width / HHEmojiKeyboard_Column)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        return CGSize.zero
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if Int(scrollView.contentOffset.x)%Int(scrollView.frame.size.width) > 0 {
            page += 1
        }
        if let delegate = self.emojiKeyboardDelegate {
            delegate.emojiKeyboard(self, scrollDidTo: page)
        }
    }
    // MARK: - 分组
    func grouping(_ arr:NSArray!){
//        var pageEmojiCount = self.pageEmojiCount
//        if self.delete {
//            pageEmojiCount = pageEmojiCount! - 1
//        }
//        
//        var pageNumber:Int = arr.count / pageEmojiCount!
//        if arr.count%pageEmojiCount! > 0 {
//            pageNumber += 1
//        }
//        self.dataArr = []
//        var emojis:NSMutableArray = []
//        
//        for i in 0..<pageNumber {
//    
//            for j in 0..<pageEmojiCount! {
//                if i*pageEmojiCount! + j >= arr.count {
//                    break
//                }
//                
//            }
////            self.dataArr.append(emojis)
//        }
    }
}
