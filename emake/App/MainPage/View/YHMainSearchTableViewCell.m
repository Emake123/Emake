//
//  YHMainSearchTableViewCell.m
//  emake
//
//  Created by 张士超 on 2018/6/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMainSearchTableViewCell.h"

@implementation YHMainSearchTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageview  = [[UIImageView alloc] init];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        imageview.layer.borderWidth = 1;
        imageview.layer.borderColor = SepratorLineColor.CGColor;
        [self addSubview:imageview];
        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(10));
            make.top.mas_equalTo(HeightRate(10));
            make.width.mas_equalTo(WidthRate(77));
            make.height.mas_equalTo(WidthRate(77));

        }];
        self.productImage = imageview;
        
        UILabel *lableName = [[UILabel alloc] init];
        lableName.textColor = ColorWithHexString(@"000000");
        lableName.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:lableName];
        [lableName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageview.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(HeightRate(15));
//            make.width.mas_equalTo(WidthRate(77));
            make.height.mas_equalTo(WidthRate(30));
            
        }];
        self.productName = lableName;
        
        UILabel *lablePrice = [[UILabel alloc] init];
        lablePrice.textColor = ColorWithHexString(StandardBlueColor);
        lablePrice.font = [UIFont systemFontOfSize:AdaptFont(18)];
        [self addSubview:lablePrice];
        [lablePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageview.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(lableName.mas_bottom).offset(0);
            make.height.mas_equalTo(WidthRate(30));
            
        }];
        self.productPrice = lablePrice;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageview.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(imageview.mas_bottom).offset(HeightRate(10));
            make.height.mas_equalTo(WidthRate(1));
            make.width.mas_equalTo(ScreenWidth);
            make.bottom.mas_equalTo(0);
        }];
        
    
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
