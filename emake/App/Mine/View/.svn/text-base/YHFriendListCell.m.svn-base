//
//  YHFriendListCell.m
//  emake
//
//  Created by 谷伟 on 2017/9/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHFriendListCell.h"
#import "UserFriendModel.h"
@implementation YHFriendListCell
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.headImage = [[UIImageView alloc]init];
        self.headImage.image = [UIImage imageNamed:@"login_logo"];
        self.headImage.clipsToBounds = YES;
        self.headImage.contentMode = UIViewContentModeScaleAspectFill;
        self.headImage.layer.cornerRadius = WidthRate(35);
        [self.contentView addSubview:self.headImage];
        
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.width.mas_equalTo(WidthRate(70));
            make.height.mas_equalTo(WidthRate(70));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.labelName = [[UILabel alloc]init];
        self.labelName.text =@"张帅";
        self.labelName.font = [UIFont systemFontOfSize:12];
        self.labelName.textColor = TextColor_666666;
        [self.contentView addSubview:self.labelName];
        
        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(HeightRate(17));
            make.top.mas_equalTo(HeightRate(11));
        }];
        
        self.labelPhone = [[UILabel alloc]init];
        self.labelPhone.text =@"13800000000";
        self.labelPhone.font = [UIFont systemFontOfSize:12];
        self.labelPhone.textColor = TextColor_666666;
        [self.contentView addSubview:self.labelPhone];
        
        [self.labelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(HeightRate(17));
            make.top.mas_equalTo(self.labelName.mas_bottom).offset(HeightRate(4));
        }];
        
        self.labelCompany = [[UILabel alloc]init];
        self.labelCompany.text =@"易虎网科技南京股份有限公司";
        self.labelCompany.font = [UIFont systemFontOfSize:12];
        self.labelCompany.textColor = TextColor_666666;
        [self.contentView addSubview:self.labelCompany];
        
        [self.labelCompany mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(HeightRate(17));
            make.top.mas_equalTo(self.labelPhone.mas_bottom).offset(HeightRate(4));
        }];
        
        self.labelAdress = [[UILabel alloc]init];
        self.labelAdress.text =@"南京市江宁区水阁路8号";
        self.labelAdress.font = [UIFont systemFontOfSize:12];
        self.labelAdress.textColor = TextColor_666666;
        [self.contentView addSubview:self.labelAdress];
        
        [self.labelAdress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(95));
            make.height.mas_equalTo(HeightRate(17));
            make.top.mas_equalTo(self.labelCompany.mas_bottom).offset(HeightRate(4));
        }];
        
        
        self.labelScore = [[UILabel alloc]init];
        self.labelScore.text =@"已贡献12积分";
        self.labelScore.font = [UIFont systemFontOfSize:12];
        self.labelScore.textColor = TextColor_B3B3B3;
        [self.contentView addSubview:self.labelScore];
        
        [self.labelScore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-15));
            make.height.mas_equalTo(HeightRate(16));
            make.top.mas_equalTo(HeightRate(15));
        }];
        
        
        self.labelAmount = [[UILabel alloc]init];
        self.labelAmount.text =@"总金额23456";
        self.labelAmount.font = [UIFont systemFontOfSize:12];
        self.labelAmount.textColor = [UIColor whiteColor];
        self.labelAmount.backgroundColor = [UIColor colorWithHexString:@"22CBD6"];
        self.labelAmount.layer.cornerRadius = 5;
        self.labelAmount.clipsToBounds = YES;
        [self.contentView addSubview:self.labelAmount];
        [self.labelAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-15));
            make.height.mas_equalTo(HeightRate(16));
            make.top.mas_equalTo(self.labelScore.mas_bottom).offset(HeightRate(3));
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *imageRight = [[UIImageView alloc]init];
        imageRight.image = [UIImage imageNamed:@"direction_right"];
        [self.contentView addSubview:imageRight];
         [imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo (WidthRate(-11));
             make.width.mas_equalTo (WidthRate(14));
             make.height.mas_equalTo (WidthRate(14));
             make.top.mas_equalTo(HeightRate(56));
         }];
        
    }
    return self;
}
- (void)setData:(UserFriendModel *)model{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.HeadImageUrl] placeholderImage:[UIImage imageNamed:@"login_logo"]];
    self.labelName.text =  model.RealName;
    self.labelPhone.text = model.MobileNumber;
    self.labelScore.text = [NSString stringWithFormat:@"已贡献%@积分",model.Score];
    self.labelAdress.text = model.Address;
    self.labelAmount.text = [NSString stringWithFormat:@"总金额%@",model.Price];;
    self.labelCompany.text = model.Company;
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
