//
//  YHMissonTaskCollectionViewCell.m
//  emake
//
//  Created by 张士超 on 2018/2/7.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMissonTaskCollectionViewCell.h"

@implementation YHMissonTaskCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *teamView = [[UIView alloc]init];
        teamView.backgroundColor = [UIColor whiteColor];
        teamView.layer.borderWidth = 1.5;
        teamView.layer.borderColor = SepratorLineColor.CGColor;
        teamView.layer.cornerRadius = WidthRate(3);
        [self.contentView addSubview:teamView];
        
        [teamView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(11));
            make.top.mas_equalTo(HeightRate(3));
            make.right.mas_equalTo(WidthRate(-11));
            make.height.mas_equalTo(HeightRate(127));
        }];
        
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"renwupeitu"]];
        [teamView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(1));
            make.width.mas_equalTo(WidthRate(112));
            make.height.mas_equalTo(HeightRate(109));
            make.centerY.mas_equalTo(teamView.mas_centerY);
        }];
        
        UILabel *title = [[UILabel alloc]init];
        title.font = SYSTEM_FONT(AdaptFont(17));
        title.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        title.text = @"组建任务团队  领取现金大奖";
        title.textAlignment = NSTextAlignmentCenter;
        [teamView addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(2));
            make.top.mas_equalTo(HeightRate(10));
            make.right.mas_equalTo(WidthRate(-18));
        }];
        
        NSArray *items = @[@"100万任务包",@"200万任务包",@"500万任务包"];
        for (int i=0; i<3; i++) {
            
            UILabel *item = [[UILabel alloc]init];
            item.text = items[i];
            item.font = SYSTEM_FONT(AdaptFont(10));
            item.textAlignment = NSTextAlignmentCenter;
            item.textColor = TextColor_666666;
            item.layer.cornerRadius = WidthRate(3);
            item.layer.borderWidth = WidthRate(1);
            item.layer.borderColor = TextColor_666666.CGColor;
            [teamView addSubview:item];
            
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(4)+WidthRate(75)*i);
                make.top.mas_equalTo(title.mas_bottom).offset(HeightRate(6));
                make.width.mas_equalTo(WidthRate(70));
                make.height.mas_equalTo(HeightRate(19));
            }];
        }
        
        UIButton *goTeam = [UIButton buttonWithType:UIButtonTypeCustom];
//        [goTeam addTarget:self action:@selector(goTeamVC) forControlEvents:UIControlEventTouchUpInside];
        goTeam.layer.cornerRadius = HeightRate(19);
        goTeam.layer.borderColor = (ColorWithHexString(APP_THEME_MAIN_COLOR)).CGColor;
        goTeam.layer.borderWidth = WidthRate(2);
        [goTeam setTitle:@"   领任务组团队" forState:UIControlStateNormal];
        [goTeam setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        goTeam.titleLabel.font =SYSTEM_FONT(AdaptFont(18));
        goTeam.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [teamView addSubview:goTeam];
        goTeam.userInteractionEnabled = NO;
        
        [goTeam mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-18));
            make.height.mas_equalTo(HeightRate(38));
            make.width.mas_equalTo(WidthRate(169));
            make.top.mas_equalTo(title.mas_bottom).offset(HeightRate(40));
        }];
        
        
        UIImageView *goImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"go"]];
        [teamView addSubview:goImage];
        
        [goImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-30));
            make.width.mas_equalTo(WidthRate(28));
            make.height.mas_equalTo(WidthRate(28));
            make.centerY.mas_equalTo(goTeam.mas_centerY);
        }];
    }
    return self;
}
@end
