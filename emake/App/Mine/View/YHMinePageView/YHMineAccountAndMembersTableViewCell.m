//
//  YHMineAccountAndMembersTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/11.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineAccountAndMembersTableViewCell.h"
@interface YHMineAccountAndMembersTableViewCell ()


@end
@implementation YHMineAccountAndMembersTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *name = [[UILabel alloc] init];
        name.translatesAutoresizingMaskIntoConstraints = NO;
        name.font= [UIFont systemFontOfSize:AdaptFont(13)];
        name.text = @"我的账户";
        name.textColor = ColorWithHexString(@"000000");
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = ColorWithHexString(@"333333");
        [self.contentView addSubview:name];
        [name PSSetCenterXPercent:0.25];
        [name PSSetTop:HeightRate(12)];
        [name PSSetSize:ScreenWidth/2.0-1 Height:HeightRate(20)];
        
        UILabel *sympol = [[UILabel alloc] init];
        sympol.translatesAutoresizingMaskIntoConstraints = NO;
        sympol.font= [UIFont systemFontOfSize:AdaptFont(13)];
        sympol.textAlignment = NSTextAlignmentCenter;
        sympol.textColor = ColorWithHexString(@"000000");
        [self.contentView addSubview:sympol];
        [sympol PSSetCenterXPercent:0.25];
        [sympol PSSetBottomAtItem:name Length:HeightRate(5)];
//        [sympol PSSetHeight:HeightRate(30)];
        self.MyAccountMoneyLable = sympol;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints = false;
        [button PSSetLeft:15];
        [button PSSetSize:ScreenWidth/3.0 Height:HeightRate(40)];
        [button PSSetTop:10];
         self.myAccountButton = button;

        UILabel *virtivalLine = [[UILabel alloc] init];
        virtivalLine.translatesAutoresizingMaskIntoConstraints = NO;
        virtivalLine.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:virtivalLine];
        [virtivalLine PSSetCenterXPercent:0.5];
        [virtivalLine PSSetTop:HeightRate(15)];
        [virtivalLine PSSetSize:WidthRate(1) Height:HeightRate(40)];
        
        UILabel *name1 = [[UILabel alloc] init];
        name1.translatesAutoresizingMaskIntoConstraints = NO;
        name1.font= [UIFont systemFontOfSize:AdaptFont(13)];
        name1.text = @"已发展会员";
        name1.textColor = ColorWithHexString(@"000000");
        name1.textAlignment = NSTextAlignmentCenter;
        name1.textColor = ColorWithHexString(@"333333");
        [self.contentView addSubview:name1];
        [name1 PSSetCenterXPercent:0.75];
        [name1 PSSetTop:HeightRate(12)];
        [name1 PSSetSize:ScreenWidth/2.0 Height:HeightRate(20)];
        
        UILabel *sympol1 = [[UILabel alloc] init];
        sympol1.translatesAutoresizingMaskIntoConstraints = NO;
        sympol1.font= [UIFont systemFontOfSize:AdaptFont(13)];
        sympol1.textAlignment = NSTextAlignmentCenter;
        sympol1.textColor = ColorWithHexString(@"000000");
        [self.contentView addSubview:sympol1];
        [sympol1 PSSetCenterXPercent:0.75];
        [sympol1 PSSetBottomAtItem:name1 Length:HeightRate(5)];
        self.MemberNumbersLable = sympol1;
        
        UILabel *bottomLine = [[UILabel alloc] init];
        bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
        bottomLine.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:bottomLine];
        [bottomLine PSSetLeft:WidthRate(0)];
        [bottomLine PSSetBottomAtItem:sympol Length:HeightRate(8)];
        [bottomLine PSSetSize:ScreenWidth Height:HeightRate(1)];
        [bottomLine PSSetBottom:0];
        
    }
    return self;
}

@end
