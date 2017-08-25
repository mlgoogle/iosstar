//
//  PackDataHelper.m
//  TestCheckSum
//
//  Created by J-bb on 17/8/25.
//  Copyright © 2017年 YunDian. All rights reserved.
//

#import "PackDataHelper.h"
#import "checksum.h"

@implementation PackDataHelper
+ (unsigned short)testCheckSumString:(NSString *)str {
    unsigned short a = 0;
    if (checksum([str UTF8String], a)) {
        return a;
    }
    return a;
}
+ (NSData *)compressData:(NSData *)data {
    
}
+ (NSData *)decompressionData:(NSData *)data {
    
}
+ (NSData *)QQTeaEncryption:(NSData *)data {
    
}
+ (NSData *)QQTeaDecode:(NSData *)data {
    
}

@end
