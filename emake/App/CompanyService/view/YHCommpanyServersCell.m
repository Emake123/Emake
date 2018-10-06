//
//  YHCommpanyServersCell.m
//  emake
//
//  Created by 谷伟 on 2017/10/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHCommpanyServersCell.h"

@implementation YHCommpanyServersCell
- (instancetype)init{
    
    if (self = [super init]) {
        
        self.contentView.backgroundColor = ColorWithHexString(@"ffffff");
        
        UIImageView * leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pinpaishouquan-tuzi copy 2"]];
        leftImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:leftImage];
        
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(WidthRate(55));
            make.height.mas_equalTo(WidthRate(55));
            make.left.mas_equalTo(WidthRate(15));
            
        }];
        self.leftImage = leftImage;
        
        UILabel * labelTile = [[UILabel alloc]init];
        labelTile.font = [UIFont boldSystemFontOfSize:AdaptFont(14)];
        labelTile.textColor = ColorWithHexString(@"333333");
        [self.contentView addSubview:labelTile];
        
        [labelTile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(22));
            make.height.mas_equalTo(HeightRate(20));
            make.left.mas_equalTo(leftImage.mas_right).offset(10);
        }];
        self.labelTile = labelTile;
        
        UILabel * labelBottomTitle = [[UILabel alloc]init];
        labelBottomTitle.font = SYSTEM_FONT(AdaptFont(12));
        labelBottomTitle.textColor = TextColor_888888;

        [self.contentView addSubview:labelBottomTitle];
        
        [labelBottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(labelTile.mas_bottom).offset(2);
            make.left.mas_equalTo(leftImage.mas_right).offset(10);

        }];
        self.labeldetailTile = labelBottomTitle;
        
        UIImageView * rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"right01"]];
        rightImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-20);
            make.width.mas_equalTo(WidthRate(20));
            make.height.mas_equalTo(WidthRate(20));
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
    }
    return  self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}

- (void)setData:(YHCommpanyServersModel *)model{
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:model.BrandServiceIcon] placeholderImage:[UIImage imageNamed:@"pinpaishouquan-tuzi copy 2"]];
    self.labelTile.text = model.BrandServiceTitle;
    self.labeldetailTile.text = model.BrandServiceDesc;
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
