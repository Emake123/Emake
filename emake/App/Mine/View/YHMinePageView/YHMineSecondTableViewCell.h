//
//  YHMineSecondTableViewCell.h
//  emake
//
//  Created by 张士超 on 2018/6/21.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
@protocol YHSecondRowDelegate<NSObject>
-(void)YHSecondRowView:(UIView *)item index:(NSInteger)index;

@end
@interface YHMineSecondTableViewCell : UITableViewCell
@property(nonatomic,weak)id<YHSecondRowDelegate>delegate;

@end
