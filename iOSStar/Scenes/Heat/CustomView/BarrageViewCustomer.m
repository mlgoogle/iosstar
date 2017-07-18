//
//  BarrageViewCustomer.m
//  iOSStar
//
//  Created by sum on 2017/7/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

#import "BarrageViewCustomer.h"

@implementation BarrageViewCustomer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backView = [[UIView alloc] init];
        
        [self addSubview:self.backView];
     
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        self.titleLabel.text = @"哈哈哈哈";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.frame = CGRectMake(20, 0, 100, 20);
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = true;
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
       self.backView.frame = CGRectMake(0, 0, 200, 20);//attrbuited
        self.titleLabel.textColor = [UIColor whiteColor];
        self.backView.layer.cornerRadius = 5;
        self.backView.clipsToBounds = YES;
        self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.backView bringSubviewToFront:self.imageView];
     
    }
    return self;
}

@end
