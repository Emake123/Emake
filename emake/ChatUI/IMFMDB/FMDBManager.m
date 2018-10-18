//
//  FMDBManager.m
//  emake
//
//  Created by 谷伟 on 2017/8/31.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"

@interface FMDBManager()
@property(nonatomic,strong) FMDatabaseQueue *queue;
@property(nonatomic,strong) FMDatabaseQueue *addtionalQueue;
@end

@implementation FMDBManager
//单例
+(instancetype)sharedManager{
    
    static FMDBManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMDBManager alloc] init];
    });
    return instance;
}
#pragma mark  - 初始化
//初始化队列
- (FMDatabaseQueue *)queue{
    if (!_queue) {
        //获得Documents目录路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //拼接生成数据库路径
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        NSString *fileName=[NSString stringWithFormat:@"%@/%@_chat",doc,userID];
        //创建数据库，并加入到队列中，此时已经默认打开了数据库，无须手动打开，只需要从队列中去除数据库即可
        self.queue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    }
    return _queue;
}
- (FMDatabaseQueue *)addtionalQueue{
    if (!_addtionalQueue) {
        //获得Documents目录路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        //拼接生成数据库路径
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        NSString *fileName=[NSString stringWithFormat:@"%@/%@_chat",doc,userID];
        //创建数据库，并加入到队列中，此时已经默认打开了数据库，无须手动打开，只需要从队列中去除数据库即可
        self.addtionalQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    }
    return _addtionalQueue;
}
//创建聊天数据表
-(void)initMessageDataBaseWithUserId:(NSString *)userId{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",userId];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT, msgID text, msg text, sender text, sendTime text, msgType text , serversName text, serversAvata text)",filterSqlName];
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建表
        BOOL createTableResult = [db executeUpdate:sqlExeString];
        if (createTableResult){
            NSLog(@"UserChatData_创建表成功");
        }else{
            NSLog(@"UserChatData_创建表失败");
        }
        
    }];
}
//创建附加消息表
- (void)initAdditionalMessageDataBaseWithUserId:(NSString *)userId{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserAdditionalChatData_%@",userId];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT, msgID text, msg text, sender text, sendTime text, msgType text , serversName text, serversAvata text, recordMessageID text)",filterSqlName];
    [self.addtionalQueue inDatabase:^(FMDatabase *db) {
        //创建表
        BOOL createTableResult = [db executeUpdate:sqlExeString];
        if (createTableResult){
            NSLog(@"UserAdditionalChatData_创建表成功");
        }else{
            NSLog(@"UserAdditionalChatData_创建表失败");
        }
    }];
}

//创建聊天列表的表
- (void)initMessageListDataBaseWithUserId:(NSString *)userId{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userId];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT,userId text,userName text,userPhone text, userAvata text, userType text, sendTime text, message text, messageType text, messageCount text, storeInfo text)",filterSqlName];
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建表
        BOOL createTableResult = [db executeUpdate:sqlExeString];
        if (createTableResult){
            NSLog(@"UserChatListNew_创建表成功");
        }else{
            NSLog(@"UserChatListNew_创建表失败");
        }
    }];
}
//创建某聊天室客服信息表
- (void)initServerListListDataBaseWithUserID:(NSString *)userId{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"ServerList_%@",userId];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(id integer PRIMARY KEY AUTOINCREMENT,serversName text,storeId text, serverList text)",filterSqlName];//serversName,storeId,serverList
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建表
        BOOL createTableResult = [db executeUpdate:sqlExeString];
        if (createTableResult){
            NSLog(@"ServerList_创建表成功");
        }else{
            NSLog(@"ServerList_创建表失败");
        }
    }];
}
#pragma mark - 方法

- (void)addMessage:(SDChatMessage *)message withListID:(NSString *)listID{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *sqlExeString = [NSString stringWithFormat:@"INSERT INTO %@(msgID,msg,sender,sendTime,msgType,serversName,serversAvata) VALUES('%@','%@','%@','%@','%@','%@','%@')",filterSqlName,message.msgID,message.msg,message.sender,message.sendTime,message.msgType,message.staffName,message.staffAvata];
    [self.queue inDatabase:^(FMDatabase *db){
        BOOL isSuccess = [db executeUpdate:sqlExeString];
        if (isSuccess) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
    }];
}

- (void)addAditionalMessage:(SDChatMessage *)message withRecoedMessageID:(NSString *)messageId withListID:(NSString *)listID{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserAdditionalChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *sqlExeString = [NSString stringWithFormat:@"INSERT INTO %@(msgID,msg,sender,sendTime,msgType,serversName,serversAvata,recordMessageID) VALUES('%@','%@','%@','%@','%@','%@','%@','%@')",filterSqlName,message.msgID,message.msg,message.sender,message.sendTime,message.msgType,message.staffName,message.staffAvata,messageId];
    [self.addtionalQueue inDatabase:^(FMDatabase *db){
        BOOL isSuccess = [db executeUpdate:sqlExeString];
        if (isSuccess) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
 
    }];
}

- (void)addServerListMessage:(NSString *)serverList withStoreId:(NSString *)storeId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"ServerList_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *sqlExeString = [NSString stringWithFormat:@"INSERT INTO %@(serversName,storeId,serverList) VALUES('%@','%@','%@')",filterSqlName,userID,storeId,serverList];
    [self.queue inDatabase:^(FMDatabase *db){
        BOOL isSuccess = [db executeUpdate:sqlExeString];
        if (isSuccess) {
            NSLog(@"添加成功");
        }else{
            NSLog(@"添加失败");
        }
//        [db close];
    }];
    
}


- (void)getAllMessagewithListID:(NSString *)listID WithPage:(NSInteger)page andLastMessageID:(NSInteger)lastMessageID success:(void (^)(NSArray * responseObject))success failure:(void (^)(NSString * errorObject))failure{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@ order by msgID",filterSqlName];
    
    NSMutableArray *messageIdArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i=0; i<10; i++) {
        NSInteger messagId = lastMessageID - 10*(page-1)-i;
        [messageIdArray addObject:[NSString stringWithFormat:@"%ld",(long)messagId]];
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        NSMutableArray *totalArray = [[NSMutableArray alloc] init];
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            SDChatMessage *Message = [[SDChatMessage alloc] init];
            Message.msg = [res stringForColumn:@"msg"];
            Message.msgID = [res stringForColumn:@"msgID"];
            Message.sender = [res stringForColumn:@"sender"];
            Message.sendTime = [res stringForColumn:@"sendTime"];
            Message.msgType = [res stringForColumn:@"msgType"];
            Message.staffAvata = [res stringForColumn:@"serversAvata"];
            Message.staffName = [res stringForColumn:@"serversName"];
            NSLog(@"msgID 历史消息=%@",[res stringForColumn:@"msg"]);
            if ([messageIdArray containsObject:Message.msgID]) {
                [totalArray addObject:Message];
            }
        }
        if (totalArray.count>0) {
            for (int i = 0; i < totalArray.count; i++) {
                for (int j = 0; j < totalArray.count - 1 - i; j++) {
                    SDChatMessage *messageOne = totalArray[j];
                    SDChatMessage *messageTwo = totalArray[j + 1];
                    if ([messageOne.msgID integerValue] < [messageTwo.msgID integerValue]) {
                        SDChatMessage *tmp = totalArray[j];
                        totalArray[j] = totalArray[j + 1];
                        totalArray[j + 1] = tmp;
                    }
                }
            }
            if (lastMessageID <= page * 10) {
                NSArray *array = [self insertAdditionalMesageWithMessagArray:totalArray isTop:true withListID:listID];
                success(array);
            }else{
                NSArray *array = [self insertAdditionalMesageWithMessagArray:totalArray isTop:false withListID:listID];
                success(array);
            }
            
        }else{
            if (lastMessageID <= (page-1)*10) {
                NSArray *array = [self insertAdditionalMesageWithMessagArray:totalArray isTop:true withListID:listID];
                success(array);
            }else{
                failure(@"此页消息为空");
            }
        }
        [res close];
    }];
}

- (NSArray *)insertAdditionalMesageWithMessagArray:(NSArray *)messageArray isTop:(BOOL)top withListID:(NSString *)listID{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserAdditionalChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    
    NSMutableArray *messageIDArray = [NSMutableArray arrayWithCapacity:0];
    for (SDChatMessage *Message in messageArray) {
        [messageIDArray addObject:Message.msgID];
    }
    __block NSMutableArray *insertArray = [NSMutableArray arrayWithCapacity:0];
    __block NSMutableArray *topArray = [NSMutableArray arrayWithCapacity:0];
    [self.addtionalQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            SDChatMessage *Message = [[SDChatMessage alloc] init];
            Message.msg = [res stringForColumn:@"msg"];
            Message.msgID = [res stringForColumn:@"msgID"];
            Message.sender = [res stringForColumn:@"sender"];
            Message.sendTime = [res stringForColumn:@"sendTime"];
            Message.msgType = [res stringForColumn:@"msgType"];
            Message.staffAvata = [res stringForColumn:@"serversAvata"];
            Message.staffName = [res stringForColumn:@"serversName"];
            Message.recordMessageID = [res stringForColumn:@"recordMessageID"];
            NSString *messageIdStr = [res stringForColumn:@"recordMessageID"];
            NSLog(@"历史消息---tip--%@",[res stringForColumn:@"msg"]);
            if ([messageIDArray containsObject:messageIdStr]) {
                [insertArray addObject:Message];
            }
            if ([messageIdStr isEqualToString:@"0"]) {
                [topArray addObject:Message];
            }
        }
        [res close];
    }];
    NSMutableArray *messageTotalArray = [NSMutableArray arrayWithArray:messageArray];
    for (SDChatMessage *message in insertArray) {
        NSInteger index = [messageIDArray indexOfObject:message.recordMessageID];
        [messageTotalArray insertObject:message atIndex:index];
    }
    if (top) {
        for (SDChatMessage *message in [[topArray reverseObjectEnumerator] allObjects]) {
            [messageTotalArray addObject:message];
        }
    }
    return messageTotalArray;
}

- (BOOL)messageIsAlreadyExist:(NSString *)messageId withListID:(NSString *)listID{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    __block BOOL flag = false;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            if ([messageId isEqualToString:[res stringForColumn:@"msgID"]]) {
                flag = YES;
                break;
            }
        }
        [res close];
    }];
    return flag;
}

- (BOOL)serverLisIsAlreadyExist:(NSString *)storeId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"ServerList_%@",userID];
    NSLog(@"%@",sqlName);
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    __block BOOL flag = false;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            if ([storeId isEqualToString:[res stringForColumn:@"storeId"]]) {
                flag = YES;
                break;
            }
        }
        [res close];

    }];
    return flag;
}

- (BOOL)classifyQuestionTodayMessageIsAlreadyExistWithListID:(NSString *)listID{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserAdditionalChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    __block BOOL flag = false;
    [self.addtionalQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            if ([[res stringForColumn:@"msgType"] isEqualToString:@"SEND_Consult"]) {
                if ([res stringForColumn:@"sendTime"]) {
                    NSString *sendTime = [res stringForColumn:@"sendTime"];

                    NSString *sendTimeStr = [sendTime substringToIndex:10];
                    NSString *sendTimeStr1 = [[NSDate getCurrentTime] substringToIndex:10];

                    if ([sendTimeStr isEqualToString:sendTimeStr1]) {
                        flag = YES;
                    }
                }
            }
        }
        [res close];

    }];
    return flag;
}

- (BOOL)isNotMessageExistWithLastMessageId:(NSInteger)lastMessageId andPage:(NSInteger)page withListId:(NSString *)listID{
    
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@ order by msgID",filterSqlName];
    
    __block NSMutableArray *totalArray = [[NSMutableArray alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            NSString *messageID = [res stringForColumn:@"msgID"];
            [totalArray addObject:messageID];
        }
        [res close];

    }];
    if (lastMessageId<10) {
        if (lastMessageId <=0) {
            return false;
        }
        for (int i=0; i<lastMessageId; i++) {
            NSInteger messagId = lastMessageId - 10*(page-1)-i;
            NSString *messageIdString = [NSString stringWithFormat:@"%ld",(long)messagId];
            if (![totalArray containsObject:messageIdString]) {
                return false;
                break;
            }
        }
    }else{
        if ((lastMessageId - (page-1)*10)<10) {
            for (int i=0; i<(lastMessageId - (page-1)*10); i++) {
                NSInteger messagId = lastMessageId - 10*(page-1)-i;
                NSString *messageIdString = [NSString stringWithFormat:@"%ld",(long)messagId];
                if (![totalArray containsObject:messageIdString]) {
                    return false;
                    break;
                }
            }
        }else{
            for (int i=0; i<10; i++) {
                NSInteger messagId = lastMessageId - 10*(page-1)-i;
                NSString *messageIdString = [NSString stringWithFormat:@"%ld",(long)messagId];
                if (![totalArray containsObject:messageIdString]) {
                    return false;
                    break;
                }
            }
        }
    }
    return true;
}
- (SDChatMessage *)getMessageChatListWithOffcial{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    
    SDChatMessage *Message = [[SDChatMessage alloc] init];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            if ([[res stringForColumn:@"userId"] isEqualToString:userID]) {
                Message.sendTime = [res stringForColumn:@"sendTime"];
                Message.staffType = [res stringForColumn:@"userType"];
                Message.staffAvata = [res stringForColumn:@"userAvata"];
                Message.staffName = [res stringForColumn:@"userName"];
                Message.phoneNumber = [res stringForColumn:@"userPhone"];
                Message.msg = [res stringForColumn:@"message"];
                Message.msgType = [res stringForColumn:@"messageType"];
                Message.messageCount = [res stringForColumn:@"messageCount"];
                Message.userId = [res stringForColumn:@"userId"];
            }
        }
        [res close];

    }];
    return Message;
}

//聊天列表
- (NSMutableArray *)getAllMessageChatList{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    
    NSMutableArray *totalArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            SDChatMessage *Message = [[SDChatMessage alloc] init];
            Message.sendTime = [res stringForColumn:@"sendTime"];
            Message.staffType = [res stringForColumn:@"userType"];
            Message.staffAvata = [res stringForColumn:@"userAvata"];
            Message.staffName = [res stringForColumn:@"userName"];
            Message.phoneNumber = [res stringForColumn:@"userPhone"];
            Message.msg = [res stringForColumn:@"message"];
            Message.msgType = [res stringForColumn:@"messageType"];
            Message.messageCount = [res stringForColumn:@"messageCount"];
            Message.userId = [res stringForColumn:@"userId"];
            Message.Group = [res stringForColumn:@"storeInfo"];
//            if (![Message.userId isEqualToString:userID]) {
                [totalArray addObject:Message];
//            }
        }
        [res close];

    }];
    totalArray =(NSMutableArray *) [[totalArray reverseObjectEnumerator] allObjects];
    return totalArray;
}
//删除店铺聊天列表的那一条
- (void)deleteUserListWithListID:(NSString *)listID{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE userId = '%@'",filterSqlName,listID];
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:sqlExeString];
    }];
}
//判断存不存在
- (BOOL)userMessageListIsExistWithListID:(NSString *)listID{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT COUNT(userId) AS countNum FROM %@ WHERE userId = '%@'",filterSqlName,listID];
    //确定执行语句
    __block NSInteger count = 0;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        if ([res next]) {
            count = [res intForColumn:@"countNum"];
        }
        [res close];

    }];
    if (count == 1) {
        return YES;
    }else{
        return NO;
    }
}
//更新消息个数
- (void)updateUserMessageCount:(NSInteger)count withListID:(NSString *)listId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"UPDATE %@ SET %@='%@' WHERE userId = '%@'",filterSqlName,@"messageCount",[NSString stringWithFormat:@"%ld",count],listId];
    //确定执行语句
    //修改“messageCount”字段
    [self.queue inDatabase:^(FMDatabase *db) {
        
        if ([db executeUpdate:sqlExeString]) {
            NSLog(@"聊天更新消息个数更新成功!个数=%ld",count);
        }else{
            NSLog(@"聊天更新消息个数更新失败!");
        }
    }];
}
//聊天列表增加
- (void)addUserList:(SDChatMessage *)message withListId:(NSString *)listId andMessageCount:(NSInteger)count{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句 //,messageCount ,'%@' ,[NSString stringWithFormat:@"%ld",count]
    NSString *sqlExeString = [NSString stringWithFormat:@"INSERT INTO %@(userId,userName,userPhone,userAvata,userType,sendTime,message,messageType,messageCount,storeInfo) VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",filterSqlName,listId,message.staffName,message.phoneNumber,message.staffAvata,message.staffType,message.sendTime,message.msg,message.msgType,[NSString stringWithFormat:@"%ld",count],message.Group];
    [self.queue inDatabase:^(FMDatabase *db){
    
        if ([db executeUpdate:sqlExeString]) {
            NSLog(@"更新成功!");
        }else{
            NSLog(@"更新失败!");
        }
    }];
}

- (void)updateServerList:(NSString *)serverList withStoreId:(NSString *)storeID{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"ServerList_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@='%@' WHERE storeId = '%@'",filterSqlName,@"serverList",serverList,storeID];
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql]) {
            NSLog(@"更新成功!");
        }else{
            NSLog(@"更新失败!");
        }
    }];
}

- (NSString *)getUserInfoFromUserList:(NSString *)listId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatList_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@ where userId= '%@'",filterSqlName,listId];
    __block NSString *userInfoString = nil;
    [self.queue inDatabase:^(FMDatabase *db){
        FMResultSet *res = [db executeQuery:sqlExeString];
        if ([res next]) {
            SDChatMessage *Message = [[SDChatMessage alloc] init];
            Message.staffType = [res stringForColumn:@"userType"];
            Message.staffAvata = [res stringForColumn:@"userAvata"];
            Message.staffName = [res stringForColumn:@"userName"];
            Message.phoneNumber = [res stringForColumn:@"userPhone"];
            Message.userId = [res stringForColumn:@"userId"];
            userInfoString = [Message mj_JSONString];
        }
        [res close];

    }];
    return userInfoString;
}

//店铺信息
- (NSString *)getStoreInfoFromUserList:(NSString *)listId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@ where userId= '%@'",filterSqlName,listId];
    __block NSString *userInfoString = nil;
    [self.queue inDatabase:^(FMDatabase *db){
        FMResultSet *res = [db executeQuery:sqlExeString];
        if ([res next]) {
            userInfoString = [res stringForColumn:@"storeInfo"];
        }
        [res close];
    }];
    return userInfoString;
}

//获取客服列表
- (NSString *)getServerListWithStoreID:(NSString *)storeID{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"ServerList_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@ where storeId= '%@'",filterSqlName,storeID];
    __block NSString *serverList = nil;
    [self.queue inDatabase:^(FMDatabase *db){
        FMResultSet *res = [db executeQuery:sqlExeString];
        if ([res next]) {
            serverList = [res stringForColumn:@"serverList"];
        }
        [res close];

    }];
    return serverList;
}

- (NSInteger)getUserMessageCount:(NSString *)listId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    __block NSInteger count = 0;
    __block NSInteger Totalcount = 0;

    NSString *sqlExeString = listId.length==0?  [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName]:[NSString stringWithFormat:@"SELECT * FROM %@ where userId= '%@'",filterSqlName,listId];
    [self.queue inDatabase:^(FMDatabase *db){
        
        FMResultSet *rs = [db executeQuery:sqlExeString];
        if ([rs next]) {
            count = [[rs stringForColumn:@"messageCount"] integerValue];
            Totalcount = Totalcount+count;
            NSLog(@"fmdb消息list%@个数==%ld,Totalcount=%ld",listId, count,Totalcount);
        }
        [rs close];

    }];
    return (listId.length==0?Totalcount:count);
}
- (BOOL)isChatDataExistWith:(NSString *)listID{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *existsSql = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",filterSqlName];
    __block NSInteger count = 0;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:existsSql];
        if ([res next]) {
            count = [res intForColumn:@"count"];
        }
        [res close];

    }];
    if (count == 0) {
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isChatAdditionalDataExistWith:(NSString *)listID{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserAdditionalChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *existsSql = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = '%@'",filterSqlName];
    __block NSInteger count = 0;
    [self.addtionalQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:existsSql];
        if ([res next]) {
            count = [res intForColumn:@"count"];
        }
        [res close];

    }];
    if (count == 0) {
        return NO;
    }else{
        return YES;
    }
}
- (BOOL)isChatListAllreadyExistWith:(NSString *)listID{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatListNew_%@",userID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT COUNT(userId) AS countNum FROM %@ WHERE userId = '%@'",filterSqlName,listID];
    __block NSInteger count = 0;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        if ([res next]) {
            count = [res intForColumn:@"countNum"];
        }
        [res close];

    }];
    if (count == 0) {
        return NO;
    }else{
        return YES;
    }
}

- (NSInteger)getTheMaxMessageIdWithUserId:(NSString *)listID{
    //确定表名称
    NSString *sqlName = [NSString stringWithFormat:@"UserChatData_%@",listID];
    //过滤‘-’字符
    NSString *filterSqlName = [sqlName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //确定执行语句
    NSString *sqlExeString = [NSString stringWithFormat:@"SELECT * FROM %@",filterSqlName];
    __block NSInteger maxMessageID = 0;
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *res = [db executeQuery:sqlExeString];
        while ([res next]) {
            NSString *messageID = [res stringForColumn:@"msgID"];
            if ([messageID integerValue] >= maxMessageID) {
                maxMessageID = [messageID integerValue];
            }
        }
        [res close];

    }];
    return maxMessageID;
}
@end
