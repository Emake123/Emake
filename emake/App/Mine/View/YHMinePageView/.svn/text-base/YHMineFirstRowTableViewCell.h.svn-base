//
//  YHMineFirstRowTableViewCell.h
//  emake
//
//  Created by 张士超 on 2018/6/6.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
@protocol YHFirsrRowDelegate<NSObject>
-(void)YHFirsrRowView:(UIView *)item index:(NSInteger)index;

@end

@interface YHMineFirstRowTableViewCell : UITableViewCell
@property(nonatomic,weak)id<YHFirsrRowDelegate>delegate;
//@property(nonatomic ,strong)UILabel *lableAccount;
//@property(nonatomic ,strong)UILabel *lableCollection;
//@property(nonatomic ,strong)UILabel *lableAudit;
-(void)setData:(UserInfoModel *)model;
-(void)setChangeNameAndImage:(BOOL )isChange;
@end
