
//
//  RechargeListModel.swift
//  iOSStar
//
//  Created by sum on 2017/5/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
//  充值详情Model
class RechargeDetailModel: BaseModel {
    
    
    // 充值订单流水号
    var rid: Int64 = 0
    // 用户id
    var id: Int64 = 0
    //充值金额
    var amount: Double = 0
    // 入金时间
    var depositTime: String = ""
    // 入金方式 1.微信 2.银行卡
    var depositType: Int8 = 0
    //  微信
    var depositName: String?
    //  1-处理中，2-成功，3-失败
    var status: Int8 = 0
    
}

class  RechargeListModel: BaseModel {
    
    //返回的列表的key
    var depositsinfo : [Model]?
    
    class func depositsinfoModelClass() ->AnyClass {
        return  Model.classForCoder()
    }
    
}

// 返回充值列表的Model
class Model: BaseModel {
    
    //返回的列表的key
    var rid: Int64 = 0             // 充值订单流水号
    var id: Int64 = 0              // 用户id
    var depositTime : String = ""   // 入金时间
    var depositType: Int8 = 0      // 入金方式 1.微信 2.银行卡
    var depositName: String?       // 微信
    var status: Int8 = 0           // 1-处理中，2-成功，3-失败
    var money : String?            //  金额
    var amount: Double = 0        // jine
    // 交易类型 0-充值记录 1-约见记录 2-聊天记录
    var recharge_type  : Int8 = 0
    // 明星的代码
    var transaction_id : String = ""
    
}
class WithDrawResultModel: BaseModel {
      var result = 0
    
}
class WithdrawModel: BaseModel {
    
    var wid: Int64 = 0           // 提现订单流水号
    var uid: Int64 = 0           // 用户id
    var amount: Double = 0       // 提现金额
    var charge: Int64 = 0        // 提现手续费
    var withdrawTime : String = ""  // 提现时间
    var handleTime: Int64 = 0    //提现时间
    var bank: String!            // 银行名称
    var branchBank: String!      //支行名称
    var province: String!        // 	省
    var city: String!            // 	城市
    var cardNo: String!          // 	银行卡号
    var name: String!            // 姓名
    var comment: String!         //	备注
    var status: Int8 = 0        // 状态	1-处理中，2-成功，3-失败
    var expectTime: String!        // 	省
    
    
}
// 提现列表的listmodel
class WithdrawListModel: BaseModel {
    
    var withdrawList : [WithdrawModel]!
    
    class func withdrawListModelClass() ->AnyClass {
        return  WithdrawModel.classForCoder()
    }
    
    
}
