//
//  YHloginInfo.h
//  emake
//
//  Created by 袁方 on 2017/7/21.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHLoginUser : NSObject
@property(nonatomic ,strong)NSNumber *MobileNumber;
@property(nonatomic ,copy)NSString *NickName;
@property(nonatomic ,copy)NSString *ReferenceUserId;
@property(nonatomic ,copy)NSString *UserId;
@property(nonatomic ,copy)NSString *UserName;

@property(nonatomic ,copy)NSString *UserState;
@property(nonatomic ,copy)NSString *PrizeState;
@property(nonatomic ,copy)NSString *HeadImageUrl;
@property(nonatomic ,copy)NSString *UserType;
@property(nonatomic ,copy)NSString *RealName;
@property(nonatomic ,copy)NSString *BusinessCategory;
@property(nonatomic ,copy)NSString *BusinessCategoryName;

@property(nonatomic ,copy)NSString *PSPDId;
@property(nonatomic ,copy)NSString *IsStore;
@property(nonatomic ,copy)NSString *StoreId;

@property(nonatomic ,copy)NSString *AuditRemark;
@property(nonatomic ,copy)NSString *EditWhen;
@property(nonatomic ,copy)NSString *token;
@property(nonatomic ,copy)NSString *access_token;
@property(nonatomic ,copy)NSString *refresh_token;

@property(nonatomic ,copy)NSString *UserStyle;//1:店主 0:普通用户
@property(nonatomic ,copy)NSString *UserIdentity;//用户身份 0 普通 1 代理商 2 会员 3 体验会员
@property(nonatomic ,copy)NSString *ApplyTime;//城市代理商申请时间
@property(nonatomic ,copy)NSString *AgentState;//0申请中 1审核通过 2审核失败 -1未申请
@property(nonatomic ,copy)NSString *VipCount;//0 未申请 <0领取
@property(nonatomic ,strong)NSArray *IdentityCategorys;//0 未申请 <0领取


//判断
@property(nonatomic ,copy)NSString *CatagoryVip;//用户身份 0 普通 1 代理商 2 会员 3 体验会员

@end