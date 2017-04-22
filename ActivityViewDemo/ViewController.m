//
//  ViewController.m
//  ActivityViewDemo
//
//  Created by MA806P on 2017/4/22.
//  Copyright © 2017年 myz. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import "WeiboActivity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)shareAction:(id)sender {
    
    // 设置分享内容
    NSString *text = @"分享内容";
    UIImage *image = [UIImage imageNamed:@"1.png"];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSArray *activityItems = @[text, image, url];
    
    
    WeiboActivity * weiboActivity = [[WeiboActivity alloc] init];
    weiboActivity.performWeiboActivityBlock = ^{
        [self socialSinaWeibo];
    };
    NSArray * activitys = @[weiboActivity];
    
    
    UIActivityViewController *activityViewController =    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
    //activityViewController.excludedActivityTypes = @[UIActivityTypeAddToReadingList,UIActivityTypeSaveToCameraRoll,UIActivityTypeMessage];
    [self presentViewController:activityViewController animated:YES completion:nil];
    
    // 选中分享类型
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // 显示选中的分享类型
        NSLog(@"act type %@",activityType);
        if (completed) {
            NSLog(@"ok");
        }else {
            NSLog(@"no ok");
        }
    }];

}

- (void)socialSinaWeibo {
    
    // 1. 判断设备是否支持指定的分享平台
    // SLComposeViewController：社交分享的视图控制器
    BOOL isAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo];
    if (isAvailable == NO) {
        NSLog(@"应用不支持新浪微博分享");
        return;
    }
    // 2. 创建分享视图控制器，并指定分享平台
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    /* 系统支持的分享功能可以分享的平台
     SOCIAL_EXTERN NSString *const SLServiceTypeTwitter
     SOCIAL_EXTERN NSString *const SLServiceTypeFacebook
     SOCIAL_EXTERN NSString *const SLServiceTypeSinaWeibo
     SOCIAL_EXTERN NSString *const SLServiceTypeTencentWeibo
     SOCIAL_EXTERN NSString *const SLServiceTypeLinkedIn
     */    // 3. 设置分享内容
    [composeVC setInitialText:@"系统自带的社交分享服务"];
    [composeVC addImage:[UIImage imageNamed:@"1.png"]];
    [composeVC addURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    // 4. 进入分享界面
    [self presentViewController:composeVC animated:YES completion:^{
        NSLog(@"进入分享界面");
    }];
    // 5. 监听用户操作
    [composeVC setCompletionHandler:^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"取消分享");
        }else if (result == SLComposeViewControllerResultDone) {
            NSLog(@"分享成功");
        }
    }];
    
}


@end
