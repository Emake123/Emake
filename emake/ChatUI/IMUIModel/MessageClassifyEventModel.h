//
//  MessageClassifyEventModel.h
//  emake
//
//  Created by 谷伟 on 2018/6/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "emake-Swift.h"

@interface MessageClassifyEventModel : NSObject<IMUIMessageProtocol>
@property (nonatomic, copy) NSString * _Nonnull msgId;
@property(strong, nonatomic)NSString * _Nonnull evenText;
- (instancetype _Nonnull )initWithMsgId:(NSString *_Nonnull)msgId eventText:(NSString *_Nonnull)eventText;
@end
