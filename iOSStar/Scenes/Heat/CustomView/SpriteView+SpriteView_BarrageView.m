//
//  SpriteView+SpriteView_BarrageView.m
//  BarrageRendererDemo
//
//  Created by J-bb on 17/7/16.
//  Copyright © 2017年 ExBye Inc. All rights reserved.
//

#import "SpriteView+SpriteView_BarrageView.h"
#import <SDWebImage/SDWebImageDownloader.h>
@implementation SpriteView (SpriteView_BarrageView)

- (void)prepareForReuse {
 

}
- (void)configureWithParams:(NSDictionary *)params
{
    NSString *url = params[@"imageUrl"];



    

    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:  [NSURL URLWithString:url] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        self.imageView.image = image;
    }];
    NSString *name = params[@"name"];
 
    self.titleLabel.text = name;
    
}
@end
