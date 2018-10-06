//
//  YHBankAddCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHBankAddCell.h"

@implementation YHBankAddCell
- (instancetype)init{
    if (self = [super init]) {
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tianjiayinhangka"]];
        [self.contentView addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.width.mas_equalTo(WidthRate(35));
            make.height.mas_equalTo(WidthRate(35));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"添加银行卡";
        label.textColor = TextColor_333333;
        label.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image.mas_right).offset(WidthRate(10));
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
