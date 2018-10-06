//
//  YHRightItemTableViewCell.h
//  emake
//
//  Created by 谷伟 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTeamMakeTaskModel.h"
@interface YHRightItemTableViewCell : UITableViewCell
@property (nonatomic,retain)UIButton *selectBtn;
-(void)requestData:(YHTeamMakeTaskModel *)model;
@end
