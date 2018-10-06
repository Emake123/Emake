//
//  MesssageEventTipsCollectionViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/7/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "MesssageEventTipsCollectionViewCell.h"
@interface MesssageEventTipsCollectionViewCell()
@property (nonatomic,strong)UILabel *tipsLabel;
@end
@implementation MesssageEventTipsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.contentView.backgroundColor =
        self.tipsLabel = [[UILabel alloc] init];
        self.tipsLabel.font = [UIFont systemFontOfSize:12];
//        self.tipsLabel.textColor = TextColor_666666;
        self.tipsLabel.text = @"提示";
        self.tipsLabel.numberOfLines = 0;
        self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        self.tipsLabel.backgroundColor = TextColor_E6E6E6;
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(WidthRate(10));
//            make.right.mas_equalTo(WidthRate(-10));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(HeightRate(5));
            make.bottom.mas_equalTo(HeightRate(0));
//            make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(HeightRate(5));
//            make.height.mas_equalTo(HeightRate(25));
        }];
//        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.contentView.mas_centerX);
//            make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(HeightRate(5));
//            make.height.mas_equalTo(HeightRate(25));
//        }];
        
//        []
    }
    return self;
}
- (void)presentTips:(NSString *)tips{
    self.tipsLabel.text = [NSString stringWithFormat:@" %@",tips];
    CGSize size = [tips sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(WidthRate(350),10000.0f)lineBreakMode:UILineBreakModeWordWrap];

//    CGFloat width = tips.length * 12 + 15;
    [self.tipsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(HeightRate(size.width+15));
    }];
}
@end
