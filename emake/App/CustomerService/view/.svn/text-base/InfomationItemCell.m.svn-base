//
//  InfomationItemCell.m
//  emake
//
//  Created by 谷伟 on 2017/8/29.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "InfomationItemCell.h"

@implementation InfomationItemCell
-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor =APP_THEME_MAIN_GRAY;
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeLabel.backgroundColor = TextColor_C4C4C4;
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.layer.cornerRadius = 3;
        timeLabel.layer.masksToBounds = YES;
        timeLabel.text = @"2017/02/24";
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:timeLabel];
        
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(15));
            make.width.mas_equalTo(WidthRate(81));
            make.height.mas_equalTo(HeightRate(23));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
        view.layer.cornerRadius = 3;
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(WidthRate(15));
            make.right.mas_equalTo(WidthRate(-15));
            make.height.mas_equalTo(HeightRate(109));
        }];

        UILabel *themeLabel =[[UILabel alloc]initWithFrame:CGRectZero];
        themeLabel.text = @"您的优惠券将在两天内过期，请及时使用";
        themeLabel.font = [UIFont systemFontOfSize:14];
        themeLabel.textColor =  TextColor_101010;
        [view addSubview:themeLabel];
        
        [themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(1);
            make.left.mas_equalTo(WidthRate(17));
            make.height.mas_equalTo(HeightRate(32));
            make.width.mas_equalTo(WidthRate(273));
        }];
        
        
        UIImageView *themeImagview =[[UIImageView alloc]initWithFrame:CGRectZero];
        themeImagview.image = [UIImage imageNamed:@"S11"];
        [view addSubview:themeImagview];
        [themeImagview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(6);
            make.height.mas_equalTo(HeightRate(56));
            make.width.mas_equalTo(WidthRate(83));
            make.bottom.mas_equalTo(HeightRate(-15));
        }];
        
        UILabel *contentLabel =[[UILabel alloc]initWithFrame:CGRectZero];
        contentLabel.text = @"优惠券可抵现金使用，优惠多多哦。优惠券可抵现金使用，优惠多多哦。";
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.textColor = TextColor_A3A3A3;
        contentLabel.numberOfLines = 0;
        [view addSubview:contentLabel];
        
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(themeImagview.mas_right).offset(0);
            make.height.mas_equalTo(HeightRate(49));
            make.width.mas_equalTo(WidthRate(261));
            make.centerY.mas_equalTo(themeImagview.mas_centerY);
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
