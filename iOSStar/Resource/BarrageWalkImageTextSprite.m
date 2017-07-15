//
//  BarrageWalkImageTextSprite.m
//  BarrageRendererDemo
//
//  Created by UnAsh on 15/11/15.
//  Copyright (c) 2015年 ExBye Inc. All rights reserved.
//

#import "BarrageWalkImageTextSprite.h"

@implementation BarrageWalkImageTextSprite

- (instancetype)init
{
    
    if (self = [super init]) {
        _viewClassName = @"UILabel";
        self.trackNumber = 6;
    }
    return self;
}

@end
