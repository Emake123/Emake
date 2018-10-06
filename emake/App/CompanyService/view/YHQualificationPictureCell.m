//
//  YHQualificationPictureCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/23.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationPictureCell.h"

@implementation YHQualificationPictureCell
- (instancetype)init{
    if (self = [super init]) {
        self.leftTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        self.leftTitle.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.leftTitle];
        
        [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(14));
            make.top.mas_equalTo(HeightRate(5));
            make.height.mas_equalTo(HeightRate(45));
        }];
        
        self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.addImageBtn];
        
        [self.addImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(90));
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        
        self.addImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wode_shangchuan"]];
        self.addImage.userInteractionEnabled = false;
        [self.contentView addSubview:self.addImage];
        
        [self.addImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(93));
            make.width.mas_equalTo(WidthRate(52));
            make.height.mas_equalTo(HeightRate(52));
            make.top.mas_equalTo(HeightRate(5));
        }];
        
        self.addLabel = [[UILabel alloc]init];
        self.addLabel.text =@"添加图片";
        self.addLabel.font = SYSTEM_FONT(AdaptFont(12));
        [self.contentView addSubview:self.addLabel];
        
        [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.addImage.mas_centerX);
            make.height.mas_equalTo(HeightRate(24));
            make.bottom.mas_equalTo(HeightRate(-5));
        }];
        
        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(0));
            make.right.mas_equalTo(WidthRate(0));
            make.height.mas_equalTo(HeightRate(0.6));
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
