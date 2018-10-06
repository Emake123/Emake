//
//  YHLogisticsDetailButton.m
//  emake
//
//  Created by 袁方 on 2017/7/27.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHLogisticsDetailButton.h"

static CGFloat const TitleLabelWidth = 50.0f;
static CGFloat const TitleLabelHeight = 12.0f;

static CGFloat const ImageViewLeftToParent = 50.0f;
static CGFloat const ImageViewWidth = 12.0f;
static CGFloat const ImageViewHeight = 12.0f;

@implementation YHLogisticsDetailButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = SYSTEM_FONT(BASE_FONT_SIZE);
        [self setImage:[UIImage imageNamed:@"order_manage_arrow_down"] forState:UIControlStateNormal];
        [self setTitle:NSLanguageLocalizedString(@"logistic detail") forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}
+ (instancetype)initBorderStyleWithTitle:(NSString *)title {
    YHLogisticsDetailButton *backgroundButton = [super initBorderStyleWithTitle:title color:StandardBlueColor cornerRadius:HeightRate(15)];
    if (backgroundButton) {
        backgroundButton.titleLabel.font = SYSTEM_FONT(BASE_FONT_SIZE);
        backgroundButton.translatesAutoresizingMaskIntoConstraints = NO;//order_manage_arrow_down
        [backgroundButton setImage:[UIImage imageNamed:@"extend"] forState:UIControlStateNormal];
        [backgroundButton setImage:[UIImage imageNamed:@"narrow"] forState:UIControlStateSelected];
        
        [backgroundButton setTitle:NSLanguageLocalizedString(@"logistic detail") forState:UIControlStateNormal];
        backgroundButton.titleLabel.font = [UIFont systemFontOfSize:AdaptFont(12)] ;
        [backgroundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return backgroundButton;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.left = WidthRate(15);
    self.titleLabel.width =WidthRate(TitleLabelWidth) ;
    self.titleLabel.height =HeightRate(TitleLabelHeight) ;
    self.titleLabel.centerY = self.height * 0.5;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.left =WidthRate(ImageViewLeftToParent+WidthRate(18))  ;
    self.imageView.width = WidthRate(ImageViewWidth);
    self.imageView.height = HeightRate(ImageViewHeight) ;
    self.imageView.centerY = self.height * 0.5;
}

@end
