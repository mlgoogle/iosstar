//
//  SpriteView.h
//  BarrageRendererDemo
//
//  Created by J-bb on 17/7/16.
//  Copyright © 2017年 ExBye Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iOSStar-Swift.h"

@interface SpriteView : UIView

@property(nonatomic, strong) GradualColorView *colorView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;
@end
