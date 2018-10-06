//
//  YHSendMessageStoreTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/8/10.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSendMessageStoreTableViewCell.h"

@implementation YHSendMessageStoreTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.storeImageView = [[UIImageView alloc] init];
        self.storeImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.storeImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.storeImageView];
        self.storeImageView.layer.cornerRadius = 23;
        [self.storeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(WidthRate(15));
            make.width.mas_equalTo(46);
            make.height.mas_equalTo(46);
        }];
        
        self.storeNameLable = [[UILabel alloc]init];
        self.storeNameLable.text = @"团长大大";
        self.storeNameLable.textColor = TextColor_333333;
        self.storeNameLable.font = SYSTEM_FONT(AdaptFont(14));
        [self.contentView addSubview:self.storeNameLable];
        
        [self.storeNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(12));
            make.left.mas_equalTo(self.storeImageView.mas_right).offset(WidthRate(12));
            make.height.mas_equalTo(HeightRate(20));
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
