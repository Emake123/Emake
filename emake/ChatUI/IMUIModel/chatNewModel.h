//
//  chatNewModel.h
//  emake
//
//  Created by 谷伟 on 2017/9/18.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "emake-Swift.h"

@interface chatNewModel : NSObject

@property (nonatomic,copy)NSString *  ToId;
@property (nonatomic,copy)NSDictionary *From;
@property (nonatomic,copy)NSDictionary *MessageBody;
@property (nonatomic,copy)NSString *  isOutGoing;
@property (nonatomic,copy)NSString *  MessageID;
@property (nonatomic,copy)NSString *  MessageId;
@property (nonatomic,copy)NSString *  MessageType;
@property (nonatomic,copy)NSString *  Timestamp;
@property (nonatomic,copy)NSString *  UpdateTime;
- (instancetype)initWithId:(NSString *)toId messageType:(NSString *)MessageType messageId:(NSString *)messageId user:(NSDictionary *)formUser andMessageBody:(NSDictionary *)messageBody;
@end
