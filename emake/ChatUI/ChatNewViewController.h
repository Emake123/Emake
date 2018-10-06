//
//  ViewController.h
//  sampleObjectC
//
//  Created by oshumini on 2017/6/6.
//  Copyright © 2017年 HXHG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSVCBase.h"
@interface ChatNewViewController : PSVCBase
@property(nonatomic,copy)NSString *titleName;
@property(nonatomic,assign)BOOL isFromCartConfirm;
@property(nonatomic,strong)NSArray *orderArray;
@property(nonatomic,copy)NSString *jsonStr;
@property(nonatomic,copy)NSString *sendDataStr;
@property (nonatomic,copy)NSString *IsIncludeTax;

@property(nonatomic,copy)NSString *filePath;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSData *fileData;

@property (assign, nonatomic) BOOL isPostOrder;
@property (assign, nonatomic) BOOL isPostOrderDetail;
@property (assign, nonatomic) BOOL isUploadFile;
@property (nonatomic,copy)NSString *MQTTTopic;

@property (assign, nonatomic) BOOL isCatagory;//1输配电，0食品

@property (nonatomic,assign)NSInteger messageMaxCount;
@property (nonatomic,copy)NSString *ChatVCTitle;

//和店铺聊天的建立的唯一标识listID (storeID_userID)/（userID）
@property (nonatomic,copy)NSString *listID;
@property (nonatomic,copy)NSString *storeID;
@property (nonatomic,copy)NSString *storeName;
@property (nonatomic,copy)NSString *storeAvata;
//消息刷新
-(void)onMessgae:(NSData *)messgae andTopic:(NSString *)topic;

- (void)sendCMDRequestService;

- (void)sendFileMessageWithFilePath:(NSString *)filePath;

- (void)sendEventMessage;

- (void)displayMessageTipsEvent:(NSString *)tips;

- (void)doSomething;
@end
