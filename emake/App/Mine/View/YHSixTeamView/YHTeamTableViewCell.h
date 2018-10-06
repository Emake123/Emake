//
//  YHTeamTableViewCell.h
//  emake
//
//  Created by 张士超 on 2018/1/3.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHTeamTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *leadName;
@property(nonatomic,strong)UIImageView *leadImageView;
@property(nonatomic,strong)UILabel *phoneLable;
@property(nonatomic,strong)UILabel  *companyName;
@property(nonatomic,strong)UILabel *companyAddress;
@property(nonatomic,strong)UIImageView *contributeImageview;

@property(nonatomic,strong)UIImageView *rightImageView;
@property(nonatomic,strong)UILabel *contributedLable;
@property(nonatomic,strong)UILabel *calledLable;
@property(nonatomic,strong)UIImageView *calledImageview;

@property(nonatomic,strong)UILabel *detailLable;

@end
