//
//  MQTTCommandModel.m
//  emake
//
//  Created by 谷伟 on 2018/6/20.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "MQTTCommandModel.h"
#import "chatUserModel.h"
@implementation MQTTCommandModel
//聊天记录
- (instancetype)creatMessageListCMD:(NSString *)userId andStoreId:(NSString *)storeID lastMessageId:(NSInteger)messageId{
    self.cmd = @"MessageList";
    self.user_id = userId;
    if (storeID == nil) {
        self.chatroom_id = [NSString stringWithFormat:@"%@",userId];
        
    }else{
        self.chatroom_id = [NSString stringWithFormat:@"%@/%@",storeID,userId];
    }
    self.message_id_last = messageId;
    return self;
}
//请求客服服务
- (instancetype)creatRequestServiceCMD:(NSString *)userId andStoreId:(NSString *)storeID lastMessageId:(NSInteger)messageId{
    if (storeID == nil) {
        self.cmd = @"RequestService";
        self.chatroom_id = userId;
    }else{
        self.cmd = @"RequestStoreService";
        self.chatroom_id = [NSString stringWithFormat:@"%@/%@",storeID,userId];
    }
    self.user_id = userId;
    self.message_id_last = messageId;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
    
    NSString *clientId = [NSString stringWithFormat:@"user/%@",userID];
    NSString *commonNameStr = [NSString stringWithFormat:@"用户%@",[phone substringFromIndex:7]];
    NSString *ChatName = nickName.length>0?nickName:commonNameStr;
    
    NSString *headImage = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_HeadImageURLString];
    
    NSInteger Catagorynum = self.isCatagory+1;//1,2
    NSNumber *catagoryState = Userdefault(CatagoryVipState);
    NSString *vipStatestr = Userdefault(VipState);
    NSString *Type;
    if (catagoryState.integerValue ==Catagorynum || catagoryState.integerValue==3) {
        Type = vipStatestr;
    }else{
        Type = @"0";
    }
    
    chatUserModel *model = [[chatUserModel alloc] initWith:headImage formId:userID displayName:ChatName phoneNumber:phone userType:Type clientID:clientId];
    NSArray *user_info_array = @[[model mj_keyValues]];
    self.user_info = [user_info_array mj_JSONString];
    return self;
}
- (instancetype)creatRequestChatroomCustomerList:(NSString *)userId andStoreId:(NSString *)storeID{
    self.cmd = @"ChatroomCustomerList";
    self.user_id = userId;
    if (storeID != nil) {
        self.chatroom_id = [NSString stringWithFormat:@"%@/%@",storeID,userId];
    }else{
        self.chatroom_id = [NSString stringWithFormat:@"%@",userId];
    }
    return self;
}

@end
