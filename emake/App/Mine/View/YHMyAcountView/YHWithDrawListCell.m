//
//  YHWithDrawListCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHWithDrawListCell.h"
@interface YHWithDrawListCell()
@property (nonatomic,retain)UILabel *labelBank;
@property (nonatomic,retain)UILabel *labelTypeAndTime;
@property (nonatomic,retain)UILabel *labelAmount;
@property (nonatomic,retain)UILabel *labelState;
@end
@implementation YHWithDrawListCell
- (instancetype)init{
    if (self = [super init]) {
        self.labelBank = [[UILabel alloc]init];
        self.labelBank.textColor = TextColor_333333;
        self.labelBank.font = SYSTEM_FONT(AdaptFont(15));
        self.labelBank.text = @"农业银行（储蓄卡456）";
        [self.contentView addSubview:self.labelBank];
        
        [self.labelBank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.height.mas_equalTo(HeightRate(21));
            make.top.mas_equalTo(HeightRate(14));
        }];
        
        
        self.labelAmount = [[UILabel alloc]init];
        self.labelAmount.textColor = TextColor_333333;
        self.labelAmount.font = SYSTEM_FONT(AdaptFont(15));
        self.labelAmount.text = @"-10000元";
        [self.contentView addSubview:self.labelAmount];
        
        [self.labelAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(18));
            make.height.mas_equalTo(HeightRate(24));
            make.top.mas_equalTo(HeightRate(14));
        }];
        
        self.labelTypeAndTime = [[UILabel alloc]init];
        self.labelTypeAndTime.textColor = TextColor_797979;
        self.labelTypeAndTime.font = SYSTEM_FONT(AdaptFont(14));
        self.labelTypeAndTime.text = @"2017-12-18  14:30:22";
        [self.contentView addSubview:self.labelTypeAndTime];
        
        [self.labelTypeAndTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.height.mas_equalTo(HeightRate(21));
            make.top.mas_equalTo(self.labelBank.mas_bottom);
        }];
        
        self.labelState = [[UILabel alloc]init];
        self.labelState.textColor = TextColor_333333;
        self.labelState.font = SYSTEM_FONT(AdaptFont(12));
        self.labelState.text = @"提现成功";
        self.labelState.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.labelState.layer.cornerRadius = WidthRate(2);
        self.labelState.layer.borderWidth = WidthRate(1);
        self.labelState.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
        self.labelState.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.labelState];
        
        [self.labelState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-18));
            make.height.mas_equalTo(HeightRate(18));
            make.top.mas_equalTo(self.labelAmount.mas_bottom);
            make.width.mas_equalTo(WidthRate(68));
        }];
        
        UIView *lineOne = [[UIView alloc]init];
        lineOne.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:lineOne];
        
        [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.right.mas_equalTo(WidthRate(-18));
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}
- (void)setData:(YHDepositModel *)model{
    NSString *cardString = [model.CardId substringFromIndex:model.CardId.length-3];
    self.labelBank.text = [NSString stringWithFormat:@"%@（%@%@）",model.CardBank,model.CardType,cardString];
    self.labelAmount.text = [NSString stringWithFormat:@"%.2f元",[model.Money doubleValue]];
    self.labelTypeAndTime.text = [NSString stringWithFormat:@"%@",model.CreateTime];
    if ([model.CashState isEqualToString:@"1"]){
        self.labelState.text = @"申请中";
        self.labelState.textColor = TextColor_FBA631;
        self.labelState.layer.borderColor = TextColor_FBA631.CGColor;
    }else if ([model.CashState isEqualToString:@"2"]){
        self.labelState.text = @"提现成功";
        self.labelState.textColor = ColorWithHexString(APP_THEME_MAIN_COLOR);
        self.labelState.layer.borderColor = ColorWithHexString(APP_THEME_MAIN_COLOR).CGColor;
    }else if ([model.CashState isEqualToString:@"3"]){
        self.labelState.text = @"审核失败";
        self.labelState.textColor = TextColor_F26A55;
        self.labelState.layer.borderColor = TextColor_F26A55.CGColor;
    }
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
