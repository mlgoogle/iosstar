//
//  NTESLogManager.h
//  NIM
//
//  Created by Xuhui on 15/4/1.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
@interface NTESLogManager : NSObject

+ (instancetype)sharedManager;

- (void)start;

- (UIViewController *)demoLogViewController;
- (UIViewController *)sdkLogViewController;
- (UIViewController *)sdkNetCallLogViewController;
- (UIViewController *)sdkNetDetectLogViewController;
- (UIViewController *)demoConfigViewController;
@end
