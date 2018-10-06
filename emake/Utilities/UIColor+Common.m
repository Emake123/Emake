//
//  UIColor+Common.m
//  emake
//
//  Created by 袁方 on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "UIColor+Common.h"

@implementation UIColor (Common)

+ (UIColor *)colorWithHexString:(NSString *)hexColor {
    return [self colorWithHexString:hexColor alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexColor alpha:(CGFloat)alpha {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b {
    return [UIColor colorWithRed:((CGFloat)(r) / 255.0f) green:((CGFloat)(g) / 255.0f) blue:((CGFloat)(b) / 255.0f) alpha:1.0f];
}

@end
