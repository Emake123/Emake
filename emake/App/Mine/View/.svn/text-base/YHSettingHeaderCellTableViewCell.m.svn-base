//
//  YHSettingHeaderCellTableViewCell.m
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSettingHeaderCellTableViewCell.h"

@implementation YHSettingHeaderCellTableViewCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.headImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.headImageView.layer.cornerRadius = WidthRate(30);
        self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.headImageView];
        
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.width.mas_equalTo(WidthRate(60));
            make.height.mas_equalTo(WidthRate(60));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.nickNameLabel.text =@"点击设置账户昵称";
        self.nickNameLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.nickNameLabel];
        
        [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImageView.mas_right).offset(WidthRate(18));
            make.width.mas_equalTo(WidthRate(130));
            make.height.mas_equalTo(HeightRate(23));
            make.bottom.mas_equalTo(self.headImageView.mas_centerY);
        }];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.nameLabel.textColor = TextColor_888888;
        self.nameLabel.font = SYSTEM_FONT(AdaptFont(12));
        [self.contentView addSubview:self.nameLabel];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImageView.mas_right).offset(WidthRate(18));
            make.height.mas_equalTo(WidthRate(23));
            make.top.mas_equalTo(self.headImageView.mas_centerY);
        }];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-7));
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
