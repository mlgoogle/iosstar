//
//  Global.h
//  iOSStar
//
//  Created by sum on 2017/4/20.
//  Copyright © 2017年 sum. All rights reserved.
//

#ifndef Global_h
#define Global_h

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import "NTESGlobalMacro.h"
#import "NIMKit.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#define NTES_USE_CLEAR_BAR - (BOOL)useClearBar{return YES;}

#define NTES_FORBID_INTERACTIVE_POP - (BOOL)forbidInteractivePop{return YES;}


#endif
#endif /* Global_h */
