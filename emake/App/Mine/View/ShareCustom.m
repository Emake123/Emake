//
//  ShareCustom.m
//  shareTest
//
//  Created by eMake on 2017/8/31.
//  Copyright © 2017年 eMake. All rights reserved.
//

#import "ShareCustom.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"




@implementation ShareCustom

static id _publishContent;//类方法中的全局变量这样用（类型前面加static）
static UIVisualEffectView *_effectView;
/*
 自定义的分享类，使用的是类方法，其他地方只要 构造分享内容publishContent就行了
 */

+(void)shareWithContent:(id)publishContent view:(UIView *)bgview/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    _publishContent = publishContent;
    
    
    /**
     加上一层黑色透明效果
     */
    UIView *blackV;
    if(blackV == nil)
    {
    blackV = [[UIView alloc] initWithFrame:CGRectMake(WidthRate(10),HeightRate(294), WidthRate(355), HeightRate(264))];
        blackV.layer.cornerRadius = 6;
        blackV.layer.masksToBounds = YES;
        
    blackV.backgroundColor = [UIColor whiteColor];
    blackV.tag = 442;
//    blackV.alpha = 0.2;
    [bgview addSubview:blackV];
    
    /**
     点击退出手势
     */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [blackV addGestureRecognizer:tap];
    

    /**
     Share Content
     */
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, HeightRate(50), blackV.frame.size.width, HeightRate(45))];
    titleLabel.text = @"邀请小伙伴，我们在一起";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textColor = ColorWithHexString(@"474747");
    titleLabel.backgroundColor = [UIColor clearColor];
    [blackV addSubview:titleLabel];
    
    NSArray *btnImages = @[@"wode_wechat", @"wode_pengyouquan", @"wode_qq", @"wode_kongjian"];
    NSArray *btnTitles = @[ @"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间",];
    for (NSInteger i=0; i<btnImages.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
        
        float btnX = 11*(i+1)+80*i +10;
        float btnY =titleLabel.frame.origin.y + titleLabel.frame.size.height+30;

        button.frame = CGRectMake(WidthRate(btnX),HeightRate(btnY),WidthRate(60),HeightRate(60));
        UIImage *image =[UIImage imageNamed:btnImages[i]];
        [button setImage:image forState:UIControlStateNormal];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, WidthRate(60), HeightRate(60), HeightRate(20))];
        lbl.font = [UIFont systemFontOfSize:AdaptFont(10)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = ColorWithHexString(@"474747");
        lbl.text = btnTitles[i];
        [button addSubview:lbl];
        
        
        
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [blackV addSubview:button];
    }
    }
}

+(void)shareBtnClick:(UIButton *)btn
{
    
    int shareType = 0;
    id publishContent = _publishContent;
    if (btn.tag == 339) {
        
        [self dismiss];
        return;
    }
    switch (btn.tag) {
        case 331:
        {
            shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
            
        case 332:
        {
            shareType = SSDKPlatformSubTypeWechatTimeline;
        }
            break;
            
        case 333:
        {
            shareType = SSDKPlatformSubTypeQQFriend;
        }
            break;
            
        case 334:
        {
            shareType = SSDKPlatformSubTypeQZone;
        }
            break;
            
        default:
            break;
    }
    
    /*
     调用shareSDK的无UI分享类型，
     */
    
    [ShareSDK share:shareType parameters:publishContent onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                
                NSLog(@"分享成功！");
                break;
            }
            case SSDKResponseStateFail:
            {
                
                NSLog(@"分享失败！");
                break;
            }
            default:
                break;
        }
    }];
    
}
+ (void)dismiss {
    
}

@end
