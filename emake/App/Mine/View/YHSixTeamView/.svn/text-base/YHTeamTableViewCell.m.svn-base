//
//  YHTeamTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHTeamTableViewCell.h"

@implementation YHTeamTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        UILabel *line = [[UILabel alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = ColorWithHexString(@"E4E4E4");
        [self addSubview:line];
        [line PSSetLeft:0];
        [line PSSetBottom:0];
        [line PSSetRight:0];
        [line PSSetHeight:1];
        
        UIImageView * imageview    = [[UIImageView alloc] init];
        imageview.translatesAutoresizingMaskIntoConstraints = NO;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.image = [UIImage imageNamed:@"placehold"];
        imageview.layer.cornerRadius =  25;
        imageview.clipsToBounds = YES;
        [self addSubview:imageview];
        [imageview PSSetLeft:WidthRate(13)];
        [imageview PSSetSize:50 Height:50];
//        [imageview PSSetCenterHorizontalAtItem:self];
        [imageview PSSetTop:HeightRate(10)];
        [imageview PSSetBottom:HeightRate(10)];
        self.headImageView = imageview;
        
        UIImageView * leadImage    = [[UIImageView alloc] init];
        leadImage.translatesAutoresizingMaskIntoConstraints = NO;
        leadImage.image = [UIImage imageNamed:@"placehold"];
        
        [self addSubview:leadImage];
        [leadImage PSSetLeft:WidthRate(75)];
        [leadImage PSSetSize:WidthRate(13) Height:HeightRate(12)];
        [leadImage PSSetTop:HeightRate(24)];
        self.leadImageView = leadImage;
        
        UILabel *leadName = [[UILabel alloc] init];
        leadName.translatesAutoresizingMaskIntoConstraints = NO;
        leadName.text = @"队长大大";
        leadName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        leadName.numberOfLines = 0;
        leadName.textColor = ColorWithHexString(@"333333");
        [self addSubview:leadName];
        [leadName PSSetSize:WidthRate(120) Height:HeightRate(34)];
        [leadName PSSetRightAtItem:leadImage Length:3];
        self.leadName = leadName;
        
//        UILabel *detailName = [[UILabel alloc] init];
//        detailName.translatesAutoresizingMaskIntoConstraints = NO;
//        detailName.text = @"bidk大";
//        detailName.font = [UIFont systemFontOfSize:AdaptFont(12)];
//        detailName.textColor = ColorWithHexString(@"999999");
//        [self addSubview:detailName];
//        detailName.numberOfLines = 0;
//        [detailName PSSetRightAtItem:leadName Length:WidthRate(8)];
////        [detailName PSSetLeft:WidthRate(75)];
////        [detailName PSSetSize:WidthRate(120) Height:HeightRate(34)];
////        [detailName PSSetBottomAtItem:leadImage Length:3];
//        self.detailLable = detailName;
        
        UIImageView * phoneImage    = [[UIImageView alloc] init];
        phoneImage.translatesAutoresizingMaskIntoConstraints = NO;
        phoneImage.image = [UIImage imageNamed:@"shoujiicon"];
        phoneImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:phoneImage];
        [phoneImage PSSetLeft:WidthRate(75)];
        [phoneImage PSSetSize:WidthRate(8) Height:HeightRate(14)];
        [phoneImage PSSetBottomAtItem:leadName Length:3];
        
        
        UILabel *phoneNumber = [[UILabel alloc] init];
        phoneNumber.translatesAutoresizingMaskIntoConstraints = NO;
        phoneNumber.text = @"133-3896-9241";
        phoneNumber.font = [UIFont systemFontOfSize:AdaptFont(12)];
        phoneNumber.textColor = ColorWithHexString(@"333333");
        [self addSubview:phoneNumber];
        [phoneNumber PSSetRightAtItem:phoneImage Length:3];
        self.phoneLable = phoneNumber;
        
//        UILabel * companyName = [[UILabel alloc] init];
//        companyName.translatesAutoresizingMaskIntoConstraints = NO;
//        companyName.text = @"疏奏断路器经销公司";
//        companyName.font = [UIFont systemFontOfSize:AdaptFont(13)];
//        companyName.textColor = ColorWithHexString(@"797979");
//        [self addSubview:companyName];
//        [companyName PSSetLeft:WidthRate(75)];
//        [companyName PSSetBottomAtItem:phoneImage Length:3];
//        self.companyName = companyName;
//
//
//        UILabel * companyAddress = [[UILabel alloc] init];
//        companyAddress.translatesAutoresizingMaskIntoConstraints = NO;
//        companyAddress.text = @"疏奏断路器经销公司dizheoooooo";
//        companyAddress.font = [UIFont systemFontOfSize:AdaptFont(13)];
//        companyAddress.textColor = ColorWithHexString(@"797979");
//        [self addSubview:companyAddress];
//        [companyAddress PSSetLeft:WidthRate(75)];
//        [companyAddress PSSetBottomAtItem:companyName Length:3];
//        [companyAddress PSSetBottom:HeightRate(15)];
//        self.companyAddress = companyAddress;
        
        UIImageView *contributionGolds = [[UIImageView alloc] init];
        contributionGolds.translatesAutoresizingMaskIntoConstraints = NO;
        contributionGolds.backgroundColor = [UIColor whiteColor];
        contributionGolds.layer.borderColor = ColorWithHexString(@"4DBECD").CGColor;
        contributionGolds.layer.borderWidth = 1;
        contributionGolds.clipsToBounds = YES;
        contributionGolds.layer.cornerRadius = HeightRate(30);
        contributionGolds.userInteractionEnabled = YES;
        contributionGolds.clipsToBounds = YES;
        contributionGolds.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:contributionGolds];
        [contributionGolds PSSetRight:WidthRate(-27)];
        [contributionGolds PSSetSize:WidthRate(180) Height:HeightRate(54)];
        [contributionGolds PSSetCenterVerticalAtItem:imageview];
        self.contributeImageview =  contributionGolds;
        
        UIImageView *contributed = [[UIImageView alloc] init];
        contributed.translatesAutoresizingMaskIntoConstraints = NO;
        contributed.image = [UIImage imageNamed:@"dingdanicon"];
        [contributionGolds addSubview:contributed];
        [contributed PSSetLeft:WidthRate(15)];
        [contributed PSSetSize:WidthRate(16) Height:HeightRate(15)];
        [contributed PSSetTop:HeightRate(10)];
        
        
        UIImageView *rightImage = [[UIImageView alloc] init];
        rightImage.translatesAutoresizingMaskIntoConstraints = NO;
        rightImage.image = [UIImage imageNamed:@"right01"];
        rightImage.contentMode = UIViewContentModeScaleAspectFill;
        [contributionGolds addSubview:rightImage];
        [rightImage PSSetRight:30];
        [rightImage PSSetSize:WidthRate(8) Height:HeightRate(14)];
        [rightImage PSSetTop:HeightRate(5)];
        self.rightImageView  = rightImage;
        UILabel *contributedLable = [[UILabel alloc] init];
        contributedLable.translatesAutoresizingMaskIntoConstraints = NO;
        contributedLable.text = @"以贡献200万金额";
        contributedLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [contributionGolds addSubview:contributedLable];
        [contributedLable PSSetRightAtItem:contributed Length:2];
        self.contributedLable = contributedLable;
        
        UIImageView *called = [[UIImageView alloc] init];
        called.translatesAutoresizingMaskIntoConstraints = NO;
        called.image = [UIImage imageNamed:@"xiaohuobanrehsu"];
        [contributionGolds addSubview:called];
        [called PSSetLeft:WidthRate(15)];
        [called PSSetSize:WidthRate(14) Height:HeightRate(14)];
        [called PSSetBottomAtItem:contributed Length:HeightRate(5)];
        self.calledImageview = called;
        
        UILabel *calledLable = [[UILabel alloc] init];
        calledLable.translatesAutoresizingMaskIntoConstraints = NO;
        calledLable.text = @"以召集200个小伙伴";
        calledLable.font = [UIFont systemFontOfSize:AdaptFont(13)];

        [contributionGolds addSubview:calledLable];
        [calledLable PSSetRightAtItem:called Length:2];
        self.calledLable = calledLable;
    }
    
    return self;
    
}
@end
