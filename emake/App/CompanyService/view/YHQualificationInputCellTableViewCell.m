//
//  YHQualificationInputCellTableViewCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/23.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationInputCellTableViewCell.h"

@implementation YHQualificationInputCellTableViewCell
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
        
        self.input = [[UITextField alloc]init];
        self.input.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.input];
        
        [self.input mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(105));
            make.right.mas_equalTo(WidthRate(20));
            make.height.mas_equalTo(HeightRate(30));
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
