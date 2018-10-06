//
//  YHTabBarViewController.m
//  emake
//
//  Created by eMake on 2017/9/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHTabBarViewController.h"
#import "YHMineViewController.h"
#import "YHShoppingCartNewViewController.h"
#import "YHOrderManageNewViewController.h"
#import "YHTodayPriceViewController.h"
#import "UITabBarController+Common.h"
#import "YHMQTTClient.h"
#import "YHMainViewController.h"
#import "WZLBadgeImport.h"
@interface YHTabBarViewController ()

@end

@implementation YHTabBarViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    YHMainViewController *mainPageViewController = [[YHMainViewController alloc] init];
    
    YHTodayPriceViewController *todayPriceViewController =[[YHTodayPriceViewController alloc] init];
    
    YHShoppingCartNewViewController *shoppingCartNewViewController = [[YHShoppingCartNewViewController alloc] init];
    
    YHOrderManageNewViewController * orderManageNewViewController = [[YHOrderManageNewViewController alloc]init];
    
    YHMineViewController *mineViewController = [[YHMineViewController alloc] init];
    
    [self addChildControllerWithNav:mainPageViewController Name:@"首页" Image:@"tab_homepage" SelectImage:@"tab_homepage_select"];
     
    [self addChildControllerWithNav:todayPriceViewController Name:@"当日售价" Image:@"dnagrishoujia_wu" SelectImage:@"dnagrishoujia_you"];
    
     [self addChildControllerWithNav:shoppingCartNewViewController Name:@"购物车" Image:@"tab_shoppingcart" SelectImage:@"tab_shoppingcart_select"];
     
    [self addChildControllerWithNav:orderManageNewViewController Name:@"订单" Image:@"tab_orderform" SelectImage:@"tab_orderform_select"];
    
    [self addChildControllerWithNav:mineViewController Name:@"我的" Image:@"tab_mine" SelectImage:@"tab_mine_select"];
    
    UITabBarItem *Item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    mainPageViewController.tabBarItem = Item1;
    UITabBarItem *Item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1];
    todayPriceViewController.tabBarItem = Item2;
    UITabBarItem *Item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    shoppingCartNewViewController.tabBarItem = Item3;
    UITabBarItem *Item4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:3];
    orderManageNewViewController.tabBarItem = Item4;
    UITabBarItem *Item5 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:4];
    mineViewController.tabBarItem = Item5;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
