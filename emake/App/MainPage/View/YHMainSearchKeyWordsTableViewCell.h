//
//  YHMainSearchKeyWordsTableViewCell.h
//  emake
//
//  Created by 张士超 on 2018/6/5.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol YHOrderFootViewDelegate <NSObject>
//
//- (void)renewOrderButtonClickedWithOrder:( YHOrderContract *)orderContract;;


@protocol YHSearchKeywordSDelegate <NSObject>
-(void)YhsearchKeyWords:(UIView *)item index:(NSInteger)index;
@end
@interface YHMainSearchKeyWordsTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YHSearchKeywordSDelegate> searchkeywordsDelegate;

-(void)setData:(NSArray *)arr;
@end
