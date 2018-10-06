//
//  YHMainPageCategoryCell.h
//  emake
//
//  Created by 谷伟 on 2018/3/19.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHMainPageCategoryCell : UICollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame;

//isLastObject yes代表数组中最后一个item 只展示图片 no 展示图片和文字
- (void)setData:(NSDictionary *)dict isLastObjict:(BOOL)isLastObject;
@end
