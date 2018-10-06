//
//  YHSettingViewController.h
//  emake
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "PSVCBase.h"
#import "UserInfoModel.h"
@interface YHSettingViewController : PSVCBase
@property(nonatomic,copy)NSString *titleStr;

@property(nonatomic,strong)UserInfoModel *model;

@end
