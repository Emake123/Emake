//
//  YHMQTTClientDelegate.h
//  MQTTClientManager
//
//  Created by 谷伟 on 2017/9/30.
//  Copyright © 2017年 谷伟. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol YHMQTTClientDelegate <NSObject>

@optional
//事件
- (void)onEvent:(NSData *)messgae andTopic:(NSString *)topic;


//消息
- (void)onMessgae:(NSData *)messgae andTopic:(NSString *)topic;


//指令
- (void)onCommand:(NSData *)messgae andTopic:(NSString *)topic;

@end
