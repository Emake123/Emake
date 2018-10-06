//
//  UITabBarController+Common.h
//  emake
//
//  Created by chenyi on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Common)

//+(void)getMYTabbar;

-(void) addChildControllerWithNav: (UIViewController *) controller Name:(NSString *) name Image:(NSString *) image SelectImage:(NSString *) selectImage;
@end
