//
//  YHMineShareCodeViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHMineShareCodeViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ShareCustom.h"

@interface YHMineShareCodeViewController ()

@end

@implementation YHMineShareCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"我的邀请码";
    UIImageView *imageView  = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:self.inventedBGImageName];
    
    imageView.frame = CGRectMake(0, HeightRate(64), ScreenWidth, HeightRate(267));
    [self.view addSubview:imageView];
    
    UILabel *invatedLable = [[UILabel alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
        invatedLable.text = [NSString stringWithFormat:@"%@: %@",@"你的邀请码",[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]];
    }else{
        invatedLable.text = [NSString stringWithFormat:@"您的邀请码: "];
    }
    
    invatedLable.textColor = ColorWithHexString(@"333333");
    invatedLable.font = [UIFont systemFontOfSize:20];
    invatedLable.frame = CGRectMake(0, HeightRate(598), ScreenWidth, HeightRate(39));
    invatedLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:invatedLable];
    
    
    self.view.backgroundColor = ColorWithHexString(@"E6E6E6");
    NSArray * imageArray = @[[UIImage imageNamed:@"logo_500x500"]];

    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:self.sharetitle images:imageArray url:[NSURL URLWithString:self.invented] title:@"易智造" type:(SSDKContentTypeAuto)];
    [ShareCustom shareWithContent:shareParams view:self.view];
}
-(void)share
{
    NSArray * imageArray = @[[UIImage imageNamed:@"logo_500x500"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:@"邀请小伙伴，我们在一起" images:imageArray url:[NSURL URLWithString:self.invented] title:@"易智造" type:(SSDKContentTypeAuto)];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    
                }break;
                default:
                    break;
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
