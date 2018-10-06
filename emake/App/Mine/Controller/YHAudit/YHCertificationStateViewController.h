//
//  YHCertificationStateViewController.h
//  emake
//
//  Created by 谷伟 on 2017/10/10.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "PSVCBase.h"

@interface YHCertificationStateViewController : PSVCBase
@property (nonatomic,assign)NSInteger state;
@property (nonatomic,copy)NSString *failReason;
@property (nonatomic,copy)NSString *successDate;
@property (nonatomic,copy)NSString *isCheck;

@end
