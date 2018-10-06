//
//  YHCardNewCell.h
//  emake
//
//  Created by 谷伟 on 2017/9/5.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
@interface YHCardNewCell : UITableViewCell

@property (nonatomic,retain)UIImageView  *cardImageView;

@property (nonatomic,retain)UILabel *labelName;

@property (nonatomic,retain)UITextField *labelNameText;

@property (nonatomic,retain)UITextField *labelPhoneText;

@property (nonatomic,retain)UITextField *labelCompanyText;

@property (nonatomic,retain)UITextField *labelAdressText;

@property (nonatomic,retain)UITextField *labelDistrictText;

@property (nonatomic,retain)UIButton *selectBtn;

@property (nonatomic,retain)UIImageView *rightImage;

- (void)setData:(UserInfoModel *)model;
@end
