//
//  YHTeamProgressView.m
//  emake
//
//  Created by 张士超 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHTeamProgressView.h"
#import "UIView+PSAutoLayout.h"
#import "teamModel.h"
#import "UIImageView+WebCache.h"
@implementation YHTeamProgressView

-(UIView *)progressViewWithModel:(teamModel *)Model
{
    
//    NSString *currentMoney =[Tools getNsstringFromDouble:Model.CurrentMoney isShowUNIT:YES];
//    NSString *CompleteMoney =[Tools getNsstringFromDouble:Model.CompleteMoney isShowUNIT:YES];


    UIView *bgView = [[UIView alloc] init];
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    bgView.backgroundColor = ColorWithHexString(@"ffffff");
    
    
    UIImageView * imageview    = [[UIImageView alloc] init];
    imageview.translatesAutoresizingMaskIntoConstraints = NO;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [imageview sd_setImageWithURL:[NSURL URLWithString:Model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"tuanzhang"]];
    imageview.layer.cornerRadius =  25;
    imageview.clipsToBounds = YES;
    [bgView addSubview:imageview];
    [imageview PSSetLeft:WidthRate(16)];
    [imageview PSSetSize:50 Height:50];
    [imageview PSSetTop:HeightRate(14)];
//    self.headImageView = imageview;
    
    UIImageView * leadImage    = [[UIImageView alloc] init];
    leadImage.translatesAutoresizingMaskIntoConstraints = NO;
    leadImage.image = [UIImage imageNamed:@"wode_renzheng"];
    
    [bgView addSubview:leadImage];
    [leadImage PSSetLeft:WidthRate(75)];
    [leadImage PSSetSize:WidthRate(13) Height:HeightRate(12)];
    [leadImage PSSetTop:HeightRate(20)];
//    self.leadImageView = leadImage;
    
    UILabel *leadName = [[UILabel alloc] init];
    leadName.translatesAutoresizingMaskIntoConstraints = NO;
    leadName.text = Model.RealName;
    leadName.font = [UIFont systemFontOfSize:AdaptFont(14)];
    leadName.textColor = ColorWithHexString(@"333333");
    [bgView addSubview:leadName];
    [leadName PSSetRightAtItem:leadImage Length:HeightRate(8)];
//    self.leadName = leadName;
    UIImageView * phoneImage    = [[UIImageView alloc] init];
    phoneImage.translatesAutoresizingMaskIntoConstraints = NO;
    phoneImage.image = [UIImage imageNamed:@"shoujiicon"];
    phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:phoneImage];
    [phoneImage PSSetLeft:WidthRate(75)];
    [phoneImage PSSetSize:WidthRate(8) Height:HeightRate(14)];
    [phoneImage PSSetBottomAtItem:leadImage Length:3];
    
    
    UILabel *phoneNumber = [[UILabel alloc] init];
    phoneNumber.translatesAutoresizingMaskIntoConstraints = NO;
    phoneNumber.text =Model.MobileNumber;
    phoneNumber.font = [UIFont systemFontOfSize:AdaptFont(12)];
    phoneNumber.textColor = ColorWithHexString(@"333333");
    [bgView addSubview:phoneNumber];
    [phoneNumber PSSetRightAtItem:phoneImage Length:3];
//    self.phoneLable = phoneNumber;
    
    UIView *contributionGolds = [[UIView alloc] init];
    contributionGolds.translatesAutoresizingMaskIntoConstraints = NO;
    contributionGolds.backgroundColor = ColorWithHexString(@"4DBECD");

    contributionGolds.userInteractionEnabled = YES;
    [bgView addSubview:contributionGolds];
    [contributionGolds PSSetRight:WidthRate(0)];
    [contributionGolds PSSetSize:WidthRate(152) Height:HeightRate(46)];
    [contributionGolds PSSetCenterHorizontalAtItem:imageview];
    self.getMoneyView =  contributionGolds;
    
    UIImageView *contributed = [[UIImageView alloc] init];
    contributed.translatesAutoresizingMaskIntoConstraints = NO;
    contributed.image = [UIImage imageNamed:@"renwubaopeitu"];
    [contributionGolds addSubview:contributed];
    [contributed PSSetLeft:WidthRate(12)];
    [contributed PSSetSize:WidthRate(27) Height:HeightRate(27)];
    [contributed PSSetCenterHorizontalAtItem:contributionGolds];

    
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.translatesAutoresizingMaskIntoConstraints = NO;
    rightImage.image = [UIImage imageNamed:@"ketixianrukouicon"];
    rightImage.contentMode = UIViewContentModeScaleAspectFit;
    [contributionGolds addSubview:rightImage];
    [rightImage PSSetRight:WidthRate(5)];
    [rightImage PSSetSize:WidthRate(25) Height:HeightRate(25)];
    [rightImage PSSetCenterHorizontalAtItem:contributionGolds];
//    self.rightImageView  = rightImage;
    
    
    NSString *AccountAmountMoney =[Tools getNsstringFromDouble:Model.AccountAmount.doubleValue isShowUNIT:NO];
    UILabel *contributedLable = [[UILabel alloc] init];
    contributedLable.translatesAutoresizingMaskIntoConstraints = NO;
    contributedLable.text =[NSString stringWithFormat:@"%@元\n可提现奖励",AccountAmountMoney];
    contributedLable.numberOfLines = 0;
    contributedLable.textAlignment = NSTextAlignmentCenter;
    contributedLable.textColor = ColorWithHexString(@"ffffff");
    contributedLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [contributionGolds addSubview:contributedLable];
//    [contributedLable PSSetRightAtItem:contributed Length:2];
    [contributedLable PSSetWidth:WidthRate(86)];
    [contributedLable PSSetHeight:HeightRate(46)];
    [contributedLable PSSetRightAtItem:contributed Length:WidthRate(5)];
//    [contributedLable PSSetCenterHorizontalAtItem:contributionGolds];
//    [contributedLable PSSetCenterYOnItem:contributed OnItem:rightImage];
//    self.contributedLable = contributedLable;
    
 
  
        UILabel *progressLable = [[UILabel alloc] init];
        progressLable.translatesAutoresizingMaskIntoConstraints = NO;
//        progressLable.text = @"已贡献金额";
        progressLable.textColor =  ColorWithHexString(@"949494");
        progressLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [bgView addSubview:progressLable];
    [progressLable PSSetBottomAtItem:contributedLable Length:HeightRate(8)];
        [progressLable PSSetLeft:WidthRate(17)];
    
//    进度条progressview
    UIView *progress = [[UIView alloc] init];
    progress.translatesAutoresizingMaskIntoConstraints = NO;
    [bgView addSubview:progress];
    [progress PSSetWidth:ScreenWidth];
    [progress PSSetBottomAtItem:contributedLable Length:HeightRate(8)];
    [progress PSSetLeft:0];
    [progress PSSetHeight:HeightRate(105)];
    self.progressCustonmView = progress;
    
    
    NSString *ExtraBonusMoney =[Tools getNsstringFromDouble:Model.ExtraBonus.doubleValue isShowUNIT:YES];
    NSString *ExtraContractAmountMoney =[Tools getNsstringFromDouble:Model.ExtraContractAmount.doubleValue isShowUNIT:YES];
    
    
    
    UILabel *tipsLable = [[UILabel alloc] init];
    tipsLable.textColor = ColorWithHexString(@"949494");

    tipsLable.translatesAutoresizingMaskIntoConstraints = NO;
    tipsLable.layer.borderWidth = 1;
    tipsLable.layer.borderColor = ColorWithHexString(SymbolTopColor).CGColor;
    tipsLable.layer.cornerRadius = 12;
    tipsLable.layer.masksToBounds = YES;

//    tipsLable.text = @"距离额外奖励1万元，还差100万订单额";
    tipsLable.textAlignment = NSTextAlignmentCenter;
    tipsLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    [progress addSubview:tipsLable];
//    [tipsLable PSSetBottomAtItem:contributedLable Length:HeightRate(8)];
    [tipsLable PSSetTop:0];
    [tipsLable PSSetHeight:HeightRate(24)];
//    [tipsLable PSSetWidth:WidthRate(247)];
    [tipsLable PSSetCenterX];
    
    NSString * cata = [[NSUserDefaults standardUserDefaults] objectForKey:USERSELECCATEGORY];
    if ([cata isEqualToString:@"001-001"]) {
        NSString *str22 = [NSString stringWithFormat:@"  距离额外奖励%@元，还差%@订单额   ",ExtraBonusMoney,ExtraContractAmountMoney];
        NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:str22];
        [attrStr2 addAttribute:NSForegroundColorAttributeName
                         value:ColorWithHexString(SymbolTopColor)
                         range:NSMakeRange(8, ExtraBonusMoney.length)];
        [attrStr2 addAttribute:NSForegroundColorAttributeName
                         value:ColorWithHexString(SymbolTopColor)
                         range:NSMakeRange(12+ExtraBonusMoney.length, ExtraContractAmountMoney.length)];
        tipsLable.attributedText = attrStr2;

    }else{
      tipsLable.text =  @"  邀请好友越多 提成奖励越多    ";
    }
    int num =(int) Model.TotalContractAmount.doubleValue/5000000;
    NSString *start =[Tools getNsstringFromDouble:5000000*num isShowUNIT:YES];
    NSString *destiny =[Tools getNsstringFromDouble:5000000*(num+1) isShowUNIT:YES];
        UILabel *progressLableNumber = [[UILabel alloc] init];
        progressLableNumber.translatesAutoresizingMaskIntoConstraints = NO;
        progressLableNumber.text = start;
        progressLableNumber.font = [UIFont systemFontOfSize:AdaptFont(18)];
        progressLableNumber.textColor =  ColorWithHexString(@"4DBECD");
        [progress addSubview:progressLableNumber];
        [progressLableNumber PSSetBottomAtItem:tipsLable Length:HeightRate(8)];
        [progressLableNumber PSSetLeft:WidthRate(17)];
        
        UILabel *finalLable = [[UILabel alloc] init];
        finalLable.translatesAutoresizingMaskIntoConstraints = NO;
//        finalLable.text = @"目标金额";
        finalLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
        finalLable.textColor =  ColorWithHexString(@"949494");
        [progress addSubview:finalLable];
    [finalLable PSSetBottomAtItem:contributedLable Length:HeightRate(8)];
        [finalLable PSSetRight:WidthRate(11)];
        
        UILabel *finalLableNumber = [[UILabel alloc] init];
        finalLableNumber.translatesAutoresizingMaskIntoConstraints = NO;
        finalLableNumber.text =destiny ;
        finalLableNumber.font = [UIFont systemFontOfSize:AdaptFont(18)];
        finalLableNumber.textColor =  TextColor_333333;
        [progress addSubview:finalLableNumber];
        [finalLableNumber PSSetBottomAtItem:tipsLable Length:HeightRate(8)];
        [finalLableNumber PSSetRight:WidthRate(11)];
        
        
        
        UILabel *bglable = [[UILabel alloc] init];
        bglable.translatesAutoresizingMaskIntoConstraints = NO;
//        bglable.layer.borderWidth =1;
//        bglable.layer.borderColor = ColorWithHexString(@"C8D8EC").CGColor;
        bglable.backgroundColor = ColorWithHexString(@"CCCCCC");
        [progress addSubview:bglable];
        [bglable PSSetBottomAtItem:finalLableNumber Length:HeightRate(5)];
        [bglable PSSetLeft:WidthRate(24)];
        [bglable PSSetSize:WidthRate(340) Height:HeightRate(10)];
    
    
    NSString *payM =[Tools getNsstringFromDouble:Model.TotalContractAmount.doubleValue isShowUNIT:YES];

    double payMoney = payM.doubleValue;
    double complieteMoney = destiny.doubleValue;
    CGFloat rate =payMoney/complieteMoney;
    CGFloat width =340- 340*(rate>1?1:rate);
        UILabel *payProgress = [[UILabel alloc] init];
        payProgress.translatesAutoresizingMaskIntoConstraints = NO;
//        payProgress.layer.borderColor = ColorWithHexString(@"009999").CGColor;
//        payProgress.layer.borderWidth = 1;
        payProgress.backgroundColor = ColorWithHexString(@"4DBFCF");
        [bglable addSubview:payProgress];
        [payProgress PSSetConstraint:0 Right:WidthRate(width) Top:0 Bottom:0];
    
    NSString *showprogressMoney =[Tools getNsstringFromDouble:Model.TotalContractAmount.doubleValue isShowUNIT:YES];

    NSString *showprogressMoneyStr = [NSString stringWithFormat:@"订单金额 %@ ",showprogressMoney];
    NSMutableAttributedString *attrshowprogressMoneyStr = [[NSMutableAttributedString alloc] initWithString:showprogressMoneyStr];
    [attrshowprogressMoneyStr addAttribute:NSForegroundColorAttributeName
                    value:ColorWithHexString(StandardBlueColor)
                    range:NSMakeRange(5, showprogressMoney.length)];
    

    
    UILabel *currentLable = [[UILabel alloc] init];
    currentLable.translatesAutoresizingMaskIntoConstraints = NO;
    currentLable.textAlignment = NSTextAlignmentCenter;
    currentLable.font = [UIFont systemFontOfSize:AdaptFont(14)];
    currentLable.textColor =  ColorWithHexString(@"949494");
    currentLable.attributedText = attrshowprogressMoneyStr;

    currentLable.numberOfLines = 0;
    [progress addSubview:currentLable];
    [currentLable PSSetBottomAtItem:bglable Length:HeightRate(3)];
    [currentLable PSSetLeft:WidthRate(24)];
    [currentLable PSSetHeight:HeightRate(20)];
    [currentLable PSSetBottom:HeightRate(8)];

    

    UIView *linView= [[UIView alloc] init];
    linView.backgroundColor = ColorWithHexString(@"F2F2F2");
    linView.translatesAutoresizingMaskIntoConstraints = NO;
    [bgView addSubview:linView];
    [linView PSSetBottomAtItem:progress Length:0];
    [linView PSSetLeft:0];
    [linView PSSetSize:ScreenWidth Height:HeightRate(70)];
    [linView PSSetBottom:0];
    
    NSString *teamMoney = [Tools getNsstringFromDouble:Model.TeamContractAmount.doubleValue isShowUNIT:YES];

    UIView *teamView = [self orderBgView:linView priceStr:teamMoney imageName:@"tuanduiicon" State:@"团队订单"];
    [teamView PSSetTop:0];
    [teamView PSSetLeft:0];
    [teamView PSSetSize:ScreenWidth*0.5 Height:HeightRate(70)];
    self.teamView = teamView;
    
    NSString *memberMoney = [Tools getNsstringFromDouble:Model.SelfContractAmount.doubleValue isShowUNIT:YES];
    UIView *personView = [self orderBgView:linView priceStr:memberMoney imageName:@"geren" State:@"个人订单"];
    [personView PSSetTop:0];
    [personView PSSetRight:0];
    [personView PSSetSize:ScreenWidth*0.5 Height:HeightRate(70)];
    self.personView = personView;
//    UILabel *line = [[UILabel alloc] init];
//    line.backgroundColor = ColorWithHexString(@"F2F2F2");
//    line.translatesAutoresizingMaskIntoConstraints = NO;
//    [bgView addSubview:line];
//    [line PSSetBottomAtItem:progress Length:14];
//    [line PSSetLeft:0];
//    [line PSSetSize:ScreenWidth Height:HeightRate(7)];
//    [line PSSetBottom:0];
    return bgView;

}

-(UIView *)orderBgView:(UIView *)bgview priceStr:(NSString *)price imageName:(NSString *)imageName State:(NSString *)orderName
{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [bgview addSubview:view];
    
    UILabel *lablePrice = [[UILabel alloc] init];
    lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
    lablePrice.text = price;
    lablePrice.font = [UIFont systemFontOfSize:AdaptFont(15)];
    lablePrice.textColor = ColorWithHexString(StandardBlueColor);
    lablePrice.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lablePrice];
    lablePrice.translatesAutoresizingMaskIntoConstraints = NO;
    [lablePrice PSSetCenterX];
    [lablePrice PSSetTop:HeightRate(15)];
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:orderName forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:ColorWithHexString(@"000000") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(14)];
    [view addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.userInteractionEnabled = NO;
    [btn PSSetCenterX];
    [btn PSSetBottomAtItem:lablePrice Length:HeightRate(0)];
    [btn PSSetSize:WidthRate(150) Height:HeightRate(30)];
    
    
    return view;
    
}
@end
