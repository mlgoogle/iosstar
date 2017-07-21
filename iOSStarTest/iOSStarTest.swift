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
//                    if model .barrage_info.count > 0 {
//                        exceptOption.fulfill()
//                    }
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
//                        exceptOption.fulfill()
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
                //                        exceptOption.fulfill()
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

    func testExample() {
  
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
