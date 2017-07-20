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
    func scrollStarList() {
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
    
     //请求剩余时间
    func BuyRemainingTime(){
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
    
     //抢购明星信息
    func BuyStarInfo(){
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
    
     //明星介绍页信息
    func DetailInfo(){
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

//    // 获得弹幕数据
    func testBarrage() {
        ytimeTest("testBarrage", handle: { _ in
            let exceptOption = expectation(description: "弹幕测试")
            let param = HeatBarrageModel()
            param.count = 50
            param.pos = 0
            AppAPIHelper.marketAPI().requstBuyBarrageList(requestModel: param, complete: { (result) in
                if let model = result as? BarrageInfo {
                    if model .barrage_info.count > 0 {
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
    

    func testExample() {
  
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
