//
//  YHSettingItemCell.m
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSettingItemCell.h"

@implementation YHSettingItemCell
- (instancetype)init{
    if (self = [super init]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *line = [[UILabel alloc]init];
        line.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(0.8);
        }];
        
        
        self.title = [[UILabel alloc]init];
        self.title.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(20));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        UIImageView *leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:leftImage];
        leftImage.hidden = false;
        [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.title.mas_right).offset(WidthRate(5));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        self.contentImage = leftImage;
        
        
        UIImageView *rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_right"]];
        [self.contentView addSubview:rightImage];
        
        [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(WidthRate(-7));
            make.width.mas_equalTo(WidthRate(14));
            make.height.mas_equalTo(WidthRate(14));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.textColor = TextColor_737273;
        self.contentLabel.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rightImage.mas_left).offset(WidthRate(-8));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(HeightRate(23));
        }];
        
        self.lineLabel = [[UILabel alloc]init];
        self.lineLabel.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:self.lineLabel];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.8);
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
