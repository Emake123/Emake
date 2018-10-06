//
//  UIView+Common.m
//  emake
//
//  Created by 袁方 on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "UIView+Common.h"
#import "UIView+PSAutoLayout.h"
#import "MBProgressHUD.h"

#define kHUD_Tag        99998

@implementation UIView (Common)

#pragma mark - Frame

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setTop:(CGFloat)t {
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark - MBProgressHUD

// 显示菊花
- (void)showWait:(NSString *)message viewType:(ShowViewType)viewType {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.label.text = message;
    hud.label.font = [UIFont boldSystemFontOfSize:12.0f];
    hud.yOffset = -20;
    hud.cornerRadius = 6.0f;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.tag = kHUD_Tag;
    
    if (viewType == UIKeyWindow) {
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
    } else if (viewType == CurrentView) {
        [self addSubview:hud];
        [self bringSubviewToFront:hud];
    }
    
    [hud showAnimated:YES];
}

// 更新菊花
- (void)updateWait:(NSString *)message viewType:(ShowViewType)viewType {
    // get the container view
    UIView *containerView = self;
    if (viewType == UIKeyWindow) {
        containerView = [UIApplication sharedApplication].keyWindow;
    }
    
    // get the hud with tag
    UIView *hudView = [containerView viewWithTag:kHUD_Tag];
    if ([hudView isKindOfClass:[MBProgressHUD class]]) {
        MBProgressHUD *hud = (MBProgressHUD *)hudView;
        
        // update the hud label text
        hud.labelText = message;
    }
}

// 隐藏菊花
- (void)hideWait:(ShowViewType)viewType {
    if (viewType == UIKeyWindow) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    } else if (viewType == CurrentView) {
        [MBProgressHUD hideHUDForView:self animated:YES];
    }
}


- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UIView *)customShowAlert:(NSString *)title image:(NSString *)image
{
    UIView *showView = [[UIView alloc] init];
    showView.backgroundColor = ColorWithHexString(@"1b1b1b");
    showView.translatesAutoresizingMaskIntoConstraints = NO;
    showView.alpha= 0.85;
    showView.layer.cornerRadius = 6;
    showView.layer.masksToBounds = YES;
    [self addSubview:showView];
    [showView PSSetCenterX];
    [showView PSSetTop:ScreenHeight/2.0];
    [showView PSSetSize:WidthRate( 262) Height:HeightRate(120)];
    
    UIImageView *imageview  = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:image];
    imageview.translatesAutoresizingMaskIntoConstraints = NO;
    [showView addSubview:imageview];
    [imageview PSSetCenterX];
    [imageview PSSetTop:HeightRate(80-27-20-20)];
    [imageview PSSetSize:WidthRate( 42) Height:HeightRate(42)];
    
    UILabel *lable = [UILabel new];
    lable.text = title;
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor whiteColor];
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [showView addSubview:lable];
    [lable PSSetBottomAtItem:imageview Length:HeightRate(10)];
    [lable PSSetCenterX];
    return showView;
    
}

+(UIView *)customItemBottomTitle:(NSString *)title AndTobImage:(NSString *)image WithSize:(CGSize)size color:(NSString *)colorStr
{
    UIView *showView = [[UIView alloc] init];

    UIImageView *imageview  = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:image];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.translatesAutoresizingMaskIntoConstraints = NO;
    [showView addSubview:imageview];
    [imageview PSSetCenterX];
    [imageview PSSetTop:HeightRate(5)];
    [imageview PSSetSize:size.width Height:size.height-20];
    
    UILabel *lable = [UILabel new];
    lable.text = title;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:AdaptFont(13)];
    lable.textColor = ColorWithHexString(colorStr);
    lable.translatesAutoresizingMaskIntoConstraints = NO;
    [showView addSubview:lable];
    [lable PSSetBottomAtItem:imageview Length:HeightRate(5)];
    [lable PSSetCenterX];
    
    return showView;
}
@end
