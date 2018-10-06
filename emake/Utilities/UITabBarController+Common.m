//
//  UITabBarController+Common.m
//  emake
//
//  Created by chenyi on 2017/7/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "UITabBarController+Common.h"


@implementation UITabBarController (Common)

-(void) addChildControllerWithNav: (UIViewController *) controller Name:(NSString *) name Image:(NSString *) image SelectImage:(NSString *) selectImage
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem.title = name;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont   systemFontOfSize:11],NSForegroundColorAttributeName:[UIColor grayColor]}   forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11],NSForegroundColorAttributeName:ColorWithHexString(APP_THEME_TABBAR_COLOR)} forState:UIControlStateSelected];
    
    
    [self addChildViewController:nav];
}

@end
