//
//  accountInformationView.h
//  emake
//
//  Created by eMake on 2017/10/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHListViewDelegate <NSObject>

//-(NSInteger)listNumber;
-(NSString  *)ListView:(UIView *)listView withIndex:(NSInteger)index flag:(NSInteger)flag section:(NSInteger)section;

@end
@interface accountInformationView : UIView

//显示的行数
@property(nonatomic,assign)NSInteger NumberOfLines;

//区别不同的delegate
@property(nonatomic,assign)NSInteger flag;

@property(nonatomic,assign)NSInteger section;

@property(nonatomic,assign)id <YHListViewDelegate>listViewDelegate;
@property(nonatomic,strong)UIButton *dissMIssButtton;
//文字的aligment
@property(nonatomic,assign)NSTextAlignment lableTexTAliment;
//
@property(nonatomic,strong)UILabel *bgLable;

@property(nonatomic,strong)UIButton *closeButton;


@end
