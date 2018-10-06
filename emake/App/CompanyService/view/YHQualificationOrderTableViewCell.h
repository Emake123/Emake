//
//  YHQualificationOrderTableViewCell.h
//  emake
//
//  Created by 谷伟 on 2017/10/24.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHQualificationOrderTableViewCell : UITableViewCell
@property (nonatomic,retain)UIButton *accountBtnOne;
@property (nonatomic,retain)UIButton *accountBtnTwo;

@property (nonatomic,retain)UIButton *invoceBtn;
@property (nonatomic,retain)UIButton *serversBtn;
- (void)updateSubVies;
@end
