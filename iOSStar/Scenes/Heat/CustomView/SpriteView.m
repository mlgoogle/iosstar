//
//  SpriteView.m
//  BarrageRendererDemo
//
//  Created by J-bb on 17/7/16.
//  Copyright © 2017年 ExBye Inc. All rights reserved.
//

#import "SpriteView.h"

@implementation SpriteView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        UIView *backView = [[UIView alloc] initWithFrame:frame];
        
        [self addSubview:backView];
        NSArray *colorArray = [NSArray arrayWithObjects:[UIColor redColor], [UIColor clearColor], nil];
        self.colorView = [[GradualColorView alloc] initWithFrame:CGRectMake(30, 0, 60, 30) percent:1.0 completeColors:colorArray backColor:[UIColor clearColor]];
        self.colorView.isShowImage = false;
        [backView addSubview:self.colorView];
        [self.colorView addGradualColorLayerWithIsRound:true];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        self.titleLabel.text = @"哈哈哈哈";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.colorView addSubview:self.titleLabel];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, 40, 40)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.layer.cornerRadius = 20;
        self.imageView.layer.masksToBounds = true;
        self.imageView.transform = CGAffineTransformMakeRotation(0.707);
        [backView addSubview:self.imageView];
        [backView bringSubviewToFront:self.imageView];
        
        backView.transform = CGAffineTransformMakeRotation(-0.707);
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
