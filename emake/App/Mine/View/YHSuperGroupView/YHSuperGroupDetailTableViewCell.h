//
//  YHSuperGroupDetailTableViewCell.h
//  emake
//
//  Created by zhangshichao on 2018/9/14.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSuperGroupModel.h"
@interface YHSuperGroupDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *joinview;
@property(nonatomic,strong)UILabel *dateEnd;

-(void)setRequestData:(YHSuperGroupInfoModel *)model isShowDate:(BOOL)isShowDate;
@end
