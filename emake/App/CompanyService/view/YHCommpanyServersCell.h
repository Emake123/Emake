//
//  YHCommpanyServersCell.h
//  emake
//
//  Created by 谷伟 on 2017/10/25.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHCommpanyServersModel.h"
@interface YHCommpanyServersCell : UITableViewCell
@property (nonatomic,retain)UILabel *labelTile;
@property (nonatomic,retain)UILabel *labeldetailTile;

@property (nonatomic,retain)UIImageView *leftImage;

@property (nonatomic,retain)UIView *cellBrandView;
@property (nonatomic,retain)UIView *cellInsuranceView;
@property (nonatomic,retain)UIView *cellSalledView;

- (void)setData:(YHCommpanyServersModel *)model;
@end
