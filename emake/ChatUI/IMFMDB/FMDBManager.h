//
//  FMDBManager.h
//  emake
//
//  Created by 谷伟 on 2017/8/31.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDChatMessage.h"
@interface FMDBManager : NSObject
@property(nonatomic,strong) SDChatMessage *message;

+(FMDBManager *)sharedManager;

//初始化聊天数据
-(void)initMessageDataBaseWithUserId:(NSString *)userId;
//初始化附加消息
- (void)initAdditionalMessageDataBaseWithUserId:(NSString *)userId;
//初始化聊天列表数据
- (void)initMessageListDataBaseWithUserId:(NSString *)userId;
//初始化客服表数据
- (void)initServerListListDataBaseWithUserID:(NSString *)userId;
#pragma mark - Message
/**
 *  添加一条消息
 *
 */
- (void)addMessage:(SDChatMessage *)message withListID:(NSString *)listID;
/**
 *  删除一条消息
 *
 */
- (void)deleteMessage:(SDChatMessage *)message;
/**
 *  更新一条消息
 *
 */
//- (void)updateMessage:(SDChatMessage *)message;

/**
 *  获取某一页的消息
 *
 */
- (void)getAllMessagewithListID:(NSString *)listID WithPage:(NSInteger)page andLastMessageID:(NSInteger)lastMessageID success:(void (^)(NSArray * responseObject))success failure:(void (^)(NSString * errorObject))failure;
/**
 *  消息是否存在
 */
- (BOOL)messageIsAlreadyExist:(NSString *)messageId withListID:(NSString *)listID;

/**
 *  获取聊天列表的第一条数据的Message ID;
 */
- (NSInteger)getTheFirstMessageId;
/**
 *  获取聊天列表的最大的MessageID;
 */
- (NSInteger)getTheMaxMessageIdWithUserId:(NSString *)listID;

/**
 *  今天的问题消息是否存在
 */
- (BOOL)classifyQuestionTodayMessageIsAlreadyExistWithListID:(NSString *)listID;

/**
 *  添加一条附件消息
 *
 */
- (void)addAditionalMessage:(SDChatMessage *)message withRecoedMessageID:(NSString *)messageId withListID:(NSString *)listID;
/**
 * 判断某页（某个区间）消息是否都存在
 */
- (BOOL)isNotMessageExistWithLastMessageId:(NSInteger)lastMessageId andPage:(NSInteger)page withListId:(NSString *)listID;
/**
 * 聊天列表
 */
- (NSMutableArray *)getAllMessageChatList;
/**
 * 官方客服信息
 */
- (SDChatMessage *)getMessageChatListWithOffcial;
/**
 * 删除聊天列表用户
 */
- (void)deleteUserList;
/**
 * 聊天数据表是否存在
 */
- (BOOL)isChatDataExistWith:(NSString *)listID;
/**
 * 聊天附加消息数据表是否存在
 */
- (BOOL)isChatAdditionalDataExistWith:(NSString *)listID;
/**
 * 聊天列表是否存在该用户
 */
- (BOOL)isChatListAllreadyExistWith:(NSString *)listID;
/**
 * 聊天列表添加用户
 */
- (void)addUserList:(SDChatMessage *)message withListId:(NSString *)listId andMessageCount:(NSInteger)count;
/**
 * 聊天列表删除用户
 */
- (void)deleteUserListWithListID:(NSString *)listID;

//获取店铺信息
- (NSString *)getStoreInfoFromUserList:(NSString *)listId;

//获取用户信息
- (NSString *)getUserInfoFromUserList:(NSString *)listId;

//添加客服列表信息
- (void)addServerListMessage:(NSString *)serverList withStoreId:(NSString *)storeId;

//客服列表信息是否存在
- (BOOL)serverLisIsAlreadyExist:(NSString *)storeId;

//客服列表信息更新
- (void)updateServerList:(NSString *)serverList withStoreId:(NSString *)storeID;

//获取客服列表信息
- (NSString *)getServerListWithStoreID:(NSString *)storeID;

//获取消息个数信息
- (NSInteger)getUserMessageCount:(NSString *)listId;

//更新消息个数
- (void)updateUserMessageCount:(NSInteger)count withListID:(NSString *)listId;
@end
