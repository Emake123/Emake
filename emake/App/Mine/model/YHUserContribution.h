//
//  YHUserContribution.h
//  emake
//
//  Created by 张士超 on 2018/1/8.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUserContribution : NSObject

@property(nonatomic,copy)NSString *MobileNumber;
@property(nonatomic,copy)NSString *ContractAmount;
@property(nonatomic,copy)NSString *RealName;
@property(nonatomic,copy)NSString *Company;
@property(nonatomic,copy)NSString *SonUserId;
@property(nonatomic,copy)NSString *HeadImageUrl;
@property(nonatomic,copy)NSString *JingxiaoCount;
@property(nonatomic,copy)NSString *Address;



//@property(nonatomic,copy)NSString *Address;

@property(nonatomic,copy)NSString *CommitMoney;
//@property(nonatomic,copy)NSString *Company;
//@property(nonatomic,copy)NSString *HeadImageUrl;
@property(nonatomic,copy)NSString *IsUser;
@property(nonatomic,copy)NSString *MemberState;
//@property(nonatomic,copy)NSString *MobileNumber;
//@property(nonatomic,copy)NSString *RealName;
@property(nonatomic,copy)NSString *TotalMoney;

@property(nonatomic,assign)NSInteger UserBuddyNumber;
@property(nonatomic,copy)NSString *UserId;

@property(nonatomic,assign)NSString * BuddyOrderAmount;
@property(nonatomic,assign)NSString * UserType;
@property(nonatomic,assign)NSString * BelongUsername;

@end
