//
//  YHWithDrawInputCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHWithDrawInputCell.h"
@interface YHWithDrawInputCell()
@end
@implementation YHWithDrawInputCell
- (instancetype)init{
    if (self = [super init]) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"提现金额";
        label.textColor = TextColor_333333;
        label.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.height.mas_equalTo(HeightRate(28));
            make.top.mas_equalTo(HeightRate(12));
        }];
        
        UILabel *labelSymbol = [[UILabel alloc]init];
        labelSymbol.text = @"¥";
        labelSymbol.textColor = TextColor_333333;
        labelSymbol.font = SYSTEM_FONT(AdaptFont(28));
        [self.contentView addSubview:labelSymbol];
        
        [labelSymbol mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.top.mas_equalTo(label.mas_bottom).offset(HeightRate(8));
            make.width.mas_equalTo(WidthRate(20));
        }];

        
        self.inputAmount = [[UITextField alloc]init];
        self.inputAmount.keyboardType = UIKeyboardTypeDecimalPad;
        self.inputAmount.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:self.inputAmount];
        
        [self.inputAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelSymbol.mas_right).offset(WidthRate(5));
            make.height.mas_equalTo(HeightRate(50));
            make.centerY.mas_equalTo(labelSymbol.mas_centerY);
            make.right.mas_equalTo(WidthRate(-18));
        }];
        
        UIView *lineOne = [[UIView alloc]init];
        lineOne.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:lineOne];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.right.mas_equalTo(WidthRate(-18));
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(HeightRate(83));
        }];
        
        self.depositAmout = [[UILabel alloc]init];
        self.depositAmout.text = @"可提现金额23000元";
        self.depositAmout.textColor = TextColor_999999;
        self.depositAmout.font = SYSTEM_FONT(AdaptFont(15));
        [self.contentView addSubview:self.depositAmout];
        
        [self.depositAmout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.top.mas_equalTo(lineOne.mas_bottom).offset(HeightRate(9));
            make.height.mas_equalTo(WidthRate(21));
        }];
        
        self.depositAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.depositAll setTitle:@"全部提现" forState:UIControlStateNormal];
        [self.depositAll setTitleColor:ColorWithHexString(APP_THEME_MAIN_COLOR) forState:UIControlStateNormal];
        self.depositAll.titleLabel.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:self.depositAll];
        
        [self.depositAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-18));
            make.height.mas_equalTo(WidthRate(23));
            make.centerY.mas_equalTo(self.depositAmout.mas_centerY);
            make.width.mas_equalTo(WidthRate(75));
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
