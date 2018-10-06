//
//  YHLoginViewController.h
//  emake
//
//  Created by 袁方 on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSVCBase.h"

@interface YHLoginViewController : PSVCBase
@property (nonatomic,copy)NSString *phoneNumberFromWeb;
@property (nonatomic,assign)BOOL isLoginValid;

@end
