//
//  MQTTCommandModel.h
//  emake
//
//  Created by 谷伟 on 2018/6/20.
//  Copyright © 2018年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTTCommandModel : NSObject
@property (nonatomic,copy)NSString *cmd;
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,strong)NSString *user_info;
@property (nonatomic,copy)NSString *chatroom_id;
@property (nonatomic,assign)NSInteger message_id_last;
@property (nonatomic,copy)NSString *message_last;

@property (nonatomic,copy)NSString *customer_id;
@property (nonatomic,strong)NSArray *customer_ids;

@property (nonatomic,assign)BOOL isCatagory;//0 输配电  1休闲食品


//请求聊天记录
- (instancetype)creatMessageListCMD:(NSString *)userId andStoreId:(NSString *)storeID lastMessageId:(NSInteger)messageId;
//请求客服服务
- (instancetype)creatRequestServiceCMD:(NSString *)userId andStoreId:(NSString *)storeID lastMessageId:(NSInteger)messageId catagoryParams:(NSDictionary *)dic;
//请求聊天室人员列表
- (instancetype)creatRequestChatroomCustomerList:(NSString *)userId andStoreId:(NSString *)storeID;
@end
