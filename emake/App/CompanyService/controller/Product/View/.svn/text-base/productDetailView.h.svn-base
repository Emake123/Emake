//
//  productDetailView.h
//  emake
//
//  Created by eMake on 2017/8/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol productParamsDelegate<NSObject>
-(void)productParamsLable:(UILabel *)lable index:(NSInteger)Lableindex;
@end
@interface productDetailView : UIView
@property (nonatomic,strong)UILabel *lbParams;
@property (nonatomic,strong)UILabel *lbIndepence;
@property (nonatomic,strong)UIScrollView *scrolView;
@property (nonatomic,strong)UILabel *lbRemark;

@property (nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,assign)id <productParamsDelegate>delegate;
-(void)productParagramView:(UIView *)view withimage:(NSString *)image productSerialName:(NSString *)serialName params:(NSArray *)array;

@end
