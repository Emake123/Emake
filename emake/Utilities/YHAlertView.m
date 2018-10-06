//
//  YHAlertView.m
//  AlertViewTest
//
//  Created by 谷伟 on 2017/10/9.
//  Copyright © 2017年 谷伟. All rights reserved.
//

#import "YHAlertView.h"
@interface YHAlertView()
@property (nonatomic,strong)UIView *maskView;
@end
@implementation YHAlertView

- (instancetype)initWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(270), HeightRateCommon(140));
        
        self.center = self.maskView.center;
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, WidthRate(32), self.bounds.size.width-20, HeightRateCommon(40))];
        
        label.textColor = TextColor_666666;
        
        label.text = title;
        
        label.numberOfLines = 0;
        
        label.font = SYSTEM_FONT(AdaptFont(16));
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        
        
        UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(0, WidthRate(89), self.bounds.size.width, 0.5)];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(leftbuttonclick) forControlEvents:UIControlEventTouchUpInside];
  
        [self addSubview:leftBtn];
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:rightTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(rightbuttonclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rigthBtn];
        
        UILabel *lineV = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), 0.5, HeightRateCommon(50))];
        
        lineV.backgroundColor = SepratorLineColor;
        [self addSubview:lineV];
        
       
        
    }
    return self;
}
- (instancetype)initWithDelegete:(id)delegate Title:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(270), HeightRateCommon(140));
        
        self.center = self.maskView.center;
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, WidthRate(32), self.bounds.size.width-20, HeightRateCommon(35))];
        
        label.textColor = TextColor_666666;
        
        label.text = title;
        
        label.numberOfLines = 0;
        
        label.font = SYSTEM_FONT(AdaptFont(14));
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        
        
        UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(0, WidthRate(89), self.bounds.size.width, 0.5)];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        
        
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:rightTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
        
        UILabel *lineV = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), 1, HeightRateCommon(50))];
        
        lineV.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineV];
        
    
        
        
        
    }
    return self;
}
- (instancetype)initWithAlertViewTipsTDelegete:(id)delegate Title:(NSString *)title tips:(NSArray *)tipsArr rightButtonTitle:(NSString *)rightButtonTitle{
    self = [super init];
    if (self) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRate(180));
        
        self.center = self.maskView.center;
        self.clipsToBounds = YES;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, WidthRate(25), self.bounds.size.width, HeightRateCommon(16))];
        
        label.textColor = TextColor_666666;
        
        label.text = title;
        
        label.numberOfLines = 0;
        
        label.font = SYSTEM_FONT(AdaptFont(14));
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        

        UIView *titleView = [[UIView alloc] init];
        [self addSubview:titleView];
        [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(label.mas_bottom).offset(5);
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(90));
            make.width.mas_equalTo(WidthRate(300));
            
        }];
        
        for (int i= 0; i < tipsArr.count; i++) {
            
            NSString *tipStr = tipsArr[i];
            UIImageView *imageView  = [[UIImageView alloc] init];
            imageView.backgroundColor = ColorWithHexString(StandardBlueColor);
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 3;
            [titleView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(18+40*i);
                make.left.mas_equalTo(WidthRate(15));
                make.height.mas_equalTo(6);
                make.width.mas_equalTo(6);
            }];
            
            UILabel *Tipslable = [[UILabel alloc] init];
            Tipslable.text = tipStr;
            Tipslable.numberOfLines =0;
            Tipslable.textColor = ColorWithHexString(@"333333");
            Tipslable.font =  [UIFont systemFontOfSize:AdaptFont(13)];
            [titleView addSubview:Tipslable];
            [Tipslable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(imageView.mas_centerY).offset(0);
                make.left.mas_equalTo(imageView.mas_right).offset(5);
                make.height.mas_equalTo(HeightRate(35));
                make.width.mas_equalTo(WidthRate(270));
            }];
            
        }
        
        UILabel *lineH = [[UILabel alloc]init];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleView.mas_bottom).offset(15);
            make.left.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(WidthRate(300));
        }];
        
        UIButton *leftBtn = [[UIButton alloc]init];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineH.mas_bottom).offset(5);
            make.left.mas_equalTo(WidthRate(15));
            make.height.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(self.bounds.size.width/2);
        }];
        
        
        UIButton *rigthBtn = [[UIButton alloc]init];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:rightButtonTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        [rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineH.mas_bottom).offset(5);
            make.left.mas_equalTo(self.bounds.size.width/2);
            make.height.mas_equalTo(HeightRate(35));
            make.width.mas_equalTo(self.bounds.size.width/2);
            make.bottom.mas_equalTo(0);
        }];
        
        UILabel *lineV = [[UILabel alloc]init];
        
        lineV.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineH.mas_bottom).offset(0);
            make.left.mas_equalTo(self.bounds.size.width/2);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(1);
        }];
        
        
        

        
    }
    return self;
}
- (instancetype)initWithDelegete:(id)delegate image:(UIImage *)image Title:(NSString *)title leftButtonTitle:(NSString *)leftTitle rightButtonTitle:(NSString *)rightTitle{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.7];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(300), HeightRateCommon(160));
        
        self.center = self.maskView.center;

        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRateCommon(11));
            make.width.mas_equalTo(WidthRate(45));
            make.height.mas_equalTo(HeightRateCommon(45));
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
        UILabel *labelTile = [[UILabel alloc]init];
        labelTile.text = title;
        labelTile.font = SYSTEM_FONT(AdaptFont(14));
        labelTile.textAlignment = NSTextAlignmentCenter;
        labelTile.numberOfLines = 0;
        [self addSubview:labelTile];
        
        [labelTile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(26));
            make.right.mas_equalTo(WidthRate(-26));
            make.top.mas_equalTo(HeightRateCommon(61));
            make.height.mas_equalTo(HeightRateCommon(40));
        }];
        
        
        UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(0, WidthRate(89), self.bounds.size.width, 0.5)];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        
        
        [lineH mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(HeightRateCommon(118));
            make.height.mas_equalTo(HeightRateCommon(0.5 ));
        }];
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(WidthRate(134.5));
            make.top.mas_equalTo(lineH.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), self.bounds.size.width/2, HeightRateCommon(50))];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:rightTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
        [rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(0));
            make.width.mas_equalTo(WidthRate(134.5));
            make.top.mas_equalTo(lineH.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        
        UILabel *lineV = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, WidthRate(90), 0.5, HeightRateCommon(40))];
        lineV.backgroundColor = SepratorLineColor;
        [self addSubview:lineV];
        
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HeightRateCommon(43));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(HeightRateCommon(0));
        }];
        
    }
    return self;
}
//强制更新内容
- (instancetype)initWithTitle:(NSString *)title AndUpdateNecessaryText:(NSString *)text{
    
    self = [super init];
    if (self) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(270), HeightRateCommon(200));
        
        self.center = self.maskView.center;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(10), self.bounds.size.width, HeightRateCommon(40))];
        
        NSString *titleName =[NSString stringWithFormat:@"易智造%@",title];
        
        label.text = titleName;
        
        label.numberOfLines = 0;
        
        label.font = [UIFont boldSystemFontOfSize:18];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(50), self.bounds.size.width, 0.5)];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        
        
        UITextView *labelText = [[UITextView alloc]initWithFrame:CGRectMake(WidthRate(15), HeightRateCommon(51), self.bounds.size.width-WidthRate(30), HeightRateCommon(90))];
        
        labelText.userInteractionEnabled = false;
        
        NSString *updateText = [NSString stringWithFormat:@"更新说明：\n%@",text];
        
        labelText.text = updateText;
        
        labelText.font = SYSTEM_FONT(AdaptFont(16));
        
        
        [self addSubview:labelText];
        
        UILabel *lineHA = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(145), self.bounds.size.width, 0.5)];
        
        lineHA.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineHA];
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HeightRateCommon(146), self.bounds.size.width, HeightRateCommon(50))];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(rightbuttonclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
    }
    return self;
}
//非强制更新
- (instancetype)initWithTitle:(NSString *)title AndUpdateUnNecessaryText:(NSString *)text{
    self = [super init];
    if (self) {
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(270), HeightRateCommon(200));
        
        self.center = self.maskView.center;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(10), self.bounds.size.width, HeightRateCommon(40))];
        
        NSString *titleName =[NSString stringWithFormat:@"易智造%@",title];
        
        label.text = titleName;
        
        label.numberOfLines = 0;
        
        label.font = [UIFont boldSystemFontOfSize:18];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        UILabel *lineH = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(50), self.bounds.size.width, 0.5)];
        
        lineH.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineH];
        
        
        UITextView *labelText = [[UITextView alloc]initWithFrame:CGRectMake(WidthRate(15), HeightRateCommon(51), self.bounds.size.width-WidthRate(30), HeightRateCommon(90))];
        
        labelText.userInteractionEnabled = false;
        
        NSString *updateText = [NSString stringWithFormat:@"更新说明：\n%@",text];
        
        labelText.text = updateText;
        
        labelText.font = SYSTEM_FONT(AdaptFont(16));
        
        
        [self addSubview:labelText];
        
        UILabel *lineHA = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(145), self.bounds.size.width, 0.5)];
        
        lineHA.backgroundColor = SepratorLineColor;
        
        [self addSubview:lineHA];
        
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, HeightRateCommon(146), self.bounds.size.width/2, HeightRateCommon(50))];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:@"暂不更新" forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(leftbuttonclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, HeightRateCommon(146), self.bounds.size.width/2, HeightRateCommon(50))];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(rightbuttonclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
        UILabel *lineV = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2, HeightRateCommon(146), 0.5, HeightRateCommon(50))];
        lineV.backgroundColor = SepratorLineColor;
        [self addSubview:lineV];
        
    }
    return self;
}




- (instancetype)initWithDelegete:(id)delegate Title:(NSString *)title bottomTitle:(NSString *)bottomTitle ButtonTitle:(NSString *)ButtonTitle {
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0, 0, WidthRate(270), HeightRateCommon(140));
        
        self.center = self.maskView.center;
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, HeightRateCommon(0), self.bounds.size.width, HeightRateCommon(37))];
        
        label.textColor = ColorWithHexString(@"333333");
        label.backgroundColor = ColorWithHexString(@"f2f2f2");
        label.text = title;
        
        label.numberOfLines = 0;
        
        label.font = SYSTEM_FONT(AdaptFont(14));
        
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        
       
        
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-60, HeightRateCommon(0), WidthRate(34), HeightRateCommon(36))];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
//        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
//        [leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"gouwucheshanchu"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        
        
        
        UIButton *rigthBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.centerX-120, HeightRateCommon(50), WidthRate(120), HeightRateCommon(40))];
        rigthBtn.clipsToBounds= YES;
        rigthBtn.layer.cornerRadius= 6;
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        rigthBtn.backgroundColor = ColorWithHexString(StandardBlueColor);
        [rigthBtn setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        
        [rigthBtn setTitle:ButtonTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, HeightRateCommon(95), self.bounds.size.width-20, HeightRateCommon(35))];
        
        label2.textColor = ColorWithHexString(@"FF9900");
        
        label2.text = bottomTitle;
        
        label2.numberOfLines = 0;
        
        label2.font = SYSTEM_FONT(AdaptFont(14));
        
        label2.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label2];
        
        
        
        
        
        
        
    }
    return self;
}


- (instancetype)initWithDelegate:(id)delegate TopButtonTitle:(NSString *)topTitle BottomButtonTitle:(NSString *)bottomTitle
{
    self = [super init];
    if (self) {
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        UIColor *color = [UIColor blackColor];
        self.delegate = delegate;

        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.layer.cornerRadius = 5;
        
        self.frame = CGRectMake(0,(ScreenHeight)-120, ScreenWidth, 120);

        
        UIButton *leftBtn = [[UIButton alloc]init];
        
        leftBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [leftBtn setTitleColor:TextColor_A8A7A8 forState:UIControlStateNormal];
        
        [leftBtn setTitle:topTitle forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRate(60));
            make.bottom.mas_equalTo(0);
        }];
        
        UIButton *rigthBtn = [[UIButton alloc]init];
        
        rigthBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        
        [rigthBtn setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        
        [rigthBtn setTitle:bottomTitle forState:UIControlStateNormal];
        
        [rigthBtn addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:rigthBtn];
        
        [rigthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(HeightRate(60));
            make.bottom.mas_equalTo(HeightRate(-60));
        }];
        
    }
    return self;
        
}
- (void)showAnimated{
    //这里移除之前的view重新加载下
    NSArray *subViews = [UIApplication sharedApplication].keyWindow.subviews;
    if (subViews.count == 2) {
        UIView *view = subViews[1];
        [view removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];
    
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,CGFLOAT_MIN, CGFLOAT_MIN);
    [UIView animateWithDuration:0.3
                     animations:^{
                        
                         self.transform =
                         CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                    
                     }];
    
}
- (void)right:(UIButton *)btn{
    [self.maskView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(alertViewRightBtnClick:)]) {
        [self.delegate alertViewRightBtnClick:self];
    }
    if ([self.delegate respondsToSelector:@selector(alertViewRightBtnClick:currentTitle:)]) {
        [self.delegate alertViewRightBtnClick:self currentTitle:btn.currentTitle];
    }
}

-(void)leftbuttonclick
{
    [self.maskView removeFromSuperview];
    
}
-(void)rightbuttonclick
{
    [self.maskView removeFromSuperview];

    self.rightBlock(@"确定");
}
- (void)left:(UIButton *)btn{
    [self.maskView removeFromSuperview];

    if ([self.delegate respondsToSelector:@selector(alertViewLeftBtnClick:)]) {
        [self.delegate alertViewLeftBtnClick:self];
    }
}
-(void)closeAnimated{
    [self.maskView removeFromSuperview];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
