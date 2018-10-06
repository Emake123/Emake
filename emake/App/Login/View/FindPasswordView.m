//
//  FindPasswordView.m
//  emake
//
//  Created by eMake on 2017/8/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "FindPasswordView.h"
@interface FindPasswordView ()

@property(nonatomic,assign)BOOL isInvented;
@end

@implementation FindPasswordView

-(void)loginVIewWith:(UIView *)BackgroudView isInvented:(BOOL)isInvented
{
    self.isInvented = isInvented ;
    UIImageView *topImagView  = [[UIImageView alloc] init];
    topImagView.image = [UIImage imageNamed:@"logo_500x500"];
    topImagView.contentMode = UIViewContentModeScaleAspectFit;
    topImagView.autoresizesSubviews = YES;
    topImagView.autoresizingMask =
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    topImagView.frame =CGRectMake(0,HeightRate(63) ,ScreenWidth, HeightRate(144));
    [BackgroudView addSubview:topImagView];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =[UIColor whiteColor];
    view.layer.cornerRadius =  8;
    view.clipsToBounds =YES;
    view.frame = CGRectMake(WidthRate(20) ,HeightRate(228) , WidthRate(350), HeightRate(240));
    [BackgroudView addSubview:view];
    [self logintext:view placeholdName:@"请输入手机号" top:11 image:@"login_phone number"];
    [self logintext:view placeholdName:@"请输入验证码" top:71 image:@"login_code"];
    [self logintext:view placeholdName:isInvented?@"请输入密码":@"请输入新密码" top:131 image:@"login_password"];
//    if (isInvented == YES) {
//        [self logintext:view placeholdName:@"请选择品类" top:191 image:@"pinleixuanze"];

//    }

    _BtnSure  = [UIButton buttonWithType:UIButtonTypeSystem] ;
    [_BtnSure setTitle:@"确定" forState:UIControlStateNormal];
    [_BtnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    _BtnSure.frame = CGRectMake(WidthRate(37) ,HeightRate(500) , WidthRate(300), HeightRate(45));
    
    _BtnSure.backgroundColor = ColorWithHexString(@"4DBECD");
    _BtnSure.layer.cornerRadius =6;
    _BtnSure.clipsToBounds =YES;
    [BackgroudView addSubview:_BtnSure];
    
    if (isInvented == YES) {
        
//        UIView *invantedCardview = [[UIView alloc] init];
//        invantedCardview.backgroundColor =[UIColor whiteColor];
//        invantedCardview.layer.cornerRadius =  8;
//        invantedCardview.clipsToBounds =YES;
//        invantedCardview.frame = CGRectMake(WidthRate(20),HeightRate(430) , WidthRate(340), HeightRate(59));
//        [BackgroudView addSubview:invantedCardview];
//        [self putintoInvatedCode:invantedCardview];
        
        UILabel *tipsLabel = [[UILabel alloc]init];
        tipsLabel.text = @"已阅读并同意以下协议。";
        tipsLabel.font = SYSTEM_FONT(AdaptFont(14));
        tipsLabel.textColor = TextColor_ABABAB;
        [BackgroudView addSubview:tipsLabel];
        
        [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(30));
            make.top.mas_equalTo(_BtnSure.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(HeightRate(23));
            make.width.mas_equalTo(WidthRate(160));
        }];
        
        self.userPermission = [UIButton buttonWithType:UIButtonTypeCustom];
        self.userPermission.tag = 1;
        [self.userPermission setTitle:@"《使用许可》" forState:UIControlStateNormal];
        self.userPermission.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.userPermission setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [BackgroudView addSubview:self.userPermission];
        
        [self.userPermission mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(20));
            make.top.mas_equalTo(tipsLabel.mas_bottom).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(23));
            make.width.mas_equalTo(WidthRate(90));
        }];
        
        self.userPrivate = [UIButton buttonWithType:UIButtonTypeCustom];
        self.userPrivate.tag = 3;
        [self.userPrivate setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        self.userPrivate.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.userPrivate setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [BackgroudView addSubview:self.userPrivate];
        
        [self.userPrivate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userPermission.mas_right).offset(WidthRate(-10));
            make.top.mas_equalTo(tipsLabel.mas_bottom).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(23));
            make.width.mas_equalTo(WidthRate(90));
        }];
        
        self.userServers = [UIButton buttonWithType:UIButtonTypeCustom];
        self.userServers.tag = 2;
        [self.userServers setTitle:@"《服务条款》" forState:UIControlStateNormal];
        self.userServers.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.userServers setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        [BackgroudView addSubview:self.userServers];
        
        [self.userServers mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userPrivate.mas_right).offset(WidthRate(-10));
            make.top.mas_equalTo(tipsLabel.mas_bottom).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(23));
            make.width.mas_equalTo(WidthRate(90));
        }];
        
    }
}
-(void)logintext:(UIView *)view placeholdName:(NSString *)name top:(CGFloat)top image:(NSString *)image
{
    UIImageView *imagview  = [[UIImageView alloc] init];
    imagview.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *imge = [[UIImage imageNamed:image] imageWithAlignmentRectInsets:UIEdgeInsetsMake(-12, -12, -12, -12)];
    imagview.image = imge;
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
        make.top.mas_equalTo(imagview.mas_bottom).offset(HeightRate(0));
        make.left.mas_equalTo(view.left).offset(WidthRate(25));
        make.height.mas_equalTo(HeightRate(1));
        make.width.mas_equalTo(WidthRate(view.bounds.size.width-50));
        
    }];
 
   UITextField* textMobil = [[UITextField alloc] init];
    textMobil.placeholder=name;
    textMobil.borderStyle = UITextBorderStyleNone;
    [view addSubview:textMobil];
    textMobil.clearButtonMode = UITextFieldViewModeWhileEditing;

    [textMobil mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.left).offset(65);
        make.centerY.mas_equalTo(imagview.mas_centerY);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(160);}];
    
 
    if([name isEqualToString:@"请输入验证码"])
    {    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_getCodeBtn setTintColor:ColorWithHexString(StandardBlueColor)];
//        _getCodeBtn.layer.cornerRadius = 7;
//        _getCodeBtn.layer.masksToBounds =YES;
//        _getCodeBtn.layer.borderWidth = 1;
//        _getCodeBtn.layer.borderColor =ColorWithHexString(@"4DBECD").CGColor;
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [view addSubview:_getCodeBtn];
        [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(view.right).offset(WidthRate(-18));
            make.centerY.mas_equalTo(imagview.mas_centerY);
            make.height.mas_equalTo(HeightRate(30));
            make.width.mas_equalTo(WidthRate(120));}];
        
        _textCode = textMobil;
        
        UILabel *lable2  = [[UILabel alloc] init];
        lable2.backgroundColor = ColorWithHexString(StandardBlueColor);
        [view addSubview:lable2];
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lable.mas_centerY).offset(0);
            make.left.mas_equalTo(_getCodeBtn.mas_left).offset(WidthRate(-5));
            make.height.mas_equalTo(HeightRate(1));
            make.right.mas_equalTo(lable.mas_right);
            
        }];
    }else if ([name isEqualToString:@"请输入手机号"])
        
    {
        textMobil.keyboardType = UIKeyboardTypeNumberPad;
        _textMobilPhone = textMobil;
    
    }else
    {
        textMobil.keyboardType = UIKeyboardTypeASCIICapable;
        _textPassword.secureTextEntry =YES;
        _textPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textPassword.keyboardType = UIKeyboardTypeASCIICapable;
        
        CGFloat imageOff =-12;
        UIImage *imgageBTn;

        if ([name isEqualToString:@"请选择品类"]) {
            
            imgageBTn = [[UIImage imageNamed:@"right01" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
            textMobil.enabled = NO;;
            
            UIButton *chooseCatagory = [UIButton buttonWithType:UIButtonTypeCustom];
            [view addSubview:chooseCatagory];
            
            [chooseCatagory mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(view.left).offset(65);
                make.centerY.mas_equalTo(imagview.mas_centerY);
                make.height.mas_equalTo(30);
                make.right.mas_equalTo(0);}];
            
            
            self.BtnChooseCatagory = chooseCatagory;
            textMobil.secureTextEntry = NO;
            self.textChooseCatagory = textMobil;

        }else
        {
            _showPasswordBtn  = [UIButton buttonWithType:UIButtonTypeCustom] ;
            
            _showPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
            [_showPasswordBtn.titleLabel sizeToFit];
                        _showPasswordBtn.userInteractionEnabled = YES;
            _textPassword =textMobil;
            imgageBTn = [[UIImage imageNamed:@"login_eyes_closed" ] imageWithAlignmentRectInsets:UIEdgeInsetsMake(imageOff, imageOff, imageOff, imageOff)];
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
}
-(void)putintoInvatedCode:(UIView *)view
{
    _invatedBtn  = [[UIButton alloc] init];
    [_invatedBtn setTitle:@"邀请码" forState:UIControlStateNormal];
    _invatedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_invatedBtn setTitleColor:ColorWithHexString(@"4DBECD") forState:UIControlStateNormal];
    [view addSubview:_invatedBtn];
    [_invatedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.left).offset(WidthRate(15) );
        make.top.mas_equalTo(HeightRate(19));
        make.height.mas_equalTo(HeightRate(23) );
        make.width.mas_equalTo(WidthRate(59));
    }];
    _inviteText  = [[UITextField alloc] init];
    NSString *holderText = @"输入邀请码，更易通过审核(可不填)";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:13]
                        range:NSMakeRange(0, holderText.length)];
    _inviteText.attributedPlaceholder =placeholder;
    [view addSubview:_inviteText];
    _inviteText.borderStyle = UITextBorderStyleNone;
    _inviteText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [_inviteText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(21));
        
        make.left.mas_equalTo(view.left).offset(WidthRate(79));
        make.height.mas_equalTo(HeightRate(23));
        make.width.mas_equalTo(WidthRate(view.bounds.size.width-69));
        
    }];
    
   
    
}
@end
