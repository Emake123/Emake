//
//  YHQualificationCertificationCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationCertificationCell.h"

@implementation YHQualificationCertificationCell
- (instancetype)init{
    
    if (self = [super init]) {
        
        
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
        [self.contentView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(WidthRate(70));
            make.height.mas_equalTo(WidthRate(70));
        }];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
        self.labelTile = [[UILabel alloc]init];
        self.labelTile.font = SYSTEM_FONT(AdaptFont(16));
        self.labelTile.text =@"体系认证";
        [self.contentView addSubview:self.labelTile];
        
        [self.labelTile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(12));
            make.top.mas_equalTo(HeightRate(12));
            make.height.mas_equalTo(HeightRate(46));
        }];
        
        self.labelContent = [[UILabel alloc]init];
        self.labelContent.font = SYSTEM_FONT(AdaptFont(12));
        self.labelContent.text =@"如果您想进行体系认证，请提交相关资料";
        [self.contentView addSubview:self.labelContent];
        
        [self.labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImage.mas_right).offset(WidthRate(12));
            make.top.mas_equalTo(self.labelTile.mas_bottom).offset(HeightRate(1));
            make.height.mas_equalTo(HeightRate(30));
        }];
        
        
        UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-WidthRate(18));
            make.width.mas_equalTo(WidthRate(15));
            make.height.mas_equalTo(WidthRate(15));
        }];
    }
    return  self;
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
