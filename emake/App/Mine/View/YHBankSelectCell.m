//
//  YHBankSelectCell.m
//  emake
//
//  Created by 谷伟 on 2018/1/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHBankSelectCell.h"
@interface YHBankSelectCell()
@property (nonatomic,retain)UIImageView *bankImage;
@property (nonatomic,retain)UILabel *bankName;
@property (nonatomic,retain)UILabel *bankCardNo;
@property (nonatomic,retain)UIImageView *selectImage;
@end
@implementation YHBankSelectCell
- (instancetype)init{
    if (self = [super init]) {
        self.bankImage = [[UIImageView alloc]init];
        [self.contentView addSubview:self.bankImage];
        
        [self.bankImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(28));
            make.width.mas_equalTo(WidthRate(34));
            make.height.mas_equalTo(WidthRate(34));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.bankName = [[UILabel alloc]init];
        self.bankName.text = @"农业银行";
        self.bankName.textColor = TextColor_333333;
        self.bankName.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:self.bankName];
        
        [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankImage.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(HeightRate(14));
            make.height.mas_equalTo(HeightRate(22));
        }];
        
        self.bankCardNo = [[UILabel alloc]init];
        self.bankCardNo.text = @"储值卡*************123456";
        self.bankCardNo.textColor = TextColor_949494;
        self.bankCardNo.font = SYSTEM_FONT(AdaptFont(16));
        [self.contentView addSubview:self.bankCardNo];
        
        [self.bankCardNo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankImage.mas_right).offset(WidthRate(8));
            make.top.mas_equalTo(self.bankName.mas_bottom);
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        
        self.selectImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xuanzeyinhangka02"]];
        [self.contentView addSubview:self.selectImage];
        
        [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-19));
            make.width.mas_equalTo(WidthRate(22));
            make.height.mas_equalTo(WidthRate(22));
            make.top.mas_equalTo(HeightRate(27));
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
- (void)setData:(YHBankModel *)model{
    self.bankName.text = model.CardBank;
    [self.bankImage sd_setImageWithURL:[NSURL URLWithString:model.CardLogo] placeholderImage:nil];
    NSString *cardString = [model.CardId stringByReplacingCharactersInRange:NSMakeRange(0, model.CardId.length-6) withString:@"************"];
    self.bankCardNo.text = [NSString stringWithFormat:@"%@%@",model.CardType,cardString];
    if ([model.CardState isEqualToString:@"0"]){
        [self.selectImage setImage:[UIImage imageNamed:@"xuanzeyinhanka01"]];
    }else{
        [self.selectImage setImage:[UIImage imageNamed:@"xuanzeyinhangka02"]];
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
