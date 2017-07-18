//
//  BarrageViewCustomer+BarrargeView.m
//  iOSStar
//
//  Created by sum on 2017/7/17.
//  Copyright © 2017年 YunDian. All rights reserved.
//

#import "BarrageViewCustomer+BarrargeView.h"
#import <SDWebImage/SDWebImageDownloader.h>
@implementation BarrageViewCustomer (BarrargeView)
- (void)prepareForReuse {
    
    
}
- (void)configureWithParams:(NSDictionary *)params
{
    NSString *url = params[@"imageUrl"];

    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:  [NSURL URLWithString:url] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        if (!image){
            self.imageView.image = [UIImage imageNamed:@"qq"];
        }else{
        self.imageView.image = image;
        }
    }];
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
    NSString  *name = params[@"name"];
//    CGSize size=[name sizeWithAttributes:attrs];
//
//    self.titleLabel.frame = CGRectMake(20, 0, size.width+20, 20);
//    self.backView.frame = CGRectMake(0, 0, size.width+40, 20);//attrbuited
    self.titleLabel.attributedText = params[@"attrbuited"];
    
}
- (CGSize)size{
    
    CGSize size = CGSizeMake(200, 100);
    return size;
    
}

@end
