//
//  YHShareView.m
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHShareView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

@interface YHShareView()
@property(nonatomic,strong)id publishContent;
@property (nonatomic,strong)UIView *maskView;

@end
@implementation YHShareView

- (instancetype)initShareWithContentTitle:(NSString *)sharetitle theOtherTitle:(NSString *)Othertitle image:(NSArray *)shareImages url:(NSString *)shareUrlStr withCancleTitle:(NSString *)cancleTitle {
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor clearColor];
        
        NSArray * imageArray ;
        
        if (shareImages.count ==0) {
            imageArray = @[[UIImage imageNamed:@"logo_500x500"]];

        }else
        {
            imageArray = [NSArray arrayWithObject:shareImages];
        }
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:Othertitle images:imageArray url:[NSURL URLWithString:shareUrlStr] title:sharetitle type:(SSDKContentTypeAuto)];
        self.publishContent = shareParams;
//        self.delegate = delegate;
        
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, HeightRate(200));
        
        
        UIButton *cancelBtn = [[UIButton alloc]init];
//        cancelBtn.layer.cornerRadius =5;
        [cancelBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-HeightRate(0));
            make.height.mas_equalTo(HeightRate(55));
            make.width.mas_equalTo(ScreenWidth);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor =ColorWithHexString(@"F2F2F2");
//        view.layer.cornerRadius =5;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cancelBtn.mas_top).offset(0);
            make.height.mas_equalTo(HeightRate(145));
            make.width.mas_equalTo(ScreenWidth);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        NSArray *btnImages = @[@"wode_wechat", @"wode_pengyouquan", @"wode_qq", @"wode_kongjian"];
        NSArray *btnTitles = @[ @"微信好友", @"微信朋友圈", @"QQ好友", @"QQ空间",];
        for (NSInteger i=0; i<btnImages.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
            
            float btnX = 11*(i+1)+80*i +10;
            float btnY = 40;
            
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
            [view addSubview:button];
        }
        
    }
    return self;
}
- (void)showAnimated{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)cancle{
    
    [self.maskView removeFromSuperview];
   
}
- (void)selectItem:(UIButton *)sender{
    
    [self.maskView removeFromSuperview];
   
    
}
-(void)shareBtnClick:(UIButton *)btn
{
   
    int shareType = 0;
//    id publishContent = _publishContent;
    if (btn.tag == 339) {
        
        [self cancle];
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
    
    [ShareSDK share:shareType parameters:self.publishContent onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                [self cancle];
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

@end
