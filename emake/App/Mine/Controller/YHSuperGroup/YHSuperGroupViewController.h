//
//  YHSuperGroupViewController.h
//  emake
//
//  Created by zhangshichao on 2018/9/13.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "PSVCBase.h"

@interface YHSuperGroupViewController : PSVCBase
@property(nonatomic,strong)NSArray *groupList;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)BOOL isFromMine;

@end
