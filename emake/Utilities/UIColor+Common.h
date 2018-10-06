//
//  UIColor+Common.h
//  emake
//
//  Created by 袁方 on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)

+ (UIColor *)colorWithHexString:(NSString *)hexColor;
+ (UIColor *)colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha;
// RGB值
+ (UIColor *)colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;

@end
