//
//  YHMySettingVipTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/27.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMySettingVipTableViewCell.h"

@implementation YHMySettingVipTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *lablestate = [[UILabel alloc]init];
        lablestate.text = @"会员权益";
        
        lablestate.font = [UIFont systemFontOfSize:AdaptFont(15)];
        lablestate.textColor = ColorWithHexString(@"333333");
        lablestate.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:lablestate];
        [lablestate PSSetCenterHorizontalAtItem:self];
        [lablestate PSSetLeft:WidthRate(15)];
        [lablestate PSSetHeight:HeightRate(30)];
        
//        self.logisticsIdLabel =lablestate;
        
        UIImageView *imageview = [[UIImageView alloc] init];
        imageview.translatesAutoresizingMaskIntoConstraints = false;
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageview];
        [lablestate PSSetRight:WidthRate(5)];
        [lablestate PSSetSize:WidthRate(14) Height:HeightRate(14)];
        
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
