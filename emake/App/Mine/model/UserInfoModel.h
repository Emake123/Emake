//
//  UserInfoModel.h
//  emake
//
//  Created by 谷伟 on 2017/9/7.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic,copy)NSString *City;
@property (nonatomic,copy)NSString *RealName;
@property (nonatomic,copy)NSString *Province;
@property (nonatomic,copy)NSString *Email;
@property (nonatomic,copy)NSString *RawCardUrl;
@property (nonatomic,copy)NSString *UserId;
@property (nonatomic,copy)NSString *TelCell;
@property (nonatomic,copy)NSString *Company;
@property (nonatomic,copy)NSString *Address;
@property (nonatomic,copy)NSString *Title;
@property (nonatomic,copy)NSString *CardUrl;
@property (nonatomic,copy)NSString *Sex;
@property (nonatomic,copy)NSString *TelWork;
@property (nonatomic,copy)NSString *Department;
@property (nonatomic,copy)NSString *PSPDId;
@property (nonatomic,copy)NSString *BusinessCategory;
@property (nonatomic,copy)NSString *BusinessCategoryName;
@property (nonatomic,copy)NSString *PSPDIdIconBack;
@property (nonatomic,copy)NSString *PSPDIdIconFront;
@property (nonatomic,copy)NSString *HeadImageUrl;
@property (nonatomic,copy)NSString *NickName;

@property (nonatomic,copy)NSString *IsCheck;//是否显示查看
@property (nonatomic,copy)NSString *AuditRemark;//失败的原因
@property (nonatomic,copy)NSString *EditWhen;//成功审核的时间

@property (nonatomic,copy)NSString *CollectionNum;//收藏个数
@property (nonatomic,copy)NSString *TotalBonus;//我的账户金额
@property (nonatomic,copy)NSString *UserState;//审核状态 1 未审核，4失败 ， 2 审核中 。3审核成功
@property (nonatomic,copy)NSString *UserIdentity;//会员状态 0 普通用户  1城市代理商和会员   3 体验会员 2会员
@property (nonatomic,copy)NSString *VipCount;//体验会员是否领取 0 未领取，0< 已经领取
@property (nonatomic,copy)NSString *AgentState;//城市代理商 0申请中 1审核通过 2审核失败 -1未申请
@property (nonatomic,copy)NSString *ApplyTime;//城市代理商
@property (nonatomic,copy)NSString *VipNum;//城市代理商
@property (nonatomic,copy)NSDictionary *UserAccount;//(key:)TotalBonus TotalCashIn  TotalCashOut
@property (nonatomic,copy)NSArray *IdentityCategorys;//

@end
