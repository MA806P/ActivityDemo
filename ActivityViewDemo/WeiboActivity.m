//
//  WeiboActivity.m
//  ActivityViewDemo
//
//  Created by MA806P on 2017/4/22.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "WeiboActivity.h"

@implementation WeiboActivity


+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return @"com.myz.share.weibo.post";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"share_weibo"];
}

- (NSString *)activityTitle
{
    return @"微博分享";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    
}

- (void)performActivity {
    if (self.performWeiboActivityBlock) {
        self.performWeiboActivityBlock();
    }
    [self activityDidFinish:YES];
}


@end
