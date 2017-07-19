//
//  iOSStarTests.swift
//  iOSStarTests
//
//  Created by mu on 2017/7/14.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import XCTest
@testable import iOSStar
@testable import Realm
@testable import RealmSwift
class iOSStarTests: XCTestCase {
    
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //emoji测试
    func testEmoji(){
        ytimeTest("testLogin", handle: {_ in 

            let expectOption = expectation(description: "登录测试")
            let param = LoginRequestModel()
            param.phone = "18657195470"
            param.pwd = "123456".md5()
            var idExcept = false
            var phoneExcept = false
            var tokenExcept = false
            
            waitForExpectations(timeout: 15, handler: nil)
            
            XCTAssertTrue(idExcept, "用户id不存在")
            XCTAssertTrue(phoneExcept, "用户手机号不存在")
            XCTAssertTrue(tokenExcept, "token不存在")
            
        })
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
