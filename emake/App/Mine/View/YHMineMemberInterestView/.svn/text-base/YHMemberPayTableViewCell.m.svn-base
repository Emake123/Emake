//
//  YHMemberPayTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/11.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMemberPayTableViewCell.h"

@implementation YHMemberPayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *memberInfoView = [[UIImageView alloc] init];
        memberInfoView.contentMode = UIViewContentModeScaleAspectFit;
        memberInfoView.image = [UIImage imageNamed:@"placehold"];
        [self.contentView addSubview:memberInfoView];
        [memberInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(WidthRate(38));
            make.height.mas_equalTo(HeightRate(38));
        }];
        self.payImageView = memberInfoView;
        
        UILabel *catagoryLable = [[UILabel alloc] init];
        catagoryLable.backgroundColor = ColorWithHexString(@"ffffff");
        catagoryLable.text = @"微信支付";
        
        [self addSubview:catagoryLable];
        [catagoryLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(memberInfoView.mas_centerY);
            make.left.mas_equalTo(memberInfoView.mas_right).offset(WidthRate(10));
            make.height.mas_equalTo(HeightRate(30));
        }];
        self.payName = catagoryLable;
        
        UIButton *paySelectButton = [[UIButton alloc] init];
        [paySelectButton setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [paySelectButton setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
        [self addSubview:paySelectButton];
        [paySelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(catagoryLable.mas_centerY);
            make.right.mas_equalTo(-WidthRate(10));
            make.width.mas_equalTo(WidthRate(36));
            make.height.mas_equalTo(HeightRate(36));
        }];
        self.paySelectButton = paySelectButton;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(WidthRate(10));
            make.right.mas_equalTo(WidthRate(-10));

            make.height.mas_equalTo(HeightRate(1));
        }];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
