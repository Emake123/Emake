//
//  YHLoginView.m
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLoginView.h"

@interface YHLoginView ()
@property (nonatomic, strong) UITableView *putInTableView;
@property (nonatomic, assign) NSInteger rowCount;

@end
@implementation YHLoginView

-(void)loginVIewWith:(UIView *)BackgroudView{
    
    UIImageView *topImagView  = [[UIImageView alloc] init];
    topImagView.contentMode = UIViewContentModeScaleAspectFit;
    topImagView.autoresizesSubviews = YES;
    topImagView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    topImagView.image = [UIImage imageNamed:@"logo_500x500"];

    [BackgroudView addSubview:topImagView];
    [topImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(BackgroudView.left);
        make.top.mas_equalTo(BackgroudView.top).offset(HeightRate(63));
        make.height.mas_equalTo(HeightRate(175));
        make.width.mas_equalTo(ScreenWidth);
    }];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor whiteColor];
    view.layer.cornerRadius =  6;
    view.clipsToBounds =YES;
    view.frame = CGRectMake(WidthRate(20),HeightRate(274), WidthRate(340), HeightRate(135));
    [BackgroudView addSubview:view];
    [self logintext:view placeholdName:@"请输入手机号" top:13 image:@"login_phone number"];
    [self logintext:view placeholdName:@"请输入密码" top:80 image:@"login_password"];
    
    _loginBtn  = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    _loginBtn.frame = CGRectMake(WidthRate(37),HeightRate(474), WidthRate(300), HeightRate(40));
    _loginBtn.backgroundColor = ColorWithHexString(@"4DBECD");
    _loginBtn.layer.cornerRadius =6;
    _loginBtn.clipsToBounds =YES;
    [BackgroudView addSubview:_loginBtn];

    _weChatLoginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_weChatLoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [_weChatLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    [_weChatLoginBtn setImage:[UIImage imageNamed:@"weixin.png"] forState:UIControlStateNormal];
    _weChatLoginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _weChatLoginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _weChatLoginBtn.left   = _loginBtn.left;
    _weChatLoginBtn.width  = _loginBtn.width;
    _weChatLoginBtn.height = _loginBtn.height;
    _weChatLoginBtn.top = CGRectGetMaxY(_loginBtn.frame)+20;
    _weChatLoginBtn.backgroundColor = ColorWithHexString(@"07B906");
    _weChatLoginBtn.layer.cornerRadius = HeightRate(20);
    _weChatLoginBtn.clipsToBounds =YES;
    [BackgroudView addSubview:_weChatLoginBtn];
    
    _registerBtn  = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [_registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:ColorWithHexString(@"4DBECD") forState:UIControlStateNormal ];
    _registerBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];

    _registerBtn.backgroundColor = BackgroudView.backgroundColor;
    [BackgroudView addSubview:_registerBtn];
    _registerBtn.frame = CGRectMake(WidthRate(116),HeightRate(575), WidthRate(65), HeightRate(25));


   _fogetBtn  = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [_fogetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _fogetBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [_fogetBtn.titleLabel sizeToFit];
    _fogetBtn.frame = CGRectMake(WidthRate(197),HeightRate(575), WidthRate(80), HeightRate(25));

    [_fogetBtn setTitleColor:ColorWithHexString(LOGIN_VIEW_TIP_BUTTON_COLOR) forState:UIControlStateNormal];
    
    _fogetBtn.backgroundColor = BackgroudView.backgroundColor;
    [BackgroudView addSubview:_fogetBtn];
    
    
    
    UILabel *lineV = [[UILabel alloc]init];
    lineV.backgroundColor = SepratorLineColor;
    lineV.frame = CGRectMake(ScreenWidth/2,HeightRate(580), 2.0, HeightRate(15));
    [BackgroudView addSubview:lineV];

    
}
-(void)logintext:(UIView *)view placeholdName:(NSString *)name top:(CGFloat)top image:(NSString *)imageName
{
    UIImageView *imagview  = [[UIImageView alloc] init];
    UIImage *imge = [[UIImage imageNamed:imageName] imageWithAlignmentRectInsets:UIEdgeInsetsMake(-12, -12, -12, -12)];
    imagview.image = imge;
    imagview.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imagview];
    [imagview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.left).offset(WidthRate(20) );
        make.top.mas_equalTo(HeightRate(top));
        make.height.mas_equalTo(HeightRate(45));
        make.width.mas_equalTo(WidthRate(45));
    }];
    UILabel *lable  = [[UILabel alloc] init];
    lable.backgroundColor = ColorWithHexString(BASE_LINE_COLOR);
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imagview.mas_bottom).offset(0);
        make.left.mas_equalTo(view.left).offset(WidthRate(25));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(WidthRate(308));
    }];
    
    UITextField * textPutIn = [[UITextField alloc] init];
    textPutIn.placeholder=name;
    
    textPutIn.borderStyle = UITextBorderStyleNone;
    [view addSubview:textPutIn];
    [textPutIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imagview.right).offset(WidthRate(95));
        make.centerY.mas_equalTo(imagview.mas_centerY);
        make.height.mas_equalTo(HeightRate(45));
        make.width.mas_equalTo(WidthRate(170));}];
    if ([name isEqualToString:@"请输入手机号"]) {
        textPutIn.keyboardType = UIKeyboardTypeNumberPad;
        _textPhone = textPutIn;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE]) {
            _textPhone.text=[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        }
        
    }else
    {
        textPutIn.secureTextEntry =YES;
        textPutIn.clearButtonMode = UITextFieldViewModeWhileEditing;
        textPutIn.keyboardType = UIKeyboardTypeASCIICapable;
        textPutIn.clearsOnBeginEditing = NO;
        _textPassword =textPutIn;
        _showPasswordBtn  = [UIButton buttonWithType:UIButtonTypeCustom] ;
        
        _showPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [_showPasswordBtn.titleLabel sizeToFit];
        CGFloat imageOff =-12;
        UIImage *imgageBTn = [[UIImage imageNamed:@"login_eyes_closed" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
        [_showPasswordBtn setBackgroundImage:imgageBTn forState:UIControlStateNormal];
        [_showPasswordBtn setTitleColor:ColorWithHexString(LOGIN_VIEW_TIP_BUTTON_COLOR) forState:UIControlStateNormal ];;
        
        [view addSubview:_showPasswordBtn];
        [_showPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRateCommon(45));
            make.width.mas_equalTo(WidthRate(45));
            make.right.mas_equalTo(view.right).offset(WidthRate(-18));
            make.centerY.mas_equalTo(imagview.mas_centerY);
        }];
    }
}
@end
