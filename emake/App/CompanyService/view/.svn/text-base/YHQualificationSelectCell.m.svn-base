//
//  YHQualificationSelectCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/23.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationSelectCell.h"

@implementation YHQualificationSelectCell
- (instancetype)init{
    if (self = [super init]) {
        self.leftTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        self.leftTitle.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.leftTitle];
        
        [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(HeightRate(30));
        }];
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.selectBtn setTitleColor:TextColor_BBBBBB forState:UIControlStateNormal];
        self.selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:self.selectBtn];
        
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(105));
            make.right.mas_equalTo(WidthRate(20));
            make.height.mas_equalTo(HeightRate(30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIImageView *downImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:downImage];
        
        [downImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-12));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(14));
            make.right.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(0.5);
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
