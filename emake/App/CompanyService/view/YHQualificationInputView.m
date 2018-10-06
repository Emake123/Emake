//
//  YHQualificationInputView.m
//  emake
//
//  Created by 谷伟 on 2017/10/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHQualificationInputView.h"

@implementation YHQualificationInputView

- (instancetype)initWith:(NSString *)leftText andRightBtnTitle:(NSString *)title{
    
    if (self = [super init]) {
        UILabel *labelText = [[UILabel alloc]init];
        labelText.text = leftText;
        labelText.font = SYSTEM_FONT(AdaptFont(14));
        [self addSubview:labelText];
        
        [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(13));
            make.height.mas_equalTo(HeightRate(45));
            make.width.mas_equalTo(WidthRate(65));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.rightSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightSelectBtn setTitle:title forState:UIControlStateNormal];
        [self.rightSelectBtn setTitleColor:TextColor_BBBBBB forState:UIControlStateNormal];
        self.rightSelectBtn.titleLabel.font = SYSTEM_FONT(AdaptFont(14));
        self.rightSelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:self.rightSelectBtn];
        
        [self.rightSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelText.mas_right).offset(WidthRate(7));
            make.height.mas_equalTo(HeightRate(35));
            make.right.mas_equalTo(WidthRate(10));
            make.centerY.mas_equalTo(self.mas_centerY).offset(HeightRate(-3));
        }];
        
        UILabel *labelLine = [[UILabel alloc]init];
        labelLine.backgroundColor = SepratorLineColor;
        [self addSubview:labelLine];
        
        [labelLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(labelText.mas_right).offset(WidthRate(7));
            make.right.mas_equalTo(WidthRate(-12));
            make.height.mas_equalTo(0.8);
            make.top.mas_equalTo(self.rightSelectBtn.mas_bottom).offset(-HeightRate(3));
        }];
        
        UIImageView *down = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"direction_down"]];
        [self addSubview:down];
        
        [down mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-WidthRate(12));
            make.width.mas_equalTo(WidthRate(12));
            make.height.mas_equalTo(WidthRate(12));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
