//
//  iOSStarTest.swift
//  iOSStarTest
//
//  Created by mu on 2017/7/19.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import XCTest
@testable import iOSStar

class iOSStarTest: XCTestCase {

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    func ytimeTest(_ funName:String, handle: CompleteBlock) {
        let startTime = Date.nowTimestemp()
        handle(nil)
        let endTime = Date.nowTimestemp()
        let marginTime = endTime - startTime
        if let path = Bundle.main.path(forResource: "ytest", ofType: "plist"){
            if let dic = NSMutableDictionary.init(contentsOfFile: path){
                dic.setValue(marginTime, forKey: funName)
                dic.write(toFile: path, atomically: true)
            }
        }
        
    }
    
     //请求明星明细
    func testStarList() {
        ytimeTest("testStarList", handle: { _ in
            let expectOption = expectation(description: "请求明星明细")
            let param = StarSortListRequestModel ()
           AppAPIHelper.discoverAPI().requestStarList(requestModel: param, complete: { (result) in
            if let object = result as? [StarSortListRequestModel] {
                if object.count > 0 {
                    expectOption.fulfill()
                }
            }
           }, error: nil)
            
        })
    }
    
    //抢购明星列表
    func testscrollStarList() {
        ytimeTest("ScrollStarList", handle: { _ in
            let expectOption = expectation(description: "滚动明星明细")
            let param = StarSortListRequestModel()
            AppAPIHelper.discoverAPI().requestScrollStarList(requestModel: param, complete: { (result) in
                if let object = result as? [StarSortListRequestModel]{
                    if object.count > 0 {
                        expectOption.fulfill()
                    }
                    
                }
            }, error: nil)
        })
    }
    
//     //请求剩余时间
    func testBuyRemainingTime(){
        ytimeTest("BuyRemainingTime", handle: { _ in
            let expectOption = expectation(description: "请求剩余时间")
            let param = BuyRemainingTimeRequestModel()
            AppAPIHelper.discoverAPI().requestBuyRemainingTime(requestModel: param, complete: { (result) in
                if let object = result as? BuyRemainingTimeModel{
                    if object.remainingTime > 0 {
                        expectOption.fulfill()
                    }
                }
            }, error: nil)
            
        })
    }
//
//     //抢购明星信息
    func testBuyStarInfo(){
        ytimeTest("BuyStarInfo", handle: { _ in
            let expectOption = expectation(description: "抢购明星信息")
            let param = PanicBuyRequestModel()
            AppAPIHelper.discoverAPI().requsetPanicBuyStarInfo(requestModel: param, complete: { (result) in
                if let object = result as? PanicBuyInfoModel {
                    if object.star_code != "" {
                        expectOption.fulfill()
                    }
                }
            }, error: nil)
            
        })
    }
//
//     //明星介绍页信息
    func testDetailInfo(){
        ytimeTest("DetailInfo", handle: { _ in
            let expectOption = expectation(description: "明星介绍页信息")
            let param = StarDetaiInfoRequestModel()
            AppAPIHelper.discoverAPI().requestStarDetailInfo(requestModel: param, complete: { (result) in
                if let object = result as? StarIntroduceResult {
                    
                    if object.resultvalue?.star_code != "" {
                        
                        expectOption.fulfill()
                        
                    }
                }
            }, error: nil)
            
        })
    }

//  // 获得弹幕数据
    func testBarrage() {
        ytimeTest("testBarrage", handle: { _ in
            let exceptOption = expectation(description: "弹幕测试")
            let param = HeatBarrageModel()
            param.count = 50
            param.pos = 0
            AppAPIHelper.marketAPI().requstBuyBarrageList(requestModel: param, complete: { (result) in
              if let model = result as? BarrageInfo {
                
                    if model.barrage_info != nil {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
           waitForExpectations(timeout: 15, handler: nil)
        })
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testCircleList() {
        ytimeTest("testCircleList", handle: { _ in
            let exceptOption = expectation(description: "朋友圈")
            let param = CircleListRequestModel()
            param.count = 50
            param.pos = 0
            AppAPIHelper.circleAPI().requestCircleList(requestModel: param, complete: { (result) in
                if let model = result as? [CircleListModel] {
                    if model .count > 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //评论动态
    func testcommentCircle() {
        ytimeTest("commentCircle", handle: { _ in
            let exceptOption = expectation(description: "朋友圈")
            let param = CommentCircleModel()
            AppAPIHelper.circleAPI().commentCircle(requestModel: param, complete: { (result) in
                if let model = result as? ResultModel {
                    if model.result == 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //明星朋友圈
    func teststarCommentCircle() {
        ytimeTest("teststarCommentCircle", handle: { _ in
            let exceptOption = expectation(description: "明星朋友圈朋友圈")
            let param = CommentCircleModel()
            AppAPIHelper.circleAPI().starCommentCircle(requestModel: param, complete: { (result) in
                if let model = result as? ResultModel {
                    if model.result == 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
     //点赞动态
    func testapproveCircle() {
        ytimeTest("testapproveCircle", handle: { _ in
            let exceptOption = expectation(description: "点赞动态")
            let param = ApproveCircleModel()
            AppAPIHelper.circleAPI().approveCircle(requestModel: param, complete: { (result) in
                if let model = result as? ResultModel {
                    if model.result == 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    //发送动态
    func testsendCircle() {
        ytimeTest("testsendCircle", handle: { _ in
            let exceptOption = expectation(description: "发送动态")
            let param = SendCircleRequestModel()
            AppAPIHelper.circleAPI().sendCircle(requestModel: param, complete: { (result) in
                if let model = result as? SendCircleResultModel {
                    if model.circle_id != 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //删除动态
    func testdeleteCircle() {
        ytimeTest("testdeleteCircle", handle: { _ in
            let exceptOption = expectation(description: "删除动态")
            let param = DeleteCircle()
            AppAPIHelper.circleAPI().deleteCircle(requestModel: param, complete: { (result) in
                if let model = result as? ResultModel {
                    if model.result == 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //所有订单
  func testallorder() {
        ytimeTest("testallOrder", handle: { _ in
            let exceptOption = expectation(description: "所有订单")
            let param = DealRecordRequestModel()
            AppAPIHelper.dealAPI().allOrder(requestModel: param, OPCode: .allOrder, complete: { (result) in
                if let model = result as? [OrderListModel] {
                    if model.count > 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
       //发起委托
    func testallOrder() {
        ytimeTest("testallOrder", handle: { _ in
            let exceptOption = expectation(description: "发起委托")
            let param = BuyOrSellRequestModel()
            AppAPIHelper.dealAPI().buyOrSell(requestModel: param, complete: { (result) in
                if let model = result as? EntrustSuccessModel {
                    if model.id != 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
   //确认订单
    func testsureOrderRequest() {
        ytimeTest("testsureOrderRequest", handle: { _ in
            let exceptOption = expectation(description: "确认订单")
            let param = SureOrderRequestModel()
            AppAPIHelper.dealAPI().sureOrderRequest(requestModel: param, complete: { (result) in
                if let model = result as? SureOrderResultModel {
                    if model.status == 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
  
    //取消订单
    func testcancelOrderRequest() {
        ytimeTest("testcancelOrderRequest", handle: { _ in
            let exceptOption = expectation(description: "取消订单")
            let param = CancelOrderRequestModel()
            AppAPIHelper.dealAPI().cancelOrderRequest(requestModel: param, complete: { (result) in
//                if let model = result as? SureOrderResultModel {
//                    if model.status == 0 {
                        exceptOption.fulfill()
//                    }
//                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
   //收到订单结果
    func testsetReceiveOrderResult() {
        ytimeTest("testsetReceiveOrderResult", handle: { _ in
            let exceptOption = expectation(description: "收到订单结果")
            let param = CancelOrderRequestModel()
            AppAPIHelper.dealAPI().cancelOrderRequest(requestModel: param, complete: { (result) in
                //                if let model = result as? SureOrderResultModel {
                //                    if model.status == 0 {
                                        exceptOption.fulfill()
                //                    }
                //                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
   

    //请求委托列表
    func testrequestEntrustList() {
        ytimeTest("testrequestEntrustList", handle: { _ in
            let exceptOption = expectation(description: "请求委托列表")
            let param = DealRecordRequestModel()
            AppAPIHelper.dealAPI().requestEntrustList(requestModel: param, OPCode: .historyEntrust, complete: { (result) in
                                if let model = result as? [EntrustListModel] {
                                    if model.count > 0 {
                                        exceptOption.fulfill()
                                    }
                                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //订单列表
    func testrequestOrderList() {
        ytimeTest("testrequestOrderList", handle: { _ in
            let exceptOption = expectation(description: "请求订单列表")
            let param = OrderRecordRequestModel()
            AppAPIHelper.dealAPI().requestOrderList(requestModel: param, OPCode: .historyOrder, complete: { (result) in
                if let model = result as? [OrderListModel] {
                    if model.count > 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testStarMailList() {
        ytimeTest("testStarMailList", handle: { _ in
            let exceptOption = expectation(description: "请求订单列表")
            let param = StarMailListRequestModel()
            AppAPIHelper.user().requestStarMailList(requestModel: param, complete: { (result) in
                if let model = result as? StarListModel {
                    if model.depositsinfo!.count > 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    
    // 预约粉丝列表
    func testOrderStarMailList() {
        ytimeTest("testOrderStarMailList", handle: { _ in
            let exceptOption = expectation(description: "预约粉丝列表")
            let param = StarMailOrderListRequestModel()
            AppAPIHelper.user().requestOrderStarMailList(requestModel: param, complete: { (result) in
                if let model = result as? OrderStarListModel {
                    if model.list != nil {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // MARK: - 聊天减时间
    func testreduceTime() {
        ytimeTest("testreduceTime", handle: { _ in
            let exceptOption = expectation(description: "聊天减时间")
            let param = ReduceTimeModel()
            AppAPIHelper.user().reduceTime(requestModel: param, complete: { (result) in

            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // MARK: - 请求订单状态
    func testOrderStar() {
        ytimeTest("testOrderStar", handle: { _ in
            let exceptOption = expectation(description: "聊天减时间")
            let param = OrderStarsRequetsModel()
            AppAPIHelper.user().requestOrderStars(requestModel: param, complete: { (result) in
                //                if let model = result as? OrderStarListModel {
                //                    if model.list != nil {
                                        exceptOption.fulfill()
                //                    }
                //                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // MARK: 微信支付
    func testwechatPay() {
        ytimeTest("testwechatPay", handle: { _ in
            let exceptOption = expectation(description: "聊天减时间")
            let param = WeChatPayModel()
            AppAPIHelper.user().wechatPay(requestModel: param, complete: { (result) in
                                if let model = result as? WeChatPayResultModel {
                                    if model.appid != "" {
                                        exceptOption.fulfill()
                                    }
                                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

    // MARK: 我的资产
    func testaccountMoney() {
        ytimeTest("testaccountMoney", handle: { _ in
            let exceptOption = expectation(description: "我的资产")
            let param = AccountMoneyRequestModel()
            AppAPIHelper.user().accountMoney(requestModel: param, complete: { (result) in
             exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // MARK: /资金明细列表
    func testCreditList() {
        ytimeTest("testCreditList", handle: { _ in
            let exceptOption = expectation(description: "资金明细列表")
            let param = CreditListRequetModel()
            AppAPIHelper.user().requestCreditList(requestModel: param, complete: { (result) in
                if let model = result as? RechargeListModel {
                    if model.depositsinfo!.count > 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    // MARK: - 设置支付密码
//
    func testresetPassWd() {
        ytimeTest("testresetPassWd", handle: { _ in
            let exceptOption = expectation(description: "设置支付密码")
            let param = ResetPassWdModel()
            AppAPIHelper.user().resetPassWd(requestModel: param, complete: { (result) in
               
                        exceptOption.fulfill()
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    // MARK: 重置支付密码
    func testResetPayPwd() {
        ytimeTest("testResetPayPwd", handle: { _ in
            let exceptOption = expectation(description: "重置支付密码")
            let param = ResetPayPwdRequestModel()
            AppAPIHelper.user().ResetPayPwd(requestModel: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

   // MARK: - 实名认证接口
    func testauthentication() {
        ytimeTest("testauthentication", handle: { _ in
            let exceptOption = expectation(description: "实名认证接口")
            let param = AuthenticationRequestModel()
            AppAPIHelper.user().authentication(requestModel: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }


//    // MARK: - 获取实名认证信息
    
    func testrequestAuthentication() {
        ytimeTest("testrequestAuthentication", handle: { _ in
            let exceptOption = expectation(description: "获取实名认证信息")
            let param = GetAuthenticationRequestModel()
            AppAPIHelper.user().requestAuthentication(requestModel: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
 
   //  MARK: -  获取用户信息
    func testtUserInfo() {
        ytimeTest("testtUserInfo", handle: { _ in
            let exceptOption = expectation(description: "获取用户信息")
            let param = UserInfoRequestModel()
            AppAPIHelper.user().requestUserInfo(requestModel: param, complete: { (result) in
                if let model = result as? UserInfoModel {
                    if model.nick_name != "" {
                        exceptOption.fulfill()
                    }
                }
               
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }


   // MARK: -  tokenLogin token登录
    
    func testtokenLogin() {
        ytimeTest("testtokenLogin", handle: { _ in
            let exceptOption = expectation(description: "获取用户信息")
            let param = TokenLoginRequestModel()
            AppAPIHelper.user().tokenLogin(requestModel: param, complete: { (result) in
                if let model = result as? StarUserModel {
                    if model.result != 0 {
                        exceptOption.fulfill()
                    }
                }
                
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

   
   // MARK: -  WXtokenLogin token登录
    
    func testweichattokenLogin() {
        ytimeTest("testweichattokenLogin", handle: { _ in
            let exceptOption = expectation(description: "WXtokenLogintoken登录")
            let param = TokenLoginRequestModel()
            AppAPIHelper.user().weichattokenLogin(id: 64, token: "123", complete: { (result) in
                if let model = result as? StarUserModel{
                    if model.result != 0 {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    
    // MARK: -  WXtokenLogin token登录
    
    func testweChatTokenLogin() {
        ytimeTest("testweChatTokenLogin", handle: { _ in
            let exceptOption = expectation(description: "WXtokenLogintoken登录")
            let param = WeChatTokenRequestModel()
            AppAPIHelper.user().weChatTokenLogin(model: param, complete: { (result) in
                                if let model = result as? StarUserModel{
                                    if model.result != 0 {
                                        exceptOption.fulfill()
                                    }
                                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    
    // MARK: - 修改昵称
    func testmodfyNickname() {
        ytimeTest("testmodfyNickname", handle: { _ in
            let exceptOption = expectation(description: " 修改昵称")
            let param = ModifyNicknameModel()
            AppAPIHelper.user().modfyNickname(requestModel: param, complete: { (result) in
                 exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    // MARK: 已购明星接口
    
    func testBuyStarCounte() {
        ytimeTest("testBuyStarCounte", handle: { _ in
            let exceptOption = expectation(description: " 已购明星接口")
            
            AppAPIHelper.user().requestBuyStarCount(complete: { (result) in
                   exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // MARK: 获取明星名称
    func testAllStarInfo() {
        ytimeTest("testAllStarInfo", handle: { _ in
            let exceptOption = expectation(description: "获取明星名称")
            let param = GetAllStarInfoModel()
            AppAPIHelper.user().requestAllStarInfo(requestModel: param, complete: { (result) in
                if let model = result as? [StartModel]{
                    if model.count > 0 {
                    exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
 
    // MARK: 支付宝支付
    func testalipay() {
        ytimeTest("testalipay", handle: { _ in
            let exceptOption = expectation(description: "支付宝支付")
            let param = AliPayRequestModel()
            AppAPIHelper.user().alipay(requestModel: param, complete: { (result) in
                if let model = result as? AliPayResultModel{
                    if model.orderinfo != "" {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    
//    // 版本更新提醒
    func testupdate() {
        ytimeTest("testupdate", handle: { _ in
            let exceptOption = expectation(description: "版本更新提醒")
            let param = AliPayRequestModel()
            AppAPIHelper.user().update(type: 1, complete: { (result ) in
                if let model = result as? UpdateParam{
                    if model.appName != "" {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    // 更新devicetoken
    
    func testupdateDeviceToken() {
        ytimeTest("testupdateDeviceToken", handle: { _ in
            let exceptOption = expectation(description: "更新devicetoken")
            let param = UpdateDeviceTokenModel()
            AppAPIHelper.user().updateDeviceToken(requestModel: param, complete: { (result ) in
                  exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testcancelRecharge() {
        ytimeTest("testcancelRecharge", handle: { _ in
            let exceptOption = expectation(description: "testcancelRecharge")
            let param = CancelRechargeModel()
            AppAPIHelper.user().cancelRecharge(requestModel: param, complete: { (result ) in
                exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testrequestStarOrderList() {
        ytimeTest("testrequestStarOrderList", handle: { _ in
            let exceptOption = expectation(description: "获取明星列表")
            let param = StarMailListRequestModel()
            AppAPIHelper.user().requestStarOrderList(requestModel: param, complete: { (result ) in
                exceptOption.fulfill()
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //MARK: 银行卡
    func testbankcardListt() {
        ytimeTest("testbankcardListt", handle: { _ in
            let exceptOption = expectation(description: "银行卡")
            let param = BankCardListRequestModel()
            AppAPIHelper.user().bankcardList(requestModel: param, complete: { (result ) in
                if let model  = result as? BankListModel{
                   exceptOption.fulfill()
                }
               
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //MARK: 解绑银行卡
    func testunbindcard() {
        ytimeTest("testunbindcard", handle: { _ in
            let exceptOption = expectation(description: "解绑银行卡")
            let param = UnbindCardListRequestModel()
            AppAPIHelper.user().unbindcard(requestModel: param, complete: { (result ) in
                if let model  = result as? UnBindBank{
                    if model.result == 0{
                        exceptOption.fulfill()
                    }
                    
                }
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //银行卡信息
    func testbankcardifo() {
        ytimeTest("testbankcardifo", handle: { _ in
            let exceptOption = expectation(description: "银行卡信息")
            let param = BankCardListRequestModel()
            AppAPIHelper.user().bankcardifo(requestModel: param, complete: { (result ) in
                if let model  = result as? BankInfo{
                    if model.bankId == 0{
                        exceptOption.fulfill()
                    }
                }
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    //MARK: 绑定银行卡
    func testbindcard() {
        ytimeTest("testbindcard", handle: { _ in
            let exceptOption = expectation(description: "绑定银行卡")
            let param = BindCardListRequestModel()
            AppAPIHelper.user().bindcard(requestModel: param, complete: { (result ) in
                if let model  = result as? BankInfo{
                    if model.bankId == 0{
                        exceptOption.fulfill()
                    }
                }
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //MARK: 提现
    func testwithDraw() {
        ytimeTest("testwithDraw", handle: { _ in
            let exceptOption = expectation(description: "提现")
            let param = WithDrawrequestModel()
            AppAPIHelper.user().withDraw(requestModel: param, complete: { (result ) in
                if let model  = result as? WithDrawResultModel{
                    if model.result == 0{
                        exceptOption.fulfill()
                    }
                }
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //MARK: 提现列表
    func testwithDrawList() {
        ytimeTest("testwithDrawList", handle: { _ in
            let exceptOption = expectation(description: "提现列表")
            let param = CreditListRequetModel()
            AppAPIHelper.user().withDrawList(requestModel: param, complete: { (result ) in
                if let model  = result as? WithdrawListModel{
                    if model.withdrawList.count > 0{
                        exceptOption.fulfill()
                    }
                }
                
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //MARK: 配置请求
    func testconfigRequest() {
        ytimeTest("testconfigRequest", handle: { _ in
            let exceptOption = expectation(description: "提现列表")
            let param = CreditListRequetModel()
            AppAPIHelper.user().configRequest(param_code: "123", complete: { (result ) in
                if let model  = result as? ConfigReusltValue{
                    if model.param_value != "" {
                        exceptOption.fulfill()
                    }
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }


    //请求行情分类
    func testrequestTypeList() {
        ytimeTest("testrequestTypeList", handle: { _ in
            let exceptOption = expectation(description: "请求行情分类")
            let param = WithDrawrequestModel()
           AppAPIHelper.marketAPI().requestTypeList(complete: { (result ) in
            if let model = result as? MarketClassifyModel{
                if model.type == 0 {
                    exceptOption.fulfill()
                }
            }
           }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //搜索
    func testsearchstar() {
        ytimeTest("testsearchstar", handle: { _ in
            let exceptOption = expectation(description: "搜索")
            let param = MarketSearhModel()
            AppAPIHelper.marketAPI().searchstar(requestModel: param, complete: { (result) in
                if let model = result as? SearchResultModel{
                     exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

    //单个分类明星列表
    func testrequestStarList() {
        ytimeTest("testrequestStarList", handle: { _ in
            let exceptOption = expectation(description: "搜索")
            let param = StarListRequestModel()
            AppAPIHelper.marketAPI().requestStarList(requestModel: param, complete: { (result) in
                if let model = result as? [MarketListModel] {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
   
//    
//    //获取明星经历
    func testStarExperience() {
        ytimeTest("testrequestStarList", handle: { _ in
            let exceptOption = expectation(description: "搜索")
            let param = StarListRequestModel()
            AppAPIHelper.marketAPI().requestStarExperience(code: "123", complete: { (result) in
                if let model = result as? [ExperienceModel] {
                    exceptOption.fulfill()
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //获取明星经历
    func testStarArachive() {
        ytimeTest("testStarArachive", handle: { _ in
            let exceptOption = expectation(description: "搜索")
            AppAPIHelper.marketAPI().requestStarArachive(code: "123", complete: { (result) in
                if let model = result as? [AchiveModel] {
                    exceptOption.fulfill()
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //获取实时报价
    func testrequestRealTime() {
        ytimeTest("testrequestRealTime", handle: { _ in
            let exceptOption = expectation(description: "获取实时报价")
             let param = RealTimeRequestModel()
            AppAPIHelper.marketAPI().requestRealTime(requestModel: param, complete: { (result ) in
                if let model = result as? RealTimeModel {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }


//    //获取拍卖时间
    func testrequestAuctionStatus() {
        ytimeTest("testrequestAuctionStatus", handle: { _ in
            let exceptOption = expectation(description: "获取实时报价")
            let param = AuctionStatusRequestModel()
            AppAPIHelper.marketAPI().requestAuctionStatus(requestModel: param, complete: { (result ) in
                if let model = result as? AuctionStatusModel {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

    func testrequestrequestStarServiceType() {
        ytimeTest("testrequestrequestStarServiceType", handle: { _ in
            let exceptOption = expectation(description: "获取明星服务类型")
            let param = ServiceTypeRequestModel()
            AppAPIHelper.marketAPI().requestStarServiceType(starcode: "123", complete: { (result) in
                if let model = result as? [ServiceTypeModel] {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    //    // 订购明星服务
    func testrequestBuyStarService() {
        ytimeTest("testrequestBuyStarService", handle: { _ in
            let exceptOption = expectation(description: "订购明星服务")
            let param = ServiceTypeRequestModel()
            AppAPIHelper.marketAPI().requestBuyStarService(requestModel: param, complete: { (result ) in
//                if let model = result as? AuctionStatusModel {
                    exceptOption.fulfill()
//                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    
//    //委托粉丝榜
    func testrequestEntrustFansList() {
        ytimeTest("testrequestEntrustFansList", handle: { _ in
            let exceptOption = expectation(description: "委托粉丝榜")
            let param = FanListRequestModel()
            AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: param, complete: { (result ) in
                                if let model = result as? [ FansListModel] {
                exceptOption.fulfill()
                                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //订单粉丝榜
    func testrequestOrderFansList() {
        ytimeTest("testrequestOrderFansList", handle: { _ in
            let exceptOption = expectation(description: "订单粉丝榜")
            let param = FanListRequestModel()
            AppAPIHelper.marketAPI().requestEntrustFansList(requestModel: param, complete: { (result ) in
                if let model = result as? [ OrderFansListModel] {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //持有某个明星时间数量
    func testrequestPositionCount() {
        ytimeTest("testrequestPositionCount", handle: { _ in
            let exceptOption = expectation(description: "持有某个明星时间数量")
            let param = PositionCountRequestModel()
            AppAPIHelper.marketAPI().requestPositionCount(requestModel: param, complete: { (result ) in
                if let model = result as? PositionCountModel {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //买卖占比
    func testrequstBuySellPercent() {
        ytimeTest("testrequstBuySellPercent", handle: { _ in
            let exceptOption = expectation(description: "买卖占比")
            let param = BuySellPercentRequest()
            AppAPIHelper.marketAPI().requstBuySellPercent(requestModel: param, complete: { (result ) in
                if let model = result as? BuySellCountModel {
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//    //请求明星发行时间
    func testrequestTotalCount() {
        ytimeTest("testrequestTotalCount", handle: { _ in
            let exceptOption = expectation(description: "请求明星发行时间")
            let param = BuySellPercentRequest()
            AppAPIHelper.marketAPI().requestTotalCount(starCode: "123", complete: { (result) in
                if let model = result as?  StarTotalCountModel {
                    exceptOption.fulfill()
                }
            }, error: nil)
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // 注册（模型）
    func testlogin() {
        ytimeTest("testlogin", handle: { _ in
            let exceptOption = expectation(description: "登录")
            let param = LoginRequestModel()
            AppAPIHelper.login().login(model: param, complete: { (result) in
                if let model = result as? StarUserModel{
                      exceptOption.fulfill()
                }
              
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    
    //
    //    //微信绑定(模型)
    func testBindWeichat() {
        ytimeTest("testBindWeichat", handle: { _ in
            let exceptOption = expectation(description: "登录")
            let param = WXRegisterRequestModel()
            AppAPIHelper.login().BindWeichat(model: param, complete: { (result) in
                exceptOption.fulfill()
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    // 微信登录(模型)
    func testWeChatLogint() {
        ytimeTest("testWeChatLogint", handle: { _ in
            let exceptOption = expectation(description: "微信登录")
            let param = WeChatLoginRequestModel()
            AppAPIHelper.login().WeChatLogin(model: param, complete: { (result) in
                if let model = result as? StarUserModel{
                    exceptOption.fulfill()
                }
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
//    
//    
//    // 校验用户登录(模型)
    func testCheckRegister() {
        ytimeTest("testCheckRegister", handle: { _ in
            let exceptOption = expectation(description: "校验用户登录")
            let param = CheckRegisterRequestModel()
            AppAPIHelper.login().CheckRegister(model: param, complete: { (result) in
                
                    exceptOption.fulfill()
                
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testSendVerificationCode() {
        ytimeTest("testSendVerificationCode", handle: { _ in
            let exceptOption = expectation(description: "校验用户登录")
            let param = SendVerificationCodeRequestModel()
            AppAPIHelper.login().SendVerificationCode(model: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testResetPasswd() {
        ytimeTest("testResetPasswd", handle: { _ in
            let exceptOption = expectation(description: "重置登录密码")
            let param = ResetPassWdRequestModel()
            AppAPIHelper.login().ResetPasswd(model: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }
    func testregistWYIM() {
        ytimeTest("registWYIM", handle: { _ in
            let exceptOption = expectation(description: "注册网易云信")
            let param = RegisterWYIMRequestModel()
            AppAPIHelper.login().registWYIM(model: param, complete: { (result) in
                
                exceptOption.fulfill()
                
            }, error: nil )
            waitForExpectations(timeout: 15, handler: nil)
        })
    }

//   
//    // 注册网易云(模型)
//    func registWYIM(model: RegisterWYIMRequestModel, complete: CompleteBlock?, error: ErrorBlock?) {
//        let packet : SocketDataPacket = SocketDataPacket.init(opcode: .registWY, model: model)
//        startRequest(packet, complete: complete, error: error)
//    }

    func testExample() {
  
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
