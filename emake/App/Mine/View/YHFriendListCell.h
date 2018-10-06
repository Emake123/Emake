//
//  YHFriendListCell.h
//  emake
//
//  Created by 谷伟 on 2017/9/6.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHFriendListCell : UITableViewCell
@property (nonatomic,retain)UIImageView *headImage;
@property (nonatomic,retain)UILabel *labelName;
@property (nonatomic,retain)UILabel *labelPhone;
@property (nonatomic,retain)UILabel *labelCompany;
@property (nonatomic,retain)UILabel *labelAdress;
@property (nonatomic,retain)UILabel *labelScore;
@property (nonatomic,retain)UILabel *labelAmount;
- (void)setData:(UserFriendModel *)model;

@end
