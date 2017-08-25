//
//  PackDataHelper.h
//  TestCheckSum
//
//  Created by J-bb on 17/8/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PackDataHelper : NSObject
+ (unsigned short)testCheckSumString:(NSString *)str;
+ (NSData *)compressData:(NSData *)data;
+ (NSData *)decompressionData:(NSData *)data;
+ (NSData *)QQTeaEncryption:(NSData *)data;
+ (NSData *)QQTeaDecode:(NSData *)data;
@end
