//
//  YHMainViewController.h
//  emake
//
//  Created by 谷伟 on 2018/3/16.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "PSVCBase.h"

@interface YHMainViewController : PSVCBase
@property(nonatomic,retain)UIView *serverView;
@property(nonatomic,retain)UIView *infomationView;
-(void)RefreshMesssageCount;
@property(nonatomic,assign)NSInteger recordIndex;

@end
