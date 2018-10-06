//
//  UserFriendModel.h
//  emake
//
//  Created by 谷伟 on 2017/9/14.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserFriendModel : NSObject
@property (nonatomic,copy)NSString *Address;
@property (nonatomic,copy)NSString *Company;
@property (nonatomic,copy)NSString *FriendUserId;
@property (nonatomic,copy)NSString *HeadImageUrl;
@property (nonatomic,copy)NSString *MobileNumber;
@property (nonatomic,copy)NSString *Percentage;
@property (nonatomic,copy)NSString *Price;
@property (nonatomic,copy)NSString *RealName;
@property (nonatomic,copy)NSString *Score;
@property (nonatomic,copy)NSArray *FriendUserOrderList;

//首页滚动图images
@property (nonatomic,copy)NSString *ImageUrl;
@end
