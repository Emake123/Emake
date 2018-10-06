//
//  ProductParametersView.h
//  emake
//
//  Created by 谷伟 on 2017/11/28.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^confirmBlock)(NSArray *productIds, NSInteger numberOfItem);
@interface ProductParametersView : UIView
@property (nonatomic,copy)confirmBlock confirmBlock;
@property (nonatomic,retain)UIButton *confirmBtn;

@property (nonatomic,copy)NSString *GoodsInsuranceId;
@property (nonatomic,copy)NSString *GoodsInsuranceRate;

@property (nonatomic,retain)UIButton *addItemBtn;
@property (nonatomic,retain)UITextField *Number;
@property (nonatomic,retain)UITextField *insuranceText;

@property (nonatomic,retain)UIButton *decreseItemBtn;
@property (nonatomic,retain)NSArray *brandRate;
@property (nonatomic,retain)NSArray *largeArray;
@property (nonatomic,retain)NSArray *titleArray;
- (instancetype)initWithItemImage:(NSString *)itemImageUrl PriceValue:(NSString *)priceValue taxDecription:(NSString *)taxDetail largeArray:(NSArray *)largeArray andTitleArray:(NSArray *)titleArray;

- (void)showAnimated;

- (void)removeView;
@end
