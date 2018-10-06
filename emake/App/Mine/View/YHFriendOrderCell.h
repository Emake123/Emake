//
//  YHFriendOrderCell.h
//  emake
//
//  Created by 谷伟 on 2017/9/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirendUserOrderListModel.h"
@interface YHFriendOrderCell : UITableViewCell

@property (nonatomic,retain)UILabel *orderID;
@property (nonatomic,retain)UILabel *orderCatagory;
@property (nonatomic,retain)UILabel *orderAmount;
@property (nonatomic,retain)UILabel *orderGet;
- (void)setData:(NSDictionary *)dic;
@end
