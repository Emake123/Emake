//
//  SDChatMessage.h
//  SDChat
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDChatMessage : NSObject

/**
 消息
 */
@property (nonatomic,strong)NSString *msg;

/**
 消息id
 */
@property (nonatomic,strong)NSString *msgID;

/**
 消息类型
 */
@property (nonatomic,copy)NSString* msgType;

/**
 发送时间
 */
@property (nonatomic,strong)NSString *sendTime;

/**
  0顾客/1客服
 */
@property (nonatomic,copy)NSString *sender;


/**
 客服名字
 */
@property (nonatomic,strong)NSString *staffName;

/**
 客服id
 */
@property (nonatomic,strong)NSString *staffID;
/**
 客服头像
 */
@property (nonatomic,strong)NSString *staffAvata;
/**
 用户类型
 */
@property (nonatomic,strong)NSString *staffType;
/**
 是否是真消息（0/1）
 */
@property (nonatomic,strong)NSString *isDataExist;

/**
 附加消息纪录（0/1）
 */
@property (nonatomic,strong)NSString *recordMessageID;
/**
 用户手机号
 */
@property (nonatomic,strong)NSString *phoneNumber;
/**
 消息个数
 */
@property (nonatomic,strong)NSString *messageCount;
/**
 userId
 */
@property (nonatomic,strong)NSString *userId;
/**
 group
 */
@property (nonatomic,strong)NSString *Group;

-(instancetype)initWithChatMessageDic:(NSDictionary *)dic;
+(instancetype)chatMessageWithDic:(NSDictionary *)dic;
@end
