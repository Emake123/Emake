//
//  YHButton.m
//  emake
//
//  Created by 袁方 on 2017/7/19.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHButton.h"

static CGFloat const ButtonFontSize = 12.0f;
static CGFloat const ButtonBorderWidth = 1.0f;
@implementation YHButton

+ (instancetype)initBorderStyleWithTitle:(NSString *)title {
    return [self initBorderStyleWithTitle:title color:nil];
}
+ (instancetype)initBorderStyleWithTitle:(NSString *)title color:(NSString *)color  {
    YHButton *borderButton  = [super buttonWithType:UIButtonTypeCustom];
    if (borderButton) {
        [borderButton setTitle:title forState:UIControlStateNormal];
        if (color) {
            [borderButton setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
            [borderButton.layer setBorderColor:[UIColor colorWithHexString:color].CGColor];
        } else {
            [borderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [borderButton.layer setBorderColor:[UIColor colorWithHexString:BASE_LINE_COLOR].CGColor];
        }
        borderButton.titleLabel.font = SYSTEM_FONT(AdaptFont(ButtonFontSize));
        [borderButton.layer setBorderWidth:ButtonBorderWidth];
        borderButton.layer.cornerRadius = BASE_CORNER_RADIUS;
    }
    return borderButton;
}
+ (instancetype)initBorderStyleWithTitle:(NSString *)title color:(NSString *)color cornerRadius:(CGFloat)cornerRadius  {
    YHButton *borderButton  = [super buttonWithType:UIButtonTypeCustom];
    if (borderButton) {
        [borderButton setTitle:title forState:UIControlStateNormal];
        if (color) {
            if ([title isEqualToString:@"客服"]) {
                [borderButton setTitleColor:ColorWithHexString(@"666666") forState:UIControlStateNormal];
            }else
            {
            [borderButton setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
            }
            [borderButton.layer setBorderColor:[UIColor colorWithHexString:color].CGColor];
        } else {
            [borderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [borderButton.layer setBorderColor:[UIColor colorWithHexString:BASE_LINE_COLOR].CGColor];
        }
        borderButton.titleLabel.font = SYSTEM_FONT(AdaptFont(ButtonFontSize));
        [borderButton.layer setBorderWidth:ButtonBorderWidth];
        if (cornerRadius == 0) {
            borderButton.layer.cornerRadius = BASE_CORNER_RADIUS;
            
        }else
        {
           borderButton.layer.cornerRadius = cornerRadius;
        }
    }
    return borderButton;
}
+ (instancetype)initBackgroundStyleWithTitle:(NSString *)title color:(NSString *)color {
    YHButton *backgroundButton  = [super buttonWithType:UIButtonTypeSystem];
    if (backgroundButton) {
        [backgroundButton setTitle:title forState:UIControlStateNormal];
        if (color) {
            backgroundButton.backgroundColor = [UIColor colorWithHexString:color];
        }
        [backgroundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backgroundButton.titleLabel.font = SYSTEM_FONT(AdaptFont(ButtonFontSize));
        backgroundButton.layer.cornerRadius = BASE_CORNER_RADIUS;
    }
    return backgroundButton;
}

@end
