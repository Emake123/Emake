//
//  YHContractCreatViewController.h
//  emake
//
//  Created by 谷伟 on 2017/10/11.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "PSVCBase.h"
#import "YHFileModel.h"
typedef void(^ContractBlock)(NSString *contractNo);
@interface YHContractCreatViewController : PSVCBase
@property (nonatomic,copy)ContractBlock contractDataBlock;

@property(nonatomic,copy)NSString *ContractURL;
@property (nonatomic,copy)NSString *contractNo;
@property (nonatomic,copy)NSString *ContractType;
@property(nonatomic,copy)NSString *sendDataStr;
@property(nonatomic,copy)NSString *ContractState;//判断，当前的合同是否签订（ContractState 只有为0和-1 的时候才可以签订）
@property(nonatomic,copy)NSString *IsIncludeTax;//1含税 

@end
