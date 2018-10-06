//
//  YHMainSeviceCollectionViewCell.h
//  emake
//
//  Created by zhangshichao on 2018/9/18.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHCommpanyServersModel.h"

//@protocol YHSeviceViewDelegate <NSObject>
//
//
//- (void)YHSeviceView:(id)SeviceView selectItemWithIndex:(NSInteger)index;
//
//@end
@interface YHMainSeviceCollectionViewCell : UICollectionViewCell

//@property(nonatomic,assign)id delgate;

-(void)SeviceViewData:(YHCommpanyServersModel *)model;

@end
