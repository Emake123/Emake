//
//  UIView+Common.h
//  emake
//
//  Created by 袁方 on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowViewType) {
    UIKeyWindow,
    CurrentView,
};

@interface UIView (Common)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

// 等待菊花
- (void)showWait:(NSString *)message viewType:(ShowViewType)viewType;
- (void)updateWait:(NSString *)message viewType:(ShowViewType)viewType;
- (void)hideWait:(ShowViewType)viewType;

- (UIImage*) createImageWithColor: (UIColor*) color;

//自定义警告框
-(UIView *)customShowAlert:(NSString *)title image:(NSString *)image;

//
+(UIView *)customItemBottomTitle:(NSString *)title AndTobImage:(NSString *)image WithSize:(CGSize)size color:(NSString *)colorStr;
@end
