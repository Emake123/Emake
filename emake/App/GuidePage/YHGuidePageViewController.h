//
//  YHGuidePageViewController.h
//  emake
//
//  Created by 谷伟 on 2018/6/1.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TransitionBlock)();
@interface YHGuidePageViewController : UIViewController
@property (nonatomic,copy)TransitionBlock block;
@end
