//
//  YHMemberInterestTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/11.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMemberInterestTableViewCell.h"

@implementation YHMemberInterestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *memberInfoView = [[UIView alloc] init];
        memberInfoView.layer.borderColor  = ColorWithHexString(@"E4E4E4").CGColor;
        memberInfoView.layer.borderWidth  = 1;

        memberInfoView.layer.cornerRadius = 6;
        memberInfoView.clipsToBounds = YES;
        [self.contentView addSubview:memberInfoView];
        [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(WidthRate(352));
            make.height.mas_equalTo(HeightRate(54));
        }];
        self.memberView = memberInfoView;
        
        UILabel *catagoryLable = [[UILabel alloc] init];
//        catagoryLable.backgroundColor = ColorWithHexString(@"ffffff");
        catagoryLable.text = @"输配电会员";

        [memberInfoView addSubview:catagoryLable];
        [catagoryLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(memberInfoView.mas_centerY);
            make.left.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(30));
        }];
        self.catagoryNameLable = catagoryLable;
        
        UILabel *memberLable = [[UILabel alloc] init];
        memberLable.text = @"（待开通）";
        memberLable.textColor = ColorWithHexString(@"999999");
        memberLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [memberInfoView addSubview:memberLable];
        [memberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(catagoryLable.mas_centerY);
            make.left.mas_equalTo(catagoryLable.mas_right).offset(10);
            make.width.mas_equalTo(WidthRate(120));
            make.height.mas_equalTo(HeightRate(30));
        }];
        self.memberStateLable = memberLable;
        
        UILabel *memberDateLable = [[UILabel alloc] init];
        memberDateLable.text = @"¥2000／年";
//        memberDateLable.textAlignment = NSTextAlignmentCenter;
        memberDateLable.textColor = ColorWithHexString(@"CC894F");
        memberDateLable.font = [UIFont systemFontOfSize:AdaptFont(13)];
        [memberInfoView addSubview:memberDateLable];
        [memberDateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(catagoryLable.mas_centerY);
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(30));
        }];
       self.memberMoneyLable =memberDateLable;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected==YES) {
//        self.memberView.backgroundColor = ColorWithHexString(@"ffffcc");
//
//    }else
//    {
//        self.memberView.backgroundColor = ColorWithHexString(StandardBlueColor);
//
//    }

    // Configure the view for the selected state
}

@end
