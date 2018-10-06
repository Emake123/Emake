//
//  YHButton.h
//  emake
//
//  Created by 袁方 on 2017/7/19.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHButton : UIButton

+ (instancetype)initBorderStyleWithTitle:(NSString *)title;

+ (instancetype)initBorderStyleWithTitle:(NSString *)title
                                   color:(NSString *)color;

+ (instancetype)initBackgroundStyleWithTitle:(NSString *)title
                                       color:(NSString *)color;

+ (instancetype)initBorderStyleWithTitle:(NSString *)title color:(NSString *)color cornerRadius:(CGFloat)cornerRadius;
@end
