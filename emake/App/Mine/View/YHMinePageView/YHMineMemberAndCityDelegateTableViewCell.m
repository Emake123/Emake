//
//  YHMineMemberAndCityDelegateTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/11.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMineMemberAndCityDelegateTableViewCell.h"

@implementation YHMineMemberAndCityDelegateTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIImageView *bgImageview = [[UIImageView alloc] init];
//        bgImageview.contentMode = UIViewContentModeScaleAspectFit;
//        bgImageview.image = [UIImage imageNamed:@"wodetuanduitu"];
//        bgImageview.translatesAutoresizingMaskIntoConstraints = NO;
//        [self addSubview:bgImageview];
//        [bgImageview PSSetSize:WidthRate(352) Height:HeightRate(82)];
//        [bgImageview PSSetLeft:WidthRate(11)];
//        [bgImageview PSSetTop:HeightRate(11)];
        //        [bgImageview PSSetConstraint:WidthRate(11) Right:WidthRate(11) Top:HeightRate(11) Bottom:HeightRate(11)];
        
        
        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"   我的会员权益" forState:UIControlStateNormal];
        button.backgroundColor = ColorWithHexString(@"F1E1E2");
        [button setImage:[UIImage imageNamed:@"huiyuanbig"] forState:UIControlStateNormal];

        [button setTitleColor:ColorWithHexString(@"F8695D") forState:UIControlStateNormal];
        button.layer.cornerRadius = 6;
        button.clipsToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:button];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button PSSetLeft:WidthRate(9)];
        [button PSSetTop:HeightRate(11)];
        [button PSSetSize:WidthRate(174) Height:HeightRate(45)];
        self.MyMemberInterestButton = button;
        
        UIButton *button1= [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"   城市代理商权益" forState:UIControlStateNormal];
        button1.backgroundColor = ColorWithHexString(@"E5EFFC");
        [button1 setImage:[UIImage imageNamed:@"dailishangbig"] forState:UIControlStateNormal];
        [button1 setTitleColor:ColorWithHexString(@"6699FF") forState:UIControlStateNormal];
        button1.layer.cornerRadius = 6;
        button1.clipsToBounds = YES;
        button1.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [self addSubview:button1];
        button1.translatesAutoresizingMaskIntoConstraints = NO;
        [button1 PSSetRight:WidthRate(9)];
        [button1 PSSetTop:HeightRate(11)];
        [button1 PSSetSize:WidthRate(174) Height:HeightRate(45)];
        self.CityDelegateButton = button1;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = ColorWithHexString(@"F2F2F2");
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:line];
        [line PSSetSize:ScreenWidth Height:HeightRate(1)];
        [line PSSetBottomAtItem:button Length:HeightRate(5)];
        [line PSSetLeft:0];
        [line PSSetBottom:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
