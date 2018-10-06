//
//  YHTeamProgressView.h
//  emake
//
//  Created by 张士超 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
@class teamModel;
@interface YHTeamProgressView : UIView
@property(nonatomic,strong)UIView *progressCustonmView;

@property(nonatomic,strong)UIView *getMoneyView;

@property(nonatomic,strong)UILabel *personOrder;
@property(nonatomic,strong)UIButton *ruleBtn;
@property(nonatomic,strong)UIView *teamView;
@property(nonatomic,strong)UIView *personView;


-(UIView *)progressViewWithModel:(teamModel *)Model;



@end
