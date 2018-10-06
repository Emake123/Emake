//
//  YHWithDrawMoreCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHWithDrawMoreCell.h"

@implementation YHWithDrawMoreCell
- (instancetype)init{
    if (self = [super init]) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"提现明细";
        label.font = SYSTEM_FONT(AdaptFont(16));
        label.textColor = TextColor_333333;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.height.mas_equalTo(HeightRate(22));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIImageView *rightImage =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-20));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UILabel *labelAnother = [[UILabel alloc]init];
        labelAnother.text = @"查看更多";
        labelAnother.font = SYSTEM_FONT(AdaptFont(16));
        labelAnother.textColor = TextColor_333333;
        [self.contentView addSubview:labelAnother];
        
        [labelAnother mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImage.mas_left);
            make.height.mas_equalTo(HeightRate(22));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIView *lineOne = [[UIView alloc]init];
        lineOne.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:lineOne];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
