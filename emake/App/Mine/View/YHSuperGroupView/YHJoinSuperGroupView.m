//
//  YHJoinSuperGroupView.m
//  emake
//
//  Created by zhangshichao on 2018/9/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHJoinSuperGroupView.h"
@interface YHJoinSuperGroupView()
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)NSInteger recordSelectButtonIndex;

@end
@implementation YHJoinSuperGroupView

-(instancetype)initWithJoinSuperGroupViewWithprouctExplain:(NSString *)prouctExplain depositMoney:(NSString *)depositMoney prouctNumber:(NSString *)prouctNumber Delegate:(id)delegate
{
    self = [super init];
    
    if (self) {
        
        self.delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        UIColor *color = [UIColor blackColor];
        self.maskView.backgroundColor = [color colorWithAlphaComponent:0.5];
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, HeightRate(480));

        
        UILabel *topTitle = [[UILabel alloc] init];
        topTitle.backgroundColor = ColorWithHexString(@"F9F9F9");
        topTitle.text = @" 参与拼团";
        topTitle.textAlignment = NSTextAlignmentCenter;
        topTitle.font = [UIFont systemFontOfSize:AdaptFont(16)];
        topTitle.numberOfLines = 0;
        [self addSubview:topTitle];
        [topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(47) );
        }];
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancle setImage:[UIImage imageNamed:@"gouwucheshanchu"] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancle];
        [cancle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-30));
            make.top.mas_equalTo(HeightRate(5));
            make.width.mas_equalTo(WidthRate(37));
            make.height.mas_equalTo(WidthRate(37));
        }];


        UILabel *moneyTip = [[UILabel alloc] init];
        moneyTip.backgroundColor = ColorWithHexString(@"FFFFCC");
        moneyTip.textColor = ColorWithHexString(@"FF9900");
        moneyTip.text = @"   付1000元定金，即可参与拼团，拼团不成功，立即全额退款 ";
        moneyTip.font = [UIFont systemFontOfSize:AdaptFont(13)];
        moneyTip.numberOfLines = 0;
        [self addSubview:moneyTip];
        [moneyTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(topTitle.mas_bottom);
            make.height.mas_equalTo(HeightRate(47) );

        }];

        UILabel *prouctExplainLable = [[UILabel alloc] init];
        prouctExplainLable.textColor = ColorWithHexString(@"333333");
        prouctExplainLable.text = @"SCB15硅钢干式变压器 阻抗：4%；质量标准：国标；材质：全铜；温升：国标100K ";
        prouctExplainLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        prouctExplainLable.numberOfLines = 0;
        [self addSubview:prouctExplainLable];
        [prouctExplainLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.right.mas_equalTo(WidthRate(-10));
            make.top.mas_equalTo(moneyTip.mas_bottom).offset(HeightRate(15));

        }];

        UILabel *depositMoneyLable = [[UILabel alloc] init];
        //        prouctExplain.backgroundColor = ColorWithHexString(@"333333");
        depositMoneyLable.text = [NSString stringWithFormat:@"定金：¥%@",depositMoney];
        depositMoneyLable.font = [UIFont systemFontOfSize:AdaptFont(20)];
        depositMoneyLable.textColor= ColorWithHexString(@"F8695D");
        depositMoneyLable.numberOfLines = 0;
        [self addSubview:depositMoneyLable];
        [depositMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.right.mas_equalTo(WidthRate(-5));
            make.top.mas_equalTo(prouctExplainLable.mas_bottom).offset(HeightRate(15));

        }];
        UILabel *prouctNumberLable = [[UILabel alloc] init];
        //        prouctExplain.backgroundColor = ColorWithHexString(@"333333");
        prouctNumberLable.text = prouctNumber;
        prouctNumberLable.textAlignment = NSTextAlignmentCenter;
        prouctNumberLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        prouctNumberLable.layer.borderColor = SepratorLineColor.CGColor;
        prouctNumberLable.layer.borderWidth = 1;
        [self addSubview:prouctNumberLable];
        [prouctNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(115));
            make.height.mas_equalTo(HeightRate(28) );
            make.right.mas_equalTo(WidthRate(-5));
            make.top.mas_equalTo(depositMoneyLable.mas_bottom).offset(HeightRate(15));

        }];


        UILabel *prouctNumberNameLable = [[UILabel alloc] init];
        //        prouctExplain.backgroundColor = ColorWithHexString(@"333333");
        prouctNumberNameLable.text = @"数量 ";
        prouctNumberNameLable.textAlignment = NSTextAlignmentRight;
        prouctNumberNameLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:prouctNumberNameLable];
        [prouctNumberNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(5));
            make.right.mas_equalTo(prouctNumberLable.mas_left).offset(WidthRate(-10));
            make.centerY.mas_equalTo(prouctNumberLable.mas_centerY).offset(HeightRate(0));

        }];
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;

        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(prouctNumberLable.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(HeightRate(1) );

        }];
        UIView *item = [self getItem:@"weixinzhifu" payName:@"微信支付" payTip:@"亿万用户的选择，更快捷安全" tag:10];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(3));
            make.height.mas_equalTo(HeightRate(60) );

        }];

        UIView *item1 = [self getItem:@"zhifubaozhifu" payName:@"支付宝支付" payTip:@"亿万用户的选择，更快捷安全" tag:11];
        [self addSubview:item1];
        [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.top.mas_equalTo(item.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(HeightRate(60) );

        }];


        UIButton *needMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [needMoneyButton setTitle:[NSString stringWithFormat:@"需要支付%@元",depositMoney] forState:UIControlStateNormal];
        needMoneyButton.layer.cornerRadius = 6;
        needMoneyButton.clipsToBounds = YES;
        [needMoneyButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
        needMoneyButton.backgroundColor = ColorWithHexString(StandardBlueColor);
        [needMoneyButton addTarget:self action:@selector(payMoneyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:needMoneyButton];
        [needMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(15));
            make.right.mas_equalTo(WidthRate(-15));
            make.top.mas_equalTo(item1.mas_bottom).offset(HeightRate(25));
            make.height.mas_equalTo(HeightRate(50) );

        }];
        
    }
    return self;
}




-(void)payMoneyButtonClick
{
    if (self.recordSelectButtonIndex ==0) {
        
        [self makeToast:@"请先选择支付方式" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    [self removeView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(superGroupPay:payIndex:)]) {
        [self.delegate superGroupPay:self payIndex:self.recordSelectButtonIndex-10];
    }
    
    
}


-(void)selectPayButton:(UIButton *)button
{
    button.selected = !button.selected;
    self.recordSelectButtonIndex = button.tag;
    
}


-(UIView *)getItem:(NSString *)imageStr payName:(NSString *)payname payTip:(NSString *)payTip tag:(NSInteger)buttontag
{
    UIView *bgview = [[UIView alloc] init];
    
    
    UIImageView *memberInfoView = [[UIImageView alloc] init];
    memberInfoView.image = [UIImage imageNamed:imageStr];
    [bgview addSubview:memberInfoView];
    [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(12));
        make.centerY.mas_equalTo(bgview.mas_centerY);
        make.width.mas_equalTo(WidthRate(38));
        make.height.mas_equalTo(HeightRate(38));
    }];
    
    UILabel *catagoryLable = [[UILabel alloc] init];
    catagoryLable.backgroundColor = ColorWithHexString(@"ffffff");
    catagoryLable.text = payname;
    catagoryLable.font = [UIFont systemFontOfSize:AdaptFont(16)];
    [bgview addSubview:catagoryLable];
    [catagoryLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberInfoView.mas_centerY).offset(HeightRate(-8));
        make.left.mas_equalTo(memberInfoView.mas_right).offset(WidthRate(10));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *catagoryTipLable = [[UILabel alloc] init];
    catagoryTipLable.textColor = ColorWithHexString(@"999999");
    catagoryTipLable.text = payTip;
    catagoryTipLable.font = [UIFont systemFontOfSize:AdaptFont(10)];
    [bgview addSubview:catagoryTipLable];
    [catagoryTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberInfoView.mas_centerY).offset(HeightRate(8));
        make.left.mas_equalTo(memberInfoView.mas_right).offset(WidthRate(10));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UIButton *paySelectButton = [[UIButton alloc] init];
    [paySelectButton setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
    [paySelectButton setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
    paySelectButton.tag = buttontag ;
    [paySelectButton addTarget:self action:@selector(selectPayButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:paySelectButton];
    [paySelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberInfoView.mas_centerY);
        make.right.mas_equalTo(-WidthRate(15));
        make.width.mas_equalTo(WidthRate(36));
        make.height.mas_equalTo(HeightRate(36));
    }];
//    self.paySelectButton = paySelectButton;
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = SepratorLineColor;
    [bgview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(WidthRate(10));
        make.right.mas_equalTo(WidthRate(-10));
        
        make.height.mas_equalTo(HeightRate(1));
    }];
    
    return bgview;
}

- (void)showAnimated{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [self.maskView addSubview:self];

    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, -HeightRate(481));
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)removeView{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.transform =
                         CGAffineTransformMakeTranslation(0, ScreenHeight);
                     }
                     completion:^(BOOL finished) {
                         
                         [self.maskView removeFromSuperview];
                     }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
