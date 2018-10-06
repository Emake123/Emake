//
//  MainPageLastWeekCell.m
//  emake
//
//  Created by 谷伟 on 2017/12/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "MainPageLastWeekCell.h"

@implementation MainPageLastWeekCell
- (instancetype)init{
    if (self = [super init]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.compannyName = [[UILabel alloc] init];
        self.compannyName.font = SYSTEM_FONT(AdaptFont(14));
        self.compannyName.textAlignment = NSTextAlignmentLeft;
        self.compannyName.text =@"江苏****公司 ";
        [self.contentView addSubview:self.compannyName];
        
        [self.compannyName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(25));
            make.top.mas_equalTo(HeightRate(5));
            make.height.mas_equalTo(WidthRate(26));
        }];
        
        self.Amount = [[UILabel alloc] init];
        self.Amount.font = SYSTEM_FONT(AdaptFont(14));
        self.Amount.textAlignment = NSTextAlignmentLeft;
        self.Amount.text =@"45000元   ";
        self.Amount.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        [self.contentView addSubview:self.Amount];
        
        [self.Amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-10));
            make.top.mas_equalTo(HeightRate(5));
            make.height.mas_equalTo(WidthRate(26));
        }];
        
        self.LabelText = [[UILabel alloc] init];
        self.LabelText.font = SYSTEM_FONT(AdaptFont(12));
        self.LabelText.textAlignment = NSTextAlignmentLeft;
        self.LabelText.text =@"SCBH15-200kVA    X2";
        self.LabelText.numberOfLines = 0;
        [self.contentView addSubview:self.LabelText];
        
        [self.LabelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(25));
            make.right.mas_equalTo(WidthRate(-30));
            make.top.mas_equalTo(self.compannyName.mas_bottom).offset(HeightRate(-10));
            make.bottom.mas_equalTo(0);
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(0.8));
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
