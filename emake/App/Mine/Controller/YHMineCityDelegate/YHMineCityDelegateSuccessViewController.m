//
//  YHMineCityDelegateSuccessViewController.m
//  emake
//
//  Created by zhangshichao on 2018/9/18.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineCityDelegateSuccessViewController.h"
#import "YHMineMemberIInterestIncomeViewController.h"
#import "HRAdView.h"
#import "YHCommonWebViewController.h"
#import "YHShareView.h"
@interface YHMineCityDelegateSuccessViewController ()

@property(nonatomic,strong)NSDictionary *coupondic;
@property(nonatomic,strong)NSArray *successArr;

@property(nonatomic,strong)UIView *ViewScrol;
@property(nonatomic,strong)UILabel *couponLable;

@end

@implementation YHMineCityDelegateSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"会员招募";
    [self configUI];
    [self getAppAgengtCashData];
    [self getAppUserAgentCoupon];
    [self share];
}
-(void)getAppAgengtCashData
{
    [[YHJsonRequest shared] getAppAgentCashSuccessBlock:^(NSArray *success) {
        
        if (success.count >0) {
            HRAdView* adView = [[HRAdView alloc]initWithTitles:success];
            adView.frame = CGRectMake(0, HeightRate(0), ScreenWidth-WidthRate(15), HeightRate(36));
            adView.time = 2.0f;
            [self.ViewScrol addSubview:adView];
            if (success.count >=1) {
                [adView beginScroll];
            }
            
        }
      
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];
    }];
}
-(void)getAppUserAgentCoupon
{
    [[YHJsonRequest shared] getAppUserAgentSuccessBlock:^(NSDictionary *success) {
        
        self.coupondic= success;
        if (success.count > 0) {
            self.couponLable.attributedText=[self getCouponLableAttrbute:success[@"CouponCode"] CouponPrice:success[@"CouponPrice"] CategoryBName:success[@"CategoryBName"]];

        }
        
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.5 position:CSToastPositionCenter];

    }];
    
}

-(void)configUI
{
    UIImageView *topImage = [[UIImageView alloc] init];
    topImage.image = [UIImage imageNamed:@"huiyuanB"] ;
//    topImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenWidth);
        make.top.mas_equalTo(TOP_BAR_HEIGHT);
        make.height.mas_equalTo(HeightRateCommon(277));

    }];
    
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(15));
        make.right.mas_equalTo(WidthRate(-15));
        make.top.mas_equalTo(topImage.mas_bottom).offset(HeightRate(30));
        make.height.mas_equalTo(HeightRateCommon(60));
        
    }];
    self.ViewScrol = bgView;
    
    UIButton *LookDetailRulerButton = [[UIButton alloc] init];
    [LookDetailRulerButton setTitle:@"代理商规则" forState:UIControlStateNormal];
    [LookDetailRulerButton addTarget:self action:@selector(CityAgentRuler) forControlEvents:UIControlEventTouchUpInside];
    LookDetailRulerButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [LookDetailRulerButton setTitleColor:ColorWithHexString(@"F8695D") forState:UIControlStateNormal];
    LookDetailRulerButton.backgroundColor = ColorWithHexString(@"ffffff");
    LookDetailRulerButton.clipsToBounds = YES;
    LookDetailRulerButton.layer.cornerRadius = HeightRate(15);
    LookDetailRulerButton.layer.borderWidth =1;
    LookDetailRulerButton.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
    [self.view addSubview:LookDetailRulerButton];
    [LookDetailRulerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.width.mas_equalTo(WidthRate(107));
        make.top.mas_equalTo(HeightRate(6)+(TOP_BAR_HEIGHT));
        make.height.mas_equalTo(HeightRate(30));
        
    }];
    
    
    NSString *inviteMoney = @"2100元";
    UILabel *BGTitleLabel = [[UILabel alloc] init];
//    BGTitleLabel.text =[NSString stringWithFormat:@"每邀请一个用户成功成为会员得\n最高%@\n现金可提现"] ;
    BGTitleLabel.numberOfLines = 0;
    BGTitleLabel.textAlignment = NSTextAlignmentCenter;
    BGTitleLabel.font = [UIFont boldSystemFontOfSize:AdaptFont(20)];
    BGTitleLabel.textColor =ColorWithHexString(@"ffffff");
    [self.view addSubview:BGTitleLabel];
    [BGTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(40));
        make.right.mas_equalTo(WidthRate(-40));
 make.top.mas_equalTo(LookDetailRulerButton.mas_bottom).offset(HeightRate(10));
//        make.height.mas_equalTo(HeightRate(30));
        
    }];
    
    
    NSString *bgtitleStr = [NSString stringWithFormat:@"每邀请一个用户成功成为会员得\n最高%@\n现金可提现",inviteMoney];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:bgtitleStr];
    [att addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:AdaptFont(28)] range:NSMakeRange(17, inviteMoney.length) ];
    BGTitleLabel.attributedText = att;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = SepratorLineColor;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(-9));
        make.top.mas_equalTo(bgView.mas_bottom).offset(HeightRate(0));
        make.height.mas_equalTo(HeightRateCommon(1));
        
    }];
    
    NSString *mymoney =  Userdefault(DelegateMyMoney);
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text =[NSString stringWithFormat:@"已获得现金 %@元 ",[Tools getHaveNum:mymoney.doubleValue]] ;
    moneyLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    moneyLabel.textColor =ColorWithHexString(@"F8695D");
    [self.view addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(15));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(30));
        
    }];
    
    UIButton *LookDetailButton = [[UIButton alloc] init];
    [LookDetailButton setTitle:@"查看收入明细" forState:UIControlStateNormal];
    [LookDetailButton addTarget:self action:@selector(lookIncomeDetail) forControlEvents:UIControlEventTouchUpInside];
    LookDetailButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [LookDetailButton setTitleColor:ColorWithHexString(@"F8695D") forState:UIControlStateNormal];
    LookDetailButton.clipsToBounds = YES;
    LookDetailButton.layer.cornerRadius = 6;
    LookDetailButton.layer.borderWidth =1;
    LookDetailButton.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
    [self.view addSubview:LookDetailButton];
    [LookDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.width.mas_equalTo(WidthRate(107));
        make.top.mas_equalTo(line.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(30));
        
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = SepratorLineColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(0));
        make.right.mas_equalTo(WidthRate(-0));
        make.top.mas_equalTo(LookDetailButton.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRateCommon(8));
        
    }];
    
  
//    [attrStr addAttribute:NSFontAttributeName
//                    value:[UIFont systemFontOfSize:30.0f]
//                    range:NSMakeRange(0, 3)];
    
    UILabel *myFreightCodeLabel = [[UILabel alloc] init];
    myFreightCodeLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    myFreightCodeLabel.textColor =ColorWithHexString(@"F8695D");
    myFreightCodeLabel.numberOfLines = 0;
//    myFreightCodeLabel.attributedText =attrStr;
    [self.view addSubview:myFreightCodeLabel];
    [myFreightCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WidthRate(15));
        make.right.mas_equalTo(WidthRate(-15));

        make.top.mas_equalTo(line2.mas_bottom).offset(HeightRate(10));
        make.height.mas_equalTo(HeightRate(60));
        
    }];
    self.couponLable = myFreightCodeLabel;
    
    UIButton *memberDevelopButton = [[UIButton alloc] init];
    [memberDevelopButton setTitle:@"立即发展" forState:UIControlStateNormal];
    memberDevelopButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [memberDevelopButton addTarget:self action:@selector(CityDevelopBottonClick) forControlEvents:UIControlEventTouchUpInside];
    [memberDevelopButton setTitleColor:ColorWithHexString(@"ffffff") forState:UIControlStateNormal];
    memberDevelopButton.backgroundColor = ColorWithHexString(@"F8695D");
    memberDevelopButton.clipsToBounds = YES;
    memberDevelopButton.layer.cornerRadius = 6;
    memberDevelopButton.layer.borderWidth =1;
    memberDevelopButton.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
    [self.view addSubview:memberDevelopButton];
    [memberDevelopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WidthRate(-15));
        make.left.mas_equalTo(WidthRate(15));
        make.bottom.mas_equalTo(HeightRate(-20));
        make.height.mas_equalTo(HeightRate(40));
        
    }];
}

-(void)CityDevelopBottonClick
{
    NSString *userID = Userdefault(LOGIN_USERID);
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"城市代理商";
    vc.URLString = [NSString stringWithFormat:@"%@%@",CityAgentCouponShareURL,userID]; ;
    vc.isShare = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)lookIncomeDetail
{
    YHMineMemberIInterestIncomeViewController *vc = [[YHMineMemberIInterestIncomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(NSMutableAttributedString *)getCouponLableAttrbute:(NSString *)code CouponPrice:(NSString *)CouponPrice CategoryBName:(NSString *)CategoryBName

{
    NSString *str=@"我的优惠码：";
    NSString *str1= code;//;@"我的优惠码：13912345678";
    NSString *str2= [NSString stringWithFormat:@"输入优惠码各品类各减%@元",[Tools getHaveNum:CouponPrice.doubleValue]];//@"（输入优惠码直减200元）";
    NSString *str3= [NSString stringWithFormat:@"仅限：%@",CategoryBName] ;//@"仅限：输配电／休闲食品行业";
    NSString *resultstr = [NSString stringWithFormat:@"%@%@\n%@\n%@",str,str1,str2,str3];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:resultstr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"999999")
                    range:NSMakeRange(str.length+ str1.length, resultstr.length-str1.length-str.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(@"333333")
                    range:NSMakeRange(0, str.length)];
    return attrStr;
}

-(void)share
{
   
    self.shareblock = ^() {
        NSString *userID = Userdefault(LOGIN_USERID);
        YHShareView *share = [[YHShareView alloc] initShareWithContentTitle:@"易智造" theOtherTitle:@"城市代理商领取优惠码" image:nil url:[NSString stringWithFormat:@"%@%@",CityAgentCouponShareURL,userID] withCancleTitle:@"取消"];
        [share showAnimated];
    };
}
-(void)CityAgentRuler
{
    
    YHCommonWebViewController *vc = [[YHCommonWebViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.titleName = @"城市代理商规则";
    vc.URLString = UserCityAgentRulerURL;
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
