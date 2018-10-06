//
//  ProductParametersView.h
//  emake
//
//  Created by 谷伟 on 2017/11/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^confirmBlock)(NSArray *productIds, NSInteger numberOfItem,NSString *isInvoice);
typedef void(^myVipBlock)(bool isPushVipVC);

@interface ProductParametersView : UIView
@property (nonatomic,copy)confirmBlock confirmBlock;
@property (nonatomic,copy)myVipBlock vipBlock;

@property (nonatomic,retain)UIButton *confirmBtn;

@property (nonatomic,copy)NSString *GoodsInsuranceId;
@property (nonatomic,assign)double GoodsInsuranceRate;
@property (nonatomic,copy)NSString *GoodsAddInvoiceValue;
@property (nonatomic,copy)NSString *GoodsNoneInvoiceValue;

@property (nonatomic,retain)UIButton *addItemBtn;
@property (nonatomic,retain)UITextField *Number;
@property (nonatomic,retain)UITextField *insuranceText;

@property (nonatomic,retain)UIButton *decreseItemBtn;
@property (nonatomic,retain)NSArray *brandRate;
@property (nonatomic,retain)NSArray *largeArray;
@property (nonatomic,retain)NSArray *titleArray;
@property (nonatomic,retain)UINavigationController *navagation;
@property (nonatomic,retain)NSString *couponStr;

- (instancetype)initWithParamDic:(NSDictionary *)dic largeArray:(NSArray *)largeArray andTitleArray:(NSArray *)titleArray;

- (void)showAnimated;

- (void)removeView;
@end
