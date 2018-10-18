//
//  YHMemberExperienceViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/14.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMemberExperienceViewController.h"
#import "YHPayViewController.h"
#import "YHMineMemberInterestViewController.h"
#import "YHCommonWebViewController.h"
@interface YHMemberExperienceViewController ()<YHAlertViewDelegete>

@end

@implementation YHMemberExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的会员权益";
    [self ConfigUI];
    
    
}

-(void)ConfigUI
{
    UIView *topBackView = [[UIView alloc] init];
    topBackView.backgroundColor = ColorWithHexString(@"F3D9AA");
    topBackView.layer.cornerRadius = 6;
    topBackView.clipsToBounds= YES;
    [self.view addSubview:topBackView];
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+HeightRate(9));
        make.left.mas_equalTo(WidthRate(9));
        make.width.mas_equalTo(WidthRate(357));
        make.height.mas_equalTo(HeightRate(206));
    }];
    
    UIImageView *topTitleImageView = [[UIImageView alloc] init];
    topTitleImageView.image = [UIImage imageNamed:@"huiyuan02"];
    [self.view addSubview:topTitleImageView];
    [topTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(topBackView.mas_top).offset(HeightRate(4));
//        make.left.mas_equalTo(topBackView.mas_left).offset(WidthRate(-4));
        make.top.mas_equalTo((TOP_BAR_HEIGHT)+HeightRate(5));
        make.left.mas_equalTo(WidthRate(4));
        make.width.mas_equalTo(WidthRate(128));
        make.height.mas_equalTo(HeightRate(127));
    }];
    
    UIImageView *midTopTitleImageView = [[UIImageView alloc] init];
    midTopTitleImageView.image = [UIImage imageNamed:@"liwuhe"];
    [topBackView addSubview:midTopTitleImageView];
    [midTopTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(0));
        make.centerX.mas_equalTo(topBackView.mas_centerX).offset(WidthRate(0));
        make.width.mas_equalTo(WidthRate(181));
        make.height.mas_equalTo(HeightRate(164));
    }];
    
    UIButton *memberExplainButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    memberExplainButton.layer.borderColor = ColorWithHexString(@"CC894F").CGColor;
//    memberExplainButton.layer.borderWidth = 1;
    memberExplainButton.backgroundColor = ColorWithHexString(@"CC894F");
    memberExplainButton.layer.cornerRadius = HeightRate(12);
    memberExplainButton.clipsToBounds = YES;
    memberExplainButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(AdaptFont(10))];
    [memberExplainButton setTitle:@"会员说明" forState:UIControlStateNormal];
    [memberExplainButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    [memberExplainButton addTarget:self action:@selector(VipIntroductionButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [topBackView addSubview:memberExplainButton];
    [memberExplainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HeightRate(6));
        make.right.mas_equalTo(WidthRate(-6));
        make.width.mas_equalTo(WidthRate(72));
        make.height.mas_equalTo(HeightRate(24));
    }];
    
    UILabel *topTitleLable = [[UILabel alloc] init];
    topTitleLable.text = @"全品类会员价订购";
    topTitleLable.textAlignment = NSTextAlignmentCenter;
    topTitleLable.textColor = ColorWithHexString(@"E5C99E");
    topTitleLable.font = [UIFont systemFontOfSize:AdaptFont(12)];
    topTitleLable.textColor = [UIColor whiteColor];
    [midTopTitleImageView addSubview:topTitleLable];
    [topTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(midTopTitleImageView.mas_centerY).offset(HeightRate(30));
        make.centerX.mas_equalTo(midTopTitleImageView.mas_centerX).offset(HeightRate(0));
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *topNumberLable = [[UILabel alloc] init];
    topNumberLable.text = [NSString stringWithFormat:@"%@次",self.VipCount];;
    topNumberLable.textAlignment = NSTextAlignmentCenter;
    topNumberLable.font = [UIFont systemFontOfSize:AdaptFont(15)];
    topNumberLable.textColor = [UIColor whiteColor];
    [topBackView addSubview:topNumberLable];
    [topNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(midTopTitleImageView.mas_centerX).offset(HeightRate(0));
        make.top.mas_equalTo(topTitleLable.mas_bottom);
        make.height.mas_equalTo(HeightRate(30));
    }];
    
    UILabel *dateLable = [[UILabel alloc] init];
    NSString *date = self.VipDate.length>10?[self.VipDate substringToIndex:10]:@"";
    dateLable.text = [NSString stringWithFormat:@"有效期到%@",date];
    dateLable.textAlignment = NSTextAlignmentCenter;
    dateLable.font = [UIFont systemFontOfSize:AdaptFont(11)];
    dateLable.textColor = ColorWithHexString(@"F3D9AA");
    dateLable.backgroundColor = ColorWithHexString(@"333333");

    [topBackView addSubview:dateLable];
    [dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HeightRate(40));
        
    }];
    
    UILabel *MemberRulerLable = [[UILabel alloc] init];
    MemberRulerLable.text = @"1、会员体验礼包权益：自领取易智造会员体验礼包之日开始，享有商品会员价三次订购的权益；\n\n2、会员体验礼包期限：领取之日后的30天内；\n\n3、会员体验礼包说明：\n· 在会员体验礼包期限内，三次商品会员价订购权益使用结束或会员体验礼包期限结束之后，无法再继续享有会员的相关权益；\n·超过会员体验礼包期限，如三次商品会员价订购权益未使用或剩余部分订购权益，将自动失效；\n· 每个用户限领取一次；\n· 商品会员价三次订购的权益不限行业和订单额；";
    MemberRulerLable.numberOfLines = 0;
    MemberRulerLable.font = [UIFont systemFontOfSize:AdaptFont(11)];
    MemberRulerLable.textColor = ColorWithHexString(@"CC894F");
    MemberRulerLable.backgroundColor = ColorWithHexString(@"ffffff");
    [self.view addSubview:MemberRulerLable];
    [MemberRulerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topBackView.mas_bottom).offset(HeightRate(8));
        make.left.mas_equalTo(WidthRate(13));
        make.right.mas_equalTo(WidthRate(-13));
        
    }];
    
    NSString *fTip = @"本次活动具体解释权归易智造平台，如有疑问，请咨询客服";
    NSString *bTip = @"客服电话：400-867-0211";
    NSString *tip =[NSString stringWithFormat:@"%@ \n %@",fTip,bTip];
    NSMutableAttributedString *tipSttr = [[NSMutableAttributedString alloc] initWithString:tip];
    [tipSttr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"CC894F")
                    range:NSMakeRange(fTip.length, tip.length-fTip.length)];
    
    UILabel *MemberTipLable = [[UILabel alloc] init];
    MemberTipLable.numberOfLines = 0;
    MemberTipLable.font = [UIFont systemFontOfSize:AdaptFont(11)];
    MemberTipLable.textColor = ColorWithHexString(@"999999");
    MemberTipLable.backgroundColor = ColorWithHexString(@"FFFFCC");
    MemberTipLable.layer.borderColor = ColorWithHexString(@"F3D9AA").CGColor;
    MemberTipLable.layer.borderWidth = 1;
    MemberTipLable.attributedText = tipSttr;
    [self.view addSubview:MemberTipLable];
    [MemberTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MemberRulerLable.mas_bottom).offset(HeightRate(10));
        make.left.mas_equalTo(WidthRate(13));
        make.right.mas_equalTo(WidthRate(-13));
        make.height.mas_equalTo(HeightRate(55));
        
    }];
    
    UIButton *payMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payMoneyButton setTitle:@"购买正式会员" forState:UIControlStateNormal];
    [payMoneyButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    payMoneyButton.backgroundColor = ColorWithHexString(@"D70606");
    payMoneyButton.layer.cornerRadius = 6;
    payMoneyButton.clipsToBounds = YES;
    [payMoneyButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payMoneyButton];
    [payMoneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MemberTipLable.mas_bottom).offset(HeightRate(10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(WidthRate(310));
        make.height.mas_equalTo(HeightRate(40));
    }];
}

-(void)payButtonClick
{
//    YHPayViewController *vc = [[YHPayViewController alloc] init];
//    vc.isHidenTopTitle = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    YHMineMemberInterestViewController *vc = [[YHMineMemberInterestViewController alloc] init];
    vc.isExperienceVip = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)VipIntroductionButtonClick
{
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"会员说明";
    vc.URLString = UserVipInstructionURL;
    [self.navigationController pushViewController:vc animated:YES];
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
