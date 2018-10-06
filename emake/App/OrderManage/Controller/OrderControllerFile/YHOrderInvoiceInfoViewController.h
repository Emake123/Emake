//
//  YHOrderInvoiceInfoViewController.h
//  emake
//
//  Created by 张士超 on 2018/4/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSVCBase.h"
@interface YHOrderInvoiceInfoViewController : PSVCBase
@property(nonatomic,copy)NSString *contractNo;
@property(nonatomic,strong)NSArray *myInvoiceList;

-(void)refreshTableData;
@end
