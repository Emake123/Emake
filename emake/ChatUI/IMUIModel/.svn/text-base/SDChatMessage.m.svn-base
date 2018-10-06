//
//  SDChatMessage.m
//  SDChat
//
//  Created by Megatron Joker on 2017/5/19.
//  Copyright © 2017年 SlowDony. All rights reserved.
//

#import "SDChatMessage.h"

@implementation SDChatMessage

-(instancetype)initWithChatMessageDic:(NSDictionary *)dic{
    self =[super init];
    if (self){
        self.msg=dic[@"msg"]; //消息
        self.msgID=dic[@"msgID"]; //消息id
        self.sender=dic[@"sender"]; //
        self.sendTime=dic[@"sendTime"];
        self.msgType=dic[@"msgType"] ; //消息类型
        self.staffName =dic[@"staffName"];  //客服名字
        self.staffID =dic[@"staffID"]; //客服id
        self.staffAvata =dic[@"staffAvata"]; //客服id
        self.isDataExist =dic[@"isDataExist"]; //客服id
        self.Group =dic[@"Group"]; //客服id

    }
    return self;
}
+(instancetype)chatMessageWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithChatMessageDic:dic];
}
@end
