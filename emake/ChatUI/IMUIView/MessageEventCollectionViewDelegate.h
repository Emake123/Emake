//
//  MessageEventCollectionViewDelegate.h
//  emake
//
//  Created by 谷伟 on 2018/2/23.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageEventModel.h"
#import "YHCustomQuestionModel.h"
@protocol MessageEventCollectionViewDelegate <NSObject>

- (void)didTapMessageBubbleWithModel:(MessageEventModel *)model;

- (void)didTapMessageTableWith:(YHCustomQuestionModel *)model;
@end
