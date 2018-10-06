//
//  ChatOfficialListCell.m
//  emake
//
//  Created by 谷伟 on 2017/8/29.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "ChatOfficialListCell.h"
#import "WZLBadgeImport.h"
@implementation ChatOfficialListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.headImage.image = [UIImage imageNamed:@"kefu_logo"];
        [self.contentView addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(11));
            make.width.mas_equalTo(WidthRate(44));
            make.height.mas_equalTo(WidthRate(44));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectZero];
        labelName.text = @"易智造官方客服";
        [self.contentView addSubview:labelName];
        
        [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            

            make.left.mas_equalTo(WidthRate(69));
            make.height.mas_equalTo(HeightRate(45));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
        }];

        UIImageView *imageMark = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageMark.image = [UIImage imageNamed:@"kefu_guanfang"];
        [self.contentView addSubview:imageMark];
        
        [imageMark mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(labelName.mas_right).offset(5);
            make.height.mas_equalTo(WidthRate(18));
            make.width.mas_equalTo(WidthRate(18));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
        }];
        
        UILabel *labelTime = [[UILabel alloc]initWithFrame:CGRectZero];
        labelTime.text = @"";
        labelTime.font = [UIFont systemFontOfSize:12];
        labelTime.textColor = TextColor_666666;
        labelTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:labelTime];
        
        [labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(WidthRate(17));
            make.width.mas_equalTo(WidthRate(76));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            
        }];
    
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
