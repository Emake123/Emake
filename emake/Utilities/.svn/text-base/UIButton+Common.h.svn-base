//
//  UIButton+Common.h
//  emake
//
//  Created by chenyi on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RSButtonType) {
    RSButtonTypeRight = 0, //文字图片在右测
    RSButtonTypeLeft, //文字图片在左测
    RSButtonTypeBottom, //文字图片在下测
    RSButtonTypeTop //文字图片在上测
};
@interface UIButton (Common)

-(void)SetButtonMaskBath;

/**
 *  设置button中title的位置
 *
 *  @param type type位置类型
 
 */
- (void)setButtonShowType:(RSButtonType)type;

//-(void) verticalImageAndTitle: (CGFloat) spacing __attribute__((unavailable("该方法废弃")));
//__attribute__((deprecated("Use label.text instead.")))
-(void)setimageTopAndTitleDown;
@end
