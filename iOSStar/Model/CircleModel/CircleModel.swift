//
//  CircleModel.swift
//  iOSStar
//
//  Created by J-bb on 17/7/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation
import RealmSwift
import YYText


class CircleListModel: Object {
    dynamic var symbol = ""
    dynamic var symbol_name = ""
    dynamic var head_url = ""
    dynamic var circle_id:Int64 = 0
    dynamic var create_time:Int64 = 0
    dynamic var content = ""
    dynamic var pic_url = ""
    dynamic var approve_dec_time = 0
    dynamic var comment_dec_time = 0
    let approve_list = List<ApproveModel>()
    let comment_list = List<CircleCommentModel>()
    
    var headerHeight: CGFloat = 0.0
    var thumbUpHeight: CGFloat = 0.0
    var approveName = ""
    
    func caclulateHeight() {
        //计算顶部文案高度
        let contentAttribute = NSMutableAttributedString.init(string: content)
        contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: content.length()))
        let size  = CGSize.init(width: kScreenWidth - 80, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
        headerHeight =  layout!.textBoundingSize.height + 300
        //计算点赞文案高度
        for approve in approve_list{
            approveName += "\(approve.user_name),"
        }
        let approveAttribute = NSMutableAttributedString.init(string: approveName)
        approveAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: approveName.length()))
        let approveSize  = CGSize.init(width: kScreenWidth - 112, height: CGFloat.greatestFiniteMagnitude)
        let approveLayout = YYTextLayout.init(containerSize: approveSize, text: approveAttribute)
        thumbUpHeight = approveLayout!.textBoundingSize.height + 20
        for model in comment_list{
            model.calculateHeight()
            model.symbol_name = symbol_name
        }
        
    }
}
class ApproveModel: Object {
    dynamic var user_name = ""
    dynamic var uid:Int64 = 0
}
class CircleCommentModel: Object {
    dynamic var uid = 0
    dynamic var user_name = ""
    dynamic var direction = 0
    dynamic var content = ""
    dynamic var priority = 0
    
    var symbol_name = ""
    var circleHeight: CGFloat = 0
    
    func calculateHeight() {
        //计算顶部文案高度
        var comment = "\(user_name):\(content)"
        if direction == 1{
            comment = "\(symbol_name)回复\(user_name):\(content)"
        }
        if direction == 2{
            comment = "\(user_name)回复\(symbol_name):\(content)"
        }
        let contentAttribute = NSMutableAttributedString.init(string: comment)
        contentAttribute.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: comment.length()))
        let size  = CGSize.init(width: kScreenWidth - 80, height: CGFloat.greatestFiniteMagnitude)
        let layout = YYTextLayout.init(containerSize: size, text: contentAttribute)
        circleHeight =  layout!.textBoundingSize.height + 16
    }
}
class SendCircleResultModel: Object {
    dynamic var circle_id = 0
}

class ResultModel: BaseModel{
    var result = 0
    
}
