//
//  MessageEventCollectionViewCell.h
//  sampleObjectC
//
//  Created by oshumini on 2017/6/16.
//  Copyright © 2017年 HXHG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "emake-Swift.h"
#import "MessageEventCollectionViewDelegate.h"
#import "MessageEventModel.h"
#import "YHOrderContract.h"
@interface MessageEventCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak)UIViewController<MessageEventCollectionViewDelegate>* delegate;
@property(strong, nonatomic)UIView *backView;
@property(strong, nonatomic)MessageEventModel *model;

- (void)presentCell:(NSString *)eventText;
- (void)setData:(YHChatOrderContract *)contract;
@end


