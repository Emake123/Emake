//
//  ViewController.m
//  sampleObjectC
//
//  Created by oshumini on 2017/6/6.
//  Copyright © 2017年 HXHG. All rights reserved.
//
#import <Photos/Photos.h>
#import "ChatNewViewController.h"
#import "emake-Swift.h"
#import "MessageModel.h"
#import "UserModel.h"
#import "MessageEventModel.h"
#import "FMDBManager.h"
#import "OSSClientLike.h"
#import "chatNewModel.h"
#import "chatUserModel.h"
#import "chatBodyModel.h"
#import "MQTTCommandModel.h"
#import "YHMQTTClient.h"
#import "YHContractCreatViewController.h"
#import "YHMissonCreatSuccessView.h"
#import "YHSixTeamViewController.h"
#import "MessageEventCollectionViewCell.h"
#import "YHShoppingCartConfirmViewController.h"
#import "YHContractSighSuccessViewController.h"
#import "SKFPreViewNavController.h"
#import "YHProductDetailsViewController.h"
#import "YHGoodsModel.h"
#import "YHFileModel.h"
#import "YHFileOptionViewController.h"
#import "YHMessageClassifyCollectionViewCell.h"
#import "MessageClassifyEventModel.h"
#import "YHCertificationStateOriginalViewController.h"
#import "YHCertificationStateViewController.h"
#import "MQTTCommandModel.h"
#import "MesssageEventTipsCollectionViewCell.h"
#import "MessageEventTipsModel.h"
#import "YHOrderContract.h"
#import "YHChatConfirmOrderViewController.h"
#import "YHCommonWebViewController.h"
#import "YHStoreModel.h"
@interface ChatNewViewController ()<IMUIInputViewDelegate, IMUIMessageMessageCollectionViewDelegate,YHMQTTClientDelegate,MessageEventCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet IMUIMessageCollectionView *messageList;
@property (weak, nonatomic) IBOutlet IMUIInputView *imuiInputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distance;
@property (nonatomic,copy)NSString *pasteText;
@property (nonatomic,assign)float KeyFrameIndex;
@property (assign, nonatomic) NSInteger page;
@property (retain, nonatomic) NSMutableArray *chatListArray;
@property (nonatomic,copy)NSString *contractType;
@property (nonatomic,assign)BOOL isMessageDisplay;
@property (nonatomic,copy)NSString *lastTimeSendMessage;
@end

@implementation ChatNewViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:@"CustomerService" label:@"客服"];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    if (self.storeID != nil) {
        self.MQTTTopic = [NSString stringWithFormat:@"chatroom/%@/%@",self.storeID,userId];
    }else{
        self.MQTTTopic = [NSString stringWithFormat:@"chatroom/%@",userId];
    }
    self.messageMaxCount = [[FMDBManager sharedManager] getTheMaxMessageIdWithUserId:self.listID];
    [self sendCommandMessageWithLastMessageId:0];
    [[FMDBManager sharedManager] initMessageDataBaseWithUserId:self.listID];
    [[FMDBManager sharedManager] initAdditionalMessageDataBaseWithUserId:self.listID];
    self.lastTimeSendMessage = @"0";    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isPostOrder = false;
    self.isPostOrderDetail = false;
    //语音停止播放
    [[IMUIAudioPlayerHelper sharedInstance] stopAudio];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.storeName.length>0) {
        self.title =self.ChatVCTitle.length>0?self.ChatVCTitle:[NSString stringWithFormat:@"%@",self.storeName];

    }else
    {
        self.title = @"易智造官方客服";

    }
    [YHMQTTClient sharedClient].delegate = self;
    self.page = 0;
    self.chatListArray = [NSMutableArray arrayWithCapacity:0];
    [self addRigthDetailButtonIsShowCart:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSomething)];
    [self.messageList addGestureRecognizer:gesture];
    [self.messageList.messageCollectionView registerClass:[MessageEventCollectionViewCell class] forCellWithReuseIdentifier:[[MessageEventCollectionViewCell class] description]];
    [self.messageList.messageCollectionView registerClass:[YHMessageClassifyCollectionViewCell class] forCellWithReuseIdentifier:[[YHMessageClassifyCollectionViewCell class] description]];
    [self.messageList.messageCollectionView registerClass:[MesssageEventTipsCollectionViewCell class] forCellWithReuseIdentifier:[[MesssageEventTipsCollectionViewCell class] description]];
    [self.imuiInputView.micBtn addTarget:self action:@selector(clickMicBtn) forControlEvents:UIControlEventTouchUpInside];
    self.messageList.delegate = self;
    self.imuiInputView.inputViewDelegate = self;
    self.messageList.messageCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [self.messageList.messageCollectionView.mj_header beginRefreshingWithCompletionBlock:^{
        [self.imuiInputView hideFeatureView];
    }];
    [self.messageList.messageCollectionView.mj_header beginRefreshing];
}
- (void)loadMoreData{
    self.page++;
    if (![[FMDBManager sharedManager] isNotMessageExistWithLastMessageId:self.messageMaxCount andPage:self.page withListId:self.listID]) {
        if (self.messageMaxCount <= (self.page-1)*10) {
            [self.messageList.messageCollectionView.mj_header endRefreshing];
            if (self.messageMaxCount == 0 && self.page == 1) {
                [self displayHistoryListWithPage];
                return;
            }
            [self sendEventMessage];
            return;
        }
        NSInteger lastMessageID = self.messageMaxCount - (self.page-1)*10;
        [self sendCommandMessageWithLastMessageId:lastMessageID];
        [self sendEventMessage];
        [self.messageList.messageCollectionView.mj_header endRefreshing];
    }else{
       [self displayHistoryListWithPage];
    }
}
- (void)sendEventMessage{
    if (self.page == 1) {
        //延迟0.6s等待10个消息展示完成后显示
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.isUploadFile == YES) {
                self.isUploadFile = NO;
                [self sendFileMessageWithFilePath:self.filePath];
            }
            if (self.page == 1 && self.isPostOrderDetail == true) {
                [self didSelectProduct];
                [self.messageList.messageCollectionView.mj_header endRefreshing];
            }
            if (self.page == 1 && self.isPostOrder == true) {
                [self postOrderEvent];
                [self.messageList.messageCollectionView.mj_header endRefreshing];
            }else{
                [self.messageList.messageCollectionView.mj_header endRefreshing];
            }
            if (self.page == 1 && self.storeID == nil) {
                [self getMessageClassifyList];
            }
        });
    }
}
- (void)doSomething {
    [self.imuiInputView hideFeatureView];
}
//发送指令
- (void)sendCommandMessageWithLastMessageId:(NSInteger)lastMessageId{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *topic = [NSString stringWithFormat:@"user/%@",userID];
    NSLog(@"发送指令==%@",self.storeID);
    MQTTCommandModel *model = [[MQTTCommandModel alloc] creatMessageListCMD:userID andStoreId:self.storeID lastMessageId:lastMessageId];
    [[YHMQTTClient sharedClient] sendCommmand:[model mj_keyValues] withSelfTopic:topic complete:^(NSError *error) {
        if (!error) {
        }
    }];
}
//快捷问题的问答
- (void)getMessageClassifyList{
    if ([[FMDBManager sharedManager] classifyQuestionTodayMessageIsAlreadyExistWithListID:self.listID]) {
        return;
    }
    [[YHJsonRequest shared] getAppAdviceSuccessBlock:^(NSDictionary *dict) {
        [self postMessageClassifyEvent:dict];
    } fialureBlock:^(NSString *errorMessages) {
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
    }];
}
//展示咨询消息
- (void)postMessageClassifyEvent:(NSDictionary *)questionDict{
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    NSString *currentTime = [NSDate getCurrentTime];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:questionDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    MessageClassifyEventModel *eventModel = [[MessageClassifyEventModel alloc]initWithMsgId:messageIdString eventText:str];
    [self.messageList appendMessageWith: eventModel];
    //附加消息
    [self addToAddtionalFMDB:str messageId:messageIdString sender:@"0" sendTime:currentTime msgType:@"SEND_Consult" staffName:@"" staffAvata:@"" andListID:self.listID];
    [self.messageList scrollToBottomWith:YES];
}
//展示Tips消息
- (void)displayMessageTipsEvent:(NSString *)tips{
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    NSString *currentTime = [NSDate getCurrentTimeStr];
    NSString *showStr = [self autoReplyOnNight];
    NSString *sendShowStr;
    if (showStr.length>0) {
        sendShowStr = showStr;
    }else{
        sendShowStr = tips;
    }
    MessageEventTipsModel *eventModel = [[MessageEventTipsModel alloc] initWithMsgId:messageIdString eventText:tips];
    [self.messageList appendMessageWith: eventModel];
    [self.messageList scrollToBottomWith:YES];
    //附加消息
    //上个页面传过来的
    [self addToAddtionalFMDB:tips messageId:messageIdString sender:@"0" sendTime:currentTime msgType:@"SEND_Tips" staffName:@"" staffAvata:@"" andListID:self.listID];
    [self.messageList scrollToBottomWith:YES];
}
//数据库拿取数据
- (void)displayHistoryListWithPage{
    [[FMDBManager sharedManager] getAllMessagewithListID:self.listID WithPage:self.page andLastMessageID:self.messageMaxCount success:^(NSArray *responseObject) {
        [self displayHistoryList:responseObject];
        [self sendEventMessage];
        [self.messageList.messageCollectionView.mj_header endRefreshing];
    } failure:^(NSString *errorObject) {
        [self.view makeToast:errorObject duration:1.0 position:CSToastPositionCenter];
        [self.messageList.messageCollectionView.mj_header endRefreshing];
    }];
}
//发送订单消息
- (void)postOrderEvent{
    if(self.jsonStr.length>0){
        //发送合同号
        NSString *messageIdString = [[NSUUID UUID] UUIDString];
        chatNewModel *model = [self creatMessageModelData:self.jsonStr andType:@"Order" messageIdString:messageIdString];
        //发送消息
        if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
            [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                if (!error) {
                    [self sendCMDRequestService];
                }else{
                    [self.view makeToast:@"订单发送失败"];
                }
            }];
        }else{
            [self.view makeToast:@"订单发送失败"];
        }
        [self compareDate];
    }
}
//发送文件
- (void)sendFileMessageWithFilePath:(NSString *)filePath{
    [self.imuiInputView hideFeatureView];
    UserModel *user = [UserModel new];
    user.isOutgoing = true;
    NSString *CurrentTime = [NSDate getCurrentTimeStr];
    NSString *timeStr = [self isNeedShowTime:CurrentTime lastSendMessageTime:self.lastTimeSendMessage];
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    YHFileModel *fileModel = [[YHFileModel alloc]init];
    fileModel.FileName = self.fileName;
    fileModel.FileSize = [Tools fileSizeWithInterge:self.fileData.length];
    fileModel.FilePath = [self getFilePath:messageIdString andFileName:self.fileName];
    fileModel.FileSendTime = CurrentTime;
    NSString *jsonStr = [fileModel mj_JSONString];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",messageIdString,fileModel.FileName];
    [[OSSClientLike sharedClient] uploadFileObjectAsync:self.fileData withFileName:fileName andType:file succcessBlock:^{
        chatNewModel *model  = [self creatMessageModelData:jsonStr andType:@"File" messageIdString:messageIdString];
        if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
            [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                if (!error) {
                    [self sendCMDRequestService];
                }else{
                    self.lastTimeSendMessage = CurrentTime;
                    MessageModel *message = [[MessageModel alloc] initWithFileText:jsonStr messageId:filePath fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
                    [_messageList appendMessageWith: message];
                    [self.messageList scrollToBottomWith:YES];
                }
            }];
        }else{
            self.lastTimeSendMessage = CurrentTime;
            MessageModel *message = [[MessageModel alloc] initWithFileText:jsonStr messageId:filePath fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
            [_messageList appendMessageWith: message];
            [self.messageList scrollToBottomWith:YES];
        }
        [self compareDate];
    } failBLock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lastTimeSendMessage = CurrentTime;
            MessageModel *message = [[MessageModel alloc] initWithFileText:jsonStr messageId:filePath fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
            [_messageList appendMessageWith: message];
            [self.messageList scrollToBottomWith:YES];
        });
    }];

}
//展示历史消息
- (void)displayHistoryList:(NSArray *)insertListData{
    
    for (SDChatMessage *msg in insertListData){
        NSString *timeString = [self isNeedShowTime:msg.sendTime lastSendMessageTime:self.lastTimeSendMessage];
        self.lastTimeSendMessage = msg.sendTime;
        if ([self.messageList.chatDataManager.allMsgidArr containsObject:msg.msgID]) {
            return;
        }
        UserModel *user = [UserModel new];
        user.serversAvata = msg.staffAvata;
        user.isOutgoing = [msg.sender integerValue];
        user.displayName = msg.staffName;
        if ([msg.msgType isEqualToString:@"SEND_TEXT"] ) {
            MessageModel *message = [[MessageModel alloc] initWithText:msg.msg messageId:msg.msgID fromUser:user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [self.messageList insertMessageWith:message];
        }else if ([msg.msgType isEqualToString:@"SEND_IMAGE"] ){
            MessageModel *message = [[MessageModel alloc] initWithImagePath:msg.msg messageId:msg.msgID fromUser:user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [self.messageList insertMessageWith: message];
        }else if ([msg.msgType isEqualToString:@"SEND_MutilePart"]){
            YHChatContractModel *chatContractModel = [YHChatContractModel mj_objectWithKeyValues:msg.msg];
            self.contractType = chatContractModel.ContractType;
            MessageModel *message = [[MessageModel alloc] initWithText:msg.msg IsIncludeTax:nil ContractNo:nil ContractState:nil ContractImagePath:chatContractModel.Image ContractURL:chatContractModel.Url messageId:msg.msgID fromUser:user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [self.messageList insertMessageWith: message];
        }else if ([msg.msgType isEqualToString:@"SEND_Order"] ) {
            MessageEventModel *eventModel = [[MessageEventModel alloc]initWithMsgId:msg.msgID eventText:msg.msg];
            [self.messageList insertMessageWith: eventModel];
        }else if ([msg.msgType isEqualToString:@"SEND_Goods"]){
            MessageModel *message = [[MessageModel alloc] initWithProductJsonText:msg.msg messageId:msg.msgID fromUser:(id<IMUIUserProtocol>)user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [self.messageList insertMessageWith:message];
        }else if ([msg.msgType isEqualToString:@"SEND_Voice"]){
            YHChatVoiceModel *voiceModel = [YHChatVoiceModel mj_objectWithKeyValues:msg.msg];
            NSURL *voiceUrl = [NSURL URLWithString:voiceModel.VoiceFilePath];
            NSString *voiceLastComponent = [voiceUrl lastPathComponent];
            if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:voiceLastComponent]]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self getVoicePath:voiceLastComponent]]];
                if (data.bytes>0&&data) {
                    [data writeToFile:[Tools getVoicePath:voiceLastComponent] atomically:YES];
                }
            }
            MessageModel *  message = [[MessageModel alloc] initWithVoicePath:[Tools getVoicePath:voiceLastComponent] duration:voiceModel.VoiceLength.integerValue  messageId:msg.msgID fromUser:user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [_messageList insertMessageWith: message];
        }else if([msg.msgType isEqualToString:@"SEND_File"]){
            YHFileModel *fileModel = [YHFileModel mj_objectWithKeyValues:msg.msg];
           
            NSString *fileName = [NSString stringWithFormat:@"%@_%@",fileModel.FileSendTime,fileModel.FileName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileName]]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileModel.FilePath]];
                if (data.bytes>0&&data) {
                    [data writeToFile:[Tools getPath:fileName] atomically:YES];
                }
            }
            MessageModel *message = [[MessageModel alloc] initWithFileText:msg.msg messageId:msg.msgID fromUser:user timeString:timeString isOutgoing:[msg.sender integerValue] status:IMUIMessageStatusSuccess];
            [_messageList insertMessageWith: message];
        }else if([msg.msgType isEqualToString:@"SEND_Consult"]){
            MessageClassifyEventModel *eventModel = [[MessageClassifyEventModel alloc]initWithMsgId:msg.msgID eventText:msg.msg];
            [self.messageList insertMessageWith: eventModel];
        }else if([msg.msgType isEqualToString:@"SEND_Tips"]){
            MessageEventTipsModel *eventModel = [[MessageEventTipsModel alloc]initWithMsgId:msg.msgID eventText:msg.msg];
            [self.messageList insertMessageWith: eventModel];
        }
    }
    if (self.page == 1) {
        [self.messageList scrollToBottomWith:YES];
    }
}
//发送客服接入请求（待定）
- (void)sendCMDRequestService{
    NSArray *customer_ids;
    if ([self.listID containsString:@"_"]) {
        NSString *serverList = [[FMDBManager sharedManager] getServerListWithStoreID:self.storeID];
        customer_ids = [serverList mj_JSONObject];
    }else{
        customer_ids = [[NSUserDefaults standardUserDefaults] objectForKey:USERREQUESTSERVER];
    }
    if (customer_ids.count<=0) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self displayMessageTipsEvent:@"客服接入中"];
        });
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        NSString *topic = [NSString stringWithFormat:@"user/%@",userID];
        NSString *storeID = nil;
        if ([self.listID containsString:@"_"]) {
            NSArray *array = [self.listID componentsSeparatedByString:@"_"];
            if (array.count == 2) {
                storeID = array[0];
            }
        }
        MQTTCommandModel *model = [[MQTTCommandModel alloc] creatRequestServiceCMD:userID andStoreId:storeID lastMessageId:0];
        [[YHMQTTClient sharedClient] sendCommmand:[model mj_keyValues] withSelfTopic:topic complete:^(NSError *error) {
            
            
        }];
    }
}
//是否显示时间
- (NSString *)isNeedShowTime:(NSString *)currentTime lastSendMessageTime:(NSString *)lastTime{
    BOOL isNeedShow = [NSDate isValideTimeIntervalDifferenceWithTime:lastTime currentTime:currentTime];
    self.lastTimeSendMessage = currentTime;
    if (!isNeedShow) {
        return @"";
    }
    return [Tools stringFromTimestamp:currentTime];
}

- (void)clickMicBtn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// - MARK: IMUIInputViewDelegate
- (void)messageCollectionView:(UICollectionView * _Nonnull)willBeginDragging {
    [_imuiInputView hideFeatureView];
}
- (void)keyBoardWillShowWithHeight:(CGFloat)height durationTime:(double)durationTime {
    
    self.distance.constant = height;
    self.KeyFrameIndex = HeightRate(height);
    if (ScreenWidth == 320) {
        self.KeyFrameIndex = self.KeyFrameIndex + HeightRate(40);
        height = height + 10;
    }
    [self.messageList scrollToBottomWith:YES];
    if (self.messageList.messageCollectionView.contentSize.height<HeightRate(300)) {
        return;
    }
    [self.messageList.messageCollectionView setContentOffset:CGPointMake(0, self.messageList.messageCollectionView.contentSize.height+ height + HeightRate(150) - ScreenHeight) animated:YES];
}
#pragma mark---夜间自动回复
-(NSString *)autoReplyOnNight{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSString *   messageText = @"亲，您的咨询易智造平台已记录，客服当班后将第一时间给您回复（8:30—17:00），给您带来不便敬请谅解，希望您继续支持易智造平台，祝您愉快";
    NSInteger  week = [comps weekday];
    if (week == 1 || week == 7) {
        return messageText;
    }else{
        CGFloat time =comps.hour+(comps.minute/60.0);
        if (time < 8.5 || comps.hour >= 21) {
            return messageText;
        }
        return nil;
    }
}
-(void)compareDate{
    //    1－－星期天/ 2－－星期一 /3－－星期二 /4－－星期三 /5－－星期四 /6－－星期五 /6－－星期五 /7－－星期六
    NSString *callStr = [self autoReplyOnNight];
    if (callStr.length>0) {
        [self displayMessageTipsEvent:callStr];
    }
}
#pragma mark - IMUIInputViewDelegate
// 文字消息
- (void)sendTextMessage:(NSString * _Nonnull)messageText {
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    NSString *currentTime = [NSDate getCurrentTimeStr];
    NSString *timeStr = [self isNeedShowTime:currentTime lastSendMessageTime:self.lastTimeSendMessage];
    UserModel *user = [UserModel new];
    user.isOutgoing = YES;
    chatNewModel *model = [self creatMessageModelData:messageText andType:@"Text" messageIdString:messageIdString];
    //发送消息
    if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
        [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
            if (!error) {
                
                [self sendCMDRequestService];
                
            }else{
                self.lastTimeSendMessage = currentTime;
                MessageModel *message = [[MessageModel alloc] initWithText:messageText messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
                [self.messageList appendMessageWith:message];
                [self.messageList scrollToBottomWith:YES];
            }
        }];
    }else{
        self.lastTimeSendMessage = currentTime;
        MessageModel *message = [[MessageModel alloc] initWithText:messageText messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
        [self.messageList appendMessageWith:message];
        [self.messageList scrollToBottomWith:YES];
    }
    [self compareDate];
}

/// Tells the delegate that IMUIInputView will switch to recording voice mode
- (void)switchToMicrophoneModeWithRecordVoiceBtn:(UIButton * _Nonnull)recordVoiceBtn {
    
}
// 开始录音
- (void)startRecordVoice {
    NSLog(@"000000=");
    [self performSelector:@selector(stopRecord) withObject:nil afterDelay:62];
}
    //结束录音
- (void)stopRecord{
    
    IMUIRecordVoiceCell *cell = (IMUIRecordVoiceCell *)[self.imuiInputView.featureView.featureCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [cell finishRecordVoice];
}
    // 录音完成
- (void)finishRecordVoice:(NSString * _Nonnull)voicePath durationTime:(double)durationTime {
    if (((int)durationTime)<1) {
        [self.view makeToast:@"录音时间太短" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    UserModel *user = [UserModel new];
    user.isOutgoing = true;
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    NSString *currentTime = [NSDate getCurrentTimeStr];
    NSString *timeStr = [self isNeedShowTime:currentTime lastSendMessageTime:self.lastTimeSendMessage];
    YHChatVoiceModel *voiceModel = [[YHChatVoiceModel alloc] init];
    voiceModel.VoiceFilePath = voicePath;
    voiceModel.VoiceLength = [NSString stringWithFormat:@"%d",(int)durationTime];
    NSURL *voicePathUrl = [NSURL URLWithString:voicePath];
    NSString *voiceDataStr = [voiceModel mj_JSONString];
    [[OSSClientLike sharedClient] uploadVoiceObjectAsync:voicePath withFileName:[voicePathUrl lastPathComponent] andType:voice succcessBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            chatNewModel *model = [self creatMessageModelData:voiceDataStr andType:@"Voice" messageIdString:messageIdString];
            if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
                [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                    if (!error) {
                        [self sendCMDRequestService];
                    }else{
                        self.lastTimeSendMessage = currentTime;
                        MessageModel *message = [[MessageModel alloc] initWithVoicePath:[Tools getVoicePath:voicePath] duration:durationTime messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
                        [self.messageList appendMessageWith:message];
                        [self.messageList scrollToBottomWith:YES];
                    }
                }];
            }else{
                self.lastTimeSendMessage = currentTime;
                MessageModel *message = [[MessageModel alloc] initWithVoicePath:[Tools getVoicePath:voicePath] duration:durationTime messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
                [self.messageList appendMessageWith:message];
                [self.messageList scrollToBottomWith:YES];
            }
            [self compareDate];
        });
        
    } failBLock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lastTimeSendMessage = currentTime;
            MessageModel *message = [[MessageModel alloc] initWithVoicePath:voicePath duration:durationTime messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:YES status:IMUIMessageStatusFailed];
            [_messageList appendMessageWith: message];
            [self.messageList scrollToBottomWith:YES];
        });
        
    }];
}
- (void)cancelRecordVoice {
    
}
    // Tells the delegate that IMUIInputView will switch to gallery
- (void)switchToGalleryModeWithPhotoBtn:(UIButton * _Nonnull)photoBtn {
    
}
//发送图片
- (void)didSeletedGalleryWithAssetArr:(NSArray<PHAsset *> * _Nonnull)AssetArr {
    for (PHAsset *asset in AssetArr) {
        switch (asset.mediaType) {
            case PHAssetMediaTypeImage: {
                PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
                options.synchronous  = true;
                options.networkAccessAllowed = YES;
                options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize: CGSizeMake(ScreenWidth, ScreenHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    
                    NSString *messageIdString = [[NSUUID UUID] UUIDString];
                    NSString *CurrentTime = [NSDate getCurrentTimeStr];
                    NSString *timeStr = [self isNeedShowTime:CurrentTime lastSendMessageTime:self.lastTimeSendMessage];
                    NSString *filePath = [self getPath:messageIdString];
                    UserModel *user = [UserModel new];
                    user.isOutgoing = true;
                    NSString *fileName = [NSString stringWithFormat:@"%@.png",messageIdString];
                    if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileName]]) {
                        NSData *data = UIImageJPEGRepresentation(result, 1.0);
                        if (data.bytes>0&&data) {
                           [data writeToFile:[Tools getPath:fileName] atomically:YES];
                        }
                    }
                    [[OSSClientLike sharedClient] uploadObjectAsync:result withFileName:messageIdString succcessBlock:^{
                        chatNewModel *model = [self creatMessageModelData:filePath andType:@"Image" messageIdString:messageIdString];
                        //发送消息
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
                                [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                                    if (!error) {
                                        [self sendCMDRequestService];
                                    }else{
                                        self.lastTimeSendMessage = timeStr;
                                        MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
                                        [self.messageList appendMessageWith:message];
                                        [self.messageList scrollToBottomWith:YES];
                                    }
                                }];
                            }else{
                                self.lastTimeSendMessage = timeStr;
                                MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
                                [self.messageList appendMessageWith: message];
                                [self.messageList scrollToBottomWith:YES];
                            }
                            [self compareDate];
                        });
                    }failBLock:^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.lastTimeSendMessage = timeStr;
                            MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed];
                            [_messageList appendMessageWith: message];
                            [self.messageList scrollToBottomWith:YES];
                        });
                    }];
                }];
                break;
            }
            default:
                break;
        }
    }
}
/// Tells the delegate that IMUIInputView will switch to camera mode
- (void)switchToCameraModeWithCameraBtn:(UIButton * _Nonnull)cameraBtn {
    
}
//拍照
- (void)didShootPictureWithPicture:(NSData * _Nonnull)picture {
    
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    UserModel *user = [UserModel new];
    user.isOutgoing = true;
    NSString *CurrentTime = [NSDate getCurrentTimeStr];
    NSString *timeStr = [self isNeedShowTime:CurrentTime lastSendMessageTime:self.lastTimeSendMessage];
    UIImage *imgae =[UIImage imageWithData:picture];
    NSString *fileName = [NSString stringWithFormat:@"%@.png",messageIdString];
    if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileName]]) {
        if (picture.bytes>0&&picture) {
            [picture writeToFile:[Tools getPath:fileName] atomically:YES];
        }
    }
    [[OSSClientLike sharedClient] uploadObjectAsync:imgae withFileName:messageIdString succcessBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *fileNamePath = [self getPath:messageIdString];
            chatNewModel *model = [self creatMessageModelData:fileNamePath andType:@"Image" messageIdString:messageIdString];
            //发送消息
            if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
                [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                    if (!error) {
                        [self sendCMDRequestService];
                    }else{
                        self.lastTimeSendMessage = CurrentTime;
                        MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed];
                        [_messageList appendMessageWith:message];
                        [self.messageList scrollToBottomWith:YES];
                    }
                }];
            }else{
                self.lastTimeSendMessage = CurrentTime;
                MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed];
                [_messageList appendMessageWith:message];
                [self.messageList scrollToBottomWith:YES];
            }
            [self compareDate];
        });
    } failBLock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UserModel *user = [UserModel new];
            user.isOutgoing = true;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lastTimeSendMessage = CurrentTime;
                MessageModel *message = [[MessageModel alloc] initWithImagePath:[Tools getPath:fileName] messageId:messageIdString fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed];
                [_messageList appendMessageWith:message];
                [self.messageList scrollToBottomWith:YES];
            });
        });
    }];
}
// Tells the delegate when starting record video
- (void)startRecordVideo {
    
}
// Tells the delegate when user did shoot video in camera mode
- (void)finishRecordVideoWithVideoPath:(NSString * _Nonnull)videoPath durationTime:(double)durationTime {

}

#pragma mark--文件，语音等路径
// 图片路径
- (NSString *)getPath:(NSString *)UUID {
    
    return [NSString stringWithFormat:@"https://img-emake-cn.oss-cn-shanghai.aliyuncs.com/images/%@.png", UUID];
}
//语音路径
- (NSString *)getVoicePath:(NSString *)MessageId {
    
    return [NSString stringWithFormat:@"https://voi-emake-cn.oss-cn-shanghai.aliyuncs.com/mqtt/%@",MessageId];
}
//文件路径
- (NSString *)getFilePath:(NSString *)MessageId andFileName:(NSString *)fileName{
    
    return [NSString stringWithFormat:@"https://voi-emake-cn.oss-cn-shanghai.aliyuncs.com/files/%@_%@",MessageId,fileName];
}
#pragma  mark - 消息体生成

- (chatNewModel *)creatMessageModelData:(NSString *)messageText andType:(NSString *)type messageIdString:(NSString *)MessageId{
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
//    NSString *userType = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERTYPE];
    NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERNICKNAME];
    NSString *clientId = [NSString stringWithFormat:@"user/%@",userID];
    NSString *commonNameStr = [NSString stringWithFormat:@"用户%@",[phone substringFromIndex:7]];
    NSString *ChatName = nickName.length>0?nickName:commonNameStr;
    NSInteger Catagorynum = self.isCatagory+1;//1,2
    NSNumber *catagoryState = Userdefault(CatagoryVipState);
    NSString *vipStatestr = Userdefault(VipState);
    NSString *Type;
    if (catagoryState.integerValue ==Catagorynum || catagoryState.integerValue==3) {
        Type = vipStatestr;
    }else{
        Type = @"0";
    }
//    NSString *vipState = [NSString stringWithFormat:@"%d",(CatagoryVipState.integerValue==0?0)];
    chatUserModel *userModel = [[chatUserModel alloc]initWith:[Tools getHeadImageURL] formId:userID displayName:ChatName phoneNumber:phone userType:Type clientID:clientId];
    NSDictionary *userDic = [userModel mj_keyValues];
    chatBodyModel *bodyModel = nil;
    if ([type isEqualToString:@"Image"]) {
        bodyModel = [[chatBodyModel alloc]initWithImage:messageText Type:type];
    }else if ([type isEqualToString:@"Text"]){
        bodyModel = [[chatBodyModel alloc]initWithText:messageText Type:type];
    }else if ([type isEqualToString:@"Goods"]){
        bodyModel = [[chatBodyModel alloc]initWithText:messageText Type:type];
    } else if ([type isEqualToString:@"Order"]){
        bodyModel = [[chatBodyModel alloc]initWithText:messageText Type:type];
    }else if ([type isEqualToString:@"Voice"]){
        YHChatVoiceModel *model = [YHChatVoiceModel mj_objectWithKeyValues:messageText] ;
        NSURL *voiceUrl = [NSURL URLWithString:model.VoiceFilePath];
        NSString *voiceLastComponent = [voiceUrl lastPathComponent];
        NSString *fileNamePath = [NSString stringWithFormat:@"https://voi-emake-cn.oss-cn-shanghai.aliyuncs.com/mqtt/%@",voiceLastComponent];
        bodyModel = [[chatBodyModel alloc]initWithVoicePath:fileNamePath voiceDuration:model.VoiceLength Type:@"Voice"];
    }else if ([type isEqualToString:@"MutilePart"]){
        YHChatContractModel *chatModel = [YHChatContractModel mj_objectWithKeyValues:messageText];
        bodyModel = [[chatBodyModel alloc]initWithImage:chatModel.Image Text:chatModel.Text ImageUrl:chatModel.Image Url:chatModel.Url Type:type ContractType:chatModel.ContractType Contract:chatModel.ContractNo ContractState:chatModel.ContractType IsIncludeTax:chatModel.IsIncludeTax];
    }else if ([type isEqualToString:@"File"]){
        
        YHFileModel *fileModel = [YHFileModel mj_objectWithKeyValues:messageText];
        NSString *filePath = [NSString stringWithFormat:@"https://voi-emake-cn.oss-cn-shanghai.aliyuncs.com/files/%@_%@",MessageId, fileModel.FileName];
        bodyModel = [[chatBodyModel alloc]  initWithText:messageText FilePath:filePath Type:@"File"];
    }
    NSDictionary *bodyDic = [bodyModel mj_keyValues];
    chatNewModel *model = [[chatNewModel alloc]initWithId:self.MQTTTopic messageType:@"Message" messageId:MessageId user:userDic andMessageBody:bodyDic];
    return model;
}
- (void)addToFMDB:(NSString *)messageText messageId:(NSString *)messageId sender:(NSString *)sender sendTime:(NSString *)sendTime msgType:(NSString *)sendType staffName:(NSString *)staffName staffAvata:(NSString *)staffAvata andListID:(NSString *)listID clientID:(NSString *)clientId storeInfo:(NSString *)storeInfo{
    
    messageText = messageText.length ==0?@"":messageText;
    NSDictionary *dic =@{@"msg":messageText,@"msgID":messageId,@"sender":sender,@"sendTime":sendTime,@"msgType":sendType,@"staffName":staffName,@"staffAvata":staffAvata,@"Group":storeInfo};
    SDChatMessage *msg = [SDChatMessage chatMessageWithDic:dic];
    //添加聊天数据
    if (![[FMDBManager sharedManager] messageIsAlreadyExist:messageId withListID:listID]) {
        [[FMDBManager sharedManager] addMessage:msg withListID:listID];
    }
    //添加聊天列表
    if ([self.listID isEqualToString:listID]) {
        if ([self.listID containsString:@"_"]) {
            YHGroupModel *model = [[YHGroupModel alloc] init];
            model.GroupName = self.storeName;
            model.GroupPhoto = self.storeAvata;
            msg.Group = [model mj_JSONString];
            [[FMDBManager sharedManager] deleteUserListWithListID:listID];
            [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:0];
        }else{
            [[FMDBManager sharedManager] deleteUserListWithListID:listID];
            [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:0];
        }
    }else{
        if ([[FMDBManager sharedManager] isChatListAllreadyExistWith:listID]) {
            NSString *jsonStr = [[FMDBManager sharedManager] getStoreInfoFromUserList:listID];
            if (jsonStr.length > 0) { 
                msg.Group = jsonStr;
                [[FMDBManager sharedManager] deleteUserListWithListID:listID];
                [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:0];
            }else{
                [[FMDBManager sharedManager] deleteUserListWithListID:listID];
                [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:0];
            }
        }else{
            [[FMDBManager sharedManager] deleteUserListWithListID:listID];
            [[FMDBManager sharedManager] addUserList:msg withListId:listID andMessageCount:0];
        }
    }
}
- (void)addToAddtionalFMDB:(NSString *)messageText messageId:(NSString *)messageId sender:(NSString *)sender sendTime:(NSString *)sendTime msgType:(NSString *)sendType staffName:(NSString *)staffName staffAvata:(NSString *)staffAvata andListID:(NSString *)listID{
    messageText = messageText.length ==0?@"":messageText;
    NSDictionary *dic =@{@"msg":messageText,@"msgID":messageId,@"sender":sender,@"sendTime":sendTime,@"msgType":sendType,@"staffName":staffName,@"staffAvata":staffAvata};
    SDChatMessage *msg = [SDChatMessage chatMessageWithDic:dic];
    //添加附加消息聊天数据
    if ([[FMDBManager sharedManager] isChatAdditionalDataExistWith:listID]){
        [[FMDBManager sharedManager] addAditionalMessage:msg withRecoedMessageID:[NSString stringWithFormat:@"%ld",(long)self.messageMaxCount] withListID:listID];
    }else{
        [[FMDBManager sharedManager] initAdditionalMessageDataBaseWithUserId:listID];
        [[FMDBManager sharedManager] addAditionalMessage:msg withRecoedMessageID:[NSString stringWithFormat:@"%ld",(long)self.messageMaxCount] withListID:listID];
    }
}
#pragma mark========YHMQTTClientDelegate
- (void)onMessgae:(NSData *)messgae andTopic:(NSString *)topic{
    NSString *listID = @"";
    NSArray *topicArray = [topic componentsSeparatedByString:@"/"];
    if (topicArray.count == 2) {
        listID = topicArray[1];
    }else if (topicArray.count == 3) {
        listID = [NSString stringWithFormat:@"%@_%@",topicArray[1],topicArray[2]];
    }
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:messgae options:NSJSONReadingMutableLeaves error:nil];
    if (payload) {
        NSString *userId =  [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        chatNewModel *model = [chatNewModel mj_objectWithKeyValues:payload];
        chatBodyModel *body = [chatBodyModel mj_objectWithKeyValues:model.MessageBody];
        chatUserModel *form = [chatUserModel mj_objectWithKeyValues:model.From];
        //保证消息最大值
        if (self.messageMaxCount <= [model.MessageID integerValue]) {
            self.messageMaxCount = [model.MessageID integerValue];
        }
        NSString *CurrentTime = model.Timestamp;
        NSString *timeString = [self isNeedShowTime:CurrentTime lastSendMessageTime:self.lastTimeSendMessage];
        self.lastTimeSendMessage = CurrentTime;
        if ([self.messageList.chatDataManager.allMsgidArr containsObject:model.MessageID]) {
            return;
        }
        if (form.Group.length<=0 || !form.Group) {
            form.Group = @"";
        }
        if ([body.Type isEqualToString:@"Text"]){
            UserModel *user = [UserModel new];
            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:body.Text messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_TEXT" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;
                [self addToFMDB:body.Text messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_TEXT" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithText:body.Text messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess];
                [self.messageList addMessageOrderWith:message];
            }
        }else if ([body.Type isEqualToString:@"Image"]){

            UserModel *user = [UserModel new];
            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:body.Image messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_IMAGE" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;

                [self addToFMDB:body.Image messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_IMAGE" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithImagePath:body.Image messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess];
                [self.messageList addMessageOrderWith: message];
            }
        }else if ([body.Type isEqualToString:@"MutilePart"]){
            UserModel *user = [UserModel new];
            user.displayName = form.DisplayName;

            YHChatContractModel *modelContract = [[YHChatContractModel alloc] init];
            modelContract.Text = body.Text;
            modelContract.Image = body.Image;
            modelContract.Url = body.Url;
            modelContract.ContractType = body.ContractType;
            modelContract.ContractNo = body.Contract;
            modelContract.IsIncludeTax = body.IsIncludeTax;
            modelContract.ContractState = body.ContractState;

            self.contractType = body.ContractType;
            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:[modelContract mj_JSONString] messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_MutilePart" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;

                [self addToFMDB:[modelContract mj_JSONString] messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_MutilePart" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithText:[modelContract mj_JSONString] IsIncludeTax:body.IsIncludeTax ContractNo:body.Contract ContractState:body.ContractState ContractImagePath:body.ImageUrl ContractURL:body.Url messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess ];
                [self.messageList addMessageOrderWith: message];
            }
        }else if ([body.Type isEqualToString:@"Order"]){
            if ([self.listID isEqualToString:listID]) {
                MessageEventModel *eventModel = [[MessageEventModel alloc]initWithMsgId:model.MessageID eventText:body.Text];
                [self.messageList addMessageOrderWith: eventModel];
            }
            [self addToFMDB:body.Text messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_Order" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
        }else if ([body.Type isEqualToString:@"Goods"]){
            
            UserModel *user = [UserModel new];
            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:body.Text messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_Goods" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;

                [self addToFMDB:body.Text messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_Goods" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithProductJsonText:body.Text messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess];
                [self.messageList addMessageOrderWith:message];
            }
        }else if ([body.Type isEqualToString:@"Voice"]){
            UserModel *user = [UserModel new];
            YHChatVoiceModel *voiceModel = [[YHChatVoiceModel alloc] init];
            voiceModel.VoiceFilePath = body.Voice;
            voiceModel.VoiceLength = body.VoiceDuration;
            NSString *voiceDataStr = [voiceModel mj_JSONString];
            NSURL *voiceUrl = [NSURL URLWithString:body.Voice];
            NSString *voiceLastComponent = [voiceUrl lastPathComponent];
            if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getVoicePath:voiceLastComponent]]) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:body.Voice]];
                if (data.bytes>0&&data) {
                    [data writeToFile:[Tools getVoicePath:voiceLastComponent] atomically:YES];
                }
            }
            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:voiceDataStr messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_Voice" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;
                [self addToFMDB:voiceDataStr messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_Voice" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithVoicePath:[Tools getVoicePath:voiceLastComponent] duration:body.VoiceDuration.integerValue messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess];
                [_messageList addMessageOrderWith: message];
            }
        }else if ([body.Type isEqualToString:@"File"]){
            YHFileModel *modelFile = [YHFileModel mj_objectWithKeyValues:body.Text];
            modelFile.FilePath = body.Url;
            UserModel *user = [UserModel new];

            if ([form.UserId isEqualToString:userId]) {
                user.isOutgoing = true;
                [self addToFMDB:body.Text messageId:model.MessageID sender:@"1" sendTime:model.Timestamp msgType:@"SEND_File" staffName:@"" staffAvata:@"" andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }else{
                user.serversAvata = form.Avatar;
                user.isOutgoing = false;
                user.displayName = form.DisplayName;

                [self addToFMDB:body.Text messageId:model.MessageID sender:@"0" sendTime:model.Timestamp msgType:@"SEND_File" staffName:form.DisplayName staffAvata:form.Avatar andListID:listID clientID:form.ClientID storeInfo:form.Group];
            }
            if ([self.listID isEqualToString:listID]) {
                MessageModel *message = [[MessageModel alloc] initWithFileText:[modelFile mj_JSONString] messageId:model.MessageID fromUser:user timeString:timeString isOutgoing:user.isOutgoing status:IMUIMessageStatusSuccess];
                [_messageList addMessageOrderWith: message];
            }
        }
        if (([model.MessageID integerValue] < self.messageMaxCount) && (self.page !=1)) {
            return;
        }
        [self.messageList scrollToBottomWith:YES];
    }
}
- (void)onCommand:(NSData *)message andTopic:(NSString *)topic{
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:message options:NSJSONReadingMutableLeaves error:nil];
    MQTTCommandModel *model = [MQTTCommandModel mj_objectWithKeyValues:payload];
    model.isCatagory = self.isCatagory;
    if ([model.cmd isEqualToString:@"UserMessageList"]) {
        if (self.page <=1) {
            self.messageMaxCount = model.message_id_last;
        }
        self.page = 0;
        [self.messageList.messageCollectionView.mj_header beginRefreshing];
    }else if ([model.cmd isEqualToString:@"CustomerAcceptService"]){
        NSArray *array = [model.customer_id componentsSeparatedByString:@"/"];
     BOOL isRightMessage =   [payload.allKeys containsObject:@"topic"];//yes 正常的消息
        if (array.count==2) {
            if (isRightMessage==YES) {
                NSString *customer = [NSString stringWithFormat:@"客服：%@为你服务",array[1]];
                [self displayMessageTipsEvent:customer];
            }
           
        }else if (array.count==3) {
            if (isRightMessage==YES) {

            NSString *customer = [NSString stringWithFormat:@"客服：%@为你服务",array[2]];
            [self displayMessageTipsEvent:customer];
            }
        }
        if ([self.listID containsString:@"_"]) {
            NSString *serverList = [[FMDBManager sharedManager] getServerListWithStoreID:self.storeID];
            NSArray *customer_ids = [serverList mj_JSONObject];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers addObject:model.customer_id];
//            if (serverList.length == 0) {
//                [[FMDBManager sharedManager] addServerListMessage:[customers mj_JSONString] withStoreId:self.storeID];
//            }else{
            if (isRightMessage==YES) {
//
            [[FMDBManager sharedManager] updateServerList:[customers mj_JSONString] withStoreId:self.storeID];
            }
//            }
        }else{
            NSArray *customer_ids = [[NSUserDefaults standardUserDefaults] objectForKey:USERREQUESTSERVER];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers addObject:model.customer_id];
            [[NSUserDefaults standardUserDefaults] setObject:customers forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }else if ([model.cmd isEqualToString:@"CustomerClosedService"]){
        if ([self.listID containsString:@"_"]) {
            NSString *serverList = [[FMDBManager sharedManager] getServerListWithStoreID:self.storeID];
            NSArray *customer_ids = [serverList mj_JSONObject];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers removeObject:model.customer_id];
            [[FMDBManager sharedManager] updateServerList:[customers mj_JSONString] withStoreId:self.storeID];
        }else{
            NSArray *customer_ids = [[NSUserDefaults standardUserDefaults] objectForKey:USERREQUESTSERVER];
            NSMutableArray *customers = [NSMutableArray arrayWithArray:customer_ids];
            [customers removeObject:model.customer_id ];
            [[NSUserDefaults standardUserDefaults] setObject:customers forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        NSArray *array = [model.customer_id componentsSeparatedByString:@"/"];
        if (array.count>1) {
            NSString *customer = [NSString stringWithFormat:@"客服：%@已离开",array.lastObject];
            [self displayMessageTipsEvent:customer];
        }
    }else if ([model.cmd isEqualToString:@"ChatroomCustomerList"]){
        if ([self.listID containsString:@"_"]) {
            if ([[FMDBManager sharedManager] serverLisIsAlreadyExist:self.storeID]) {
                [[FMDBManager sharedManager] updateServerList:[model.customer_ids mj_JSONString] withStoreId:self.storeID];
            }else{
                [[FMDBManager sharedManager] addServerListMessage:[model.customer_ids mj_JSONString] withStoreId:self.storeID];
            }
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:model.customer_ids forKey:USERREQUESTSERVER];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}
#pragma mark ====IMUIMessageMessageCollectionViewDelegate
- (UICollectionViewCell *)messageCollectionViewWithMessageCollectionView:(UICollectionView *)messageCollectionView forItemAt:(NSIndexPath *)forItemAt messageModel:(id<IMUIMessageProtocol>)messageModel{
    
    if ([messageModel isKindOfClass: [MessageEventModel class]]) {
        MessageEventCollectionViewCell *cell = [messageCollectionView dequeueReusableCellWithReuseIdentifier:[[MessageEventCollectionViewCell class] description] forIndexPath:forItemAt];
        cell.delegate = self;
        MessageEventModel *eventModel = (MessageEventModel *)messageModel;
        cell.model = eventModel;
        NSDictionary *resultDic = [eventModel.evenText mj_JSONObject];
        YHChatOrderContract *contract = [YHChatOrderContract mj_objectWithKeyValues:resultDic];
      
        [cell setData:contract];
        return cell;
    }else if ([messageModel isKindOfClass: [MessageClassifyEventModel class]]){
        YHMessageClassifyCollectionViewCell *cell = [messageCollectionView dequeueReusableCellWithReuseIdentifier:[[YHMessageClassifyCollectionViewCell class] description] forIndexPath:forItemAt];
        MessageClassifyEventModel *eventModel = (MessageClassifyEventModel *)messageModel;
        cell.delegate = self;
        cell.model = eventModel;
        [cell setData:eventModel.evenText];
        return cell;
    }else if ([messageModel isKindOfClass: [MessageEventTipsModel class]]){
        MesssageEventTipsCollectionViewCell *cell = [messageCollectionView dequeueReusableCellWithReuseIdentifier:[[MesssageEventTipsCollectionViewCell class] description] forIndexPath:forItemAt];
        MessageClassifyEventModel *eventModel = (MessageClassifyEventModel *)messageModel;
        [cell presentTips:eventModel.evenText];
        return cell;
    }else{
        return nil;
    }
}
//高度
- (NSNumber * _Nullable)messageCollectionViewWithMessageCollectionView:(UICollectionView * _Nonnull)messageCollectionView heightForItemAtIndexPath:(NSIndexPath * _Nonnull)forItemAt messageModel:(id <IMUIMessageProtocol> _Nonnull)messageModel SWIFT_WARN_UNUSED_RESULT {
    if ([messageModel isKindOfClass: [MessageEventModel class]]) {
        NSNumber *number = [NSNumber numberWithFloat:HeightRate(200)];
        return number;
    }else if ([messageModel isKindOfClass: [MessageClassifyEventModel class]]) {
        MessageClassifyEventModel *eventModel = (MessageClassifyEventModel *)messageModel;
        NSArray *array = [YHCustomQuestionModel mj_objectArrayWithKeyValuesArray:eventModel.evenText];
        NSMutableArray *claasifyArray = [NSMutableArray arrayWithCapacity:0];
        for (YHCustomQuestionModel *model in array) {
            if (![claasifyArray containsObject:model.AdviceName]) {
                [claasifyArray addObject:model.AdviceName];
            }
        }
        CGFloat height = HeightRate(30) * array.count + HeightRate(30) * claasifyArray.count + HeightRate(107) + HeightRate(30);
        NSNumber *number = [NSNumber numberWithFloat:height];
        return number;
    }else if ([messageModel isKindOfClass: [MessageEventTipsModel class]]) {
        MessageEventTipsModel *tipModel = (MessageEventTipsModel *)messageModel;
        CGSize size = [tipModel.evenText sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(WidthRate(350),10000.0f)lineBreakMode:UILineBreakModeWordWrap];
        NSNumber *number;
        if (size.height>40) {
            number = [NSNumber numberWithFloat:HeightRate(60)];
        }else{
            number = [NSNumber numberWithFloat:HeightRate(40)];
        }
        return number;
    }else{
        return nil;
    }
}
//点击
- (void)messageCollectionViewWithDidTapMessageBubbleInCell:(UICollectionViewCell * _Nonnull)didTapMessageBubbleInCell model:(id <IMUIMessageProtocol> _Nonnull)model{
    if ([model isKindOfClass: [MessageEventModel class]]) {
        
    }else if ([model isKindOfClass: [MessageClassifyEventModel class]]){
        
    }else if ([model isKindOfClass: [MessageEventTipsModel class]]){
    
    }else{
        MessageModel *modelPaste = (MessageModel *)model;
        if ([modelPaste.type isEqualToString:@"Image"]) {
            NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
            [browseItemArray addObject:modelPaste.mediaFilePath];
            SKFPreViewNavController *imagePickerVc =[[SKFPreViewNavController alloc]initWithSelectedPhotoURLs:browseItemArray index:0];
            imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
        }else if([modelPaste.type isEqualToString:@"Contract"]){
            MessageModel *msg =  (MessageModel *)model;
            
            if (msg.isOutGoing == 0) {//判断当前的合同是自己接收0 还是发送（0 自己发送的合同不跳转页面）
                YHChatContractModel *chatContractModel = [YHChatContractModel mj_objectWithKeyValues:msg.text];
                self.contractType = chatContractModel.ContractType;
              YHContractCreatViewController *vc = [[YHContractCreatViewController alloc]init];
              vc.ContractURL =  chatContractModel.Url;
              vc.ContractType = chatContractModel.ContractType;
              vc.IsIncludeTax = chatContractModel.IsIncludeTax;
              vc.ContractState = chatContractModel.ContractState;
              vc.contractNo = chatContractModel.ContractNo;
              vc.sendDataStr = msg.text;
              vc.contractDataBlock = ^(NSString *contractUrl){
                if (contractUrl){
                    NSString *messageIdString = [[NSUUID UUID] UUIDString];
                    chatNewModel *model =[self creatMessageModelData:contractUrl andType:@"MutilePart" messageIdString:messageIdString];
                    UserModel *user = [UserModel new];
                    user.isOutgoing = false;
                    NSString *currentTime = [NSDate getCurrentTimeStr];
                    NSString *timeStr = [self isNeedShowTime:currentTime lastSendMessageTime:self.lastTimeSendMessage];
                    if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
                        [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                            if (!error) {
                                [self sendCMDRequestService];
                            }else{
                                self.lastTimeSendMessage = currentTime;
                                MessageModel *message = [[MessageModel alloc] initWithText:msg.text IsIncludeTax:chatContractModel.IsIncludeTax ContractNo:chatContractModel.ContractNo ContractState:chatContractModel.ContractState ContractImagePath:chatContractModel.Url ContractURL:chatContractModel.Url messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed ];
                                [self.messageList appendMessageWith: message];
                                [self.messageList scrollToBottomWith:YES];
                            }
                        }];
                    }else{
                        self.lastTimeSendMessage = currentTime;
                        MessageModel *message = [[MessageModel alloc] initWithText:msg.text IsIncludeTax:chatContractModel.IsIncludeTax ContractNo:chatContractModel.ContractNo ContractState:chatContractModel.ContractState ContractImagePath:chatContractModel.Url ContractURL:chatContractModel.Url messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:true status:IMUIMessageStatusFailed ];
                        [self.messageList appendMessageWith: message];
                        [self.messageList scrollToBottomWith:YES];
                    }
                }
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
    }else if([modelPaste.type isEqualToString:@"Product"]){
        
        MessageModel *msg =  (MessageModel *)model;
        NSDictionary *resultDic = [msg.text mj_JSONObject];
        YHGoodsModel *model = [YHGoodsModel mj_objectWithKeyValues:resultDic];
        YHCommonWebViewController *detaiVC = [[YHCommonWebViewController alloc] init];
        detaiVC.URLString = model.GoodsDetailUrl;
        detaiVC.titleName = @"商品详情";
        detaiVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detaiVC animated:YES];
    }else if([modelPaste.type isEqualToString:@"File"]){
        YHFileOptionViewController *vc = [[YHFileOptionViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.fileModel = [YHFileModel mj_objectWithKeyValues:modelPaste.text];
        [self.navigationController pushViewController:vc animated:YES];
    }
  }
}
//长按
- (void)messageCollectionViewWithBeganLongTapMessageBubbleInCell:(UICollectionViewCell * _Nonnull)beganLongTapMessageBubbleInCell model:(id <IMUIMessageProtocol> _Nonnull)model{
    [self becomeFirstResponder];
    IMUIBaseMessageCell *cellPaste = (IMUIBaseMessageCell *)beganLongTapMessageBubbleInCell;
    MessageModel *modelPaste = (MessageModel *)model;
    if ([modelPaste.type isEqualToString:@"Text"]) {
        self.pasteText = modelPaste.text;
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyBtnPressed:)];
        menuController.menuItems = @[copyItem];
        [menuController setTargetRect:cellPaste.bubbleView.frame inView:cellPaste.bubbleView.superview];
        [menuController setMenuVisible:YES animated:YES];
        [UIMenuController sharedMenuController].menuItems=nil;
    }
}
//订单消息点击
- (void)didTapMessageBubbleWithModel:(MessageEventModel *)model{
    NSDictionary *resultDic = [model.evenText mj_JSONObject];
    YHOrderContract *contract = [YHOrderContract mj_objectWithKeyValues:resultDic];
    
    if (contract.ContractNo.length == 0) {
        [self.view makeToast:@"订单信息数据异常" duration:1.5 position:CSToastPositionCenter];
        return;
    }
    BOOL isInduty = !Userdefault(IsIndustryCatagory);
    YHChatConfirmOrderViewController *vc = [[YHChatConfirmOrderViewController alloc]init];
    
    vc.contractNo = contract.ContractNo;
    vc.IsStore = [NSString stringWithFormat:@"%d",isInduty];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
//咨询分类消息点击
- (void)didTapMessageTableWith:(YHCustomQuestionModel *)model{
    NSString *messageIdString = [[NSUUID UUID] UUIDString];
    UserModel *user = [UserModel new];
    user.serversAvata = @"";
    user.displayName =  @"";
    user.isOutgoing = false;
    
    NSString *CurrentTime = [NSDate getCurrentTime];
    NSString *textMeaasge = [NSString stringWithFormat:@"%@\n%@",model.QuestionTitle,model.QuestionContent];
    MessageModel *message = [[MessageModel alloc] initWithText:textMeaasge messageId:messageIdString fromUser:user timeString:CurrentTime isOutgoing:0 status:IMUIMessageStatusSuccess];
    [self.messageList appendMessageWith:message];
    //附加消息
    [self addToAddtionalFMDB:textMeaasge messageId:messageIdString sender:@"0" sendTime:CurrentTime msgType:@"SEND_TEXT" staffName:@"" staffAvata:@"" andListID:self.listID];
    [self.messageList scrollToBottomWith:YES];
}
/*
 长按复制内容
 */
-(void)menuCopyBtnPressed:(UIMenuItem *)menuItem{
    [UIPasteboard generalPasteboard].string = self.pasteText;
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(menuCopyBtnPressed:)) {
        return YES;
    }
    return NO;
}
//选择产品
- (void)didSelectProduct{
    if(self.jsonStr.length>0 && self.isPostOrderDetail==YES) {
        NSString *messageIdString = [[NSUUID UUID] UUIDString];
        UserModel *user = [UserModel new];
        user.isOutgoing = true;
        NSString *currentTime = [NSDate getCurrentTimeStr];
        NSString *timeStr = [self isNeedShowTime:currentTime lastSendMessageTime:self.lastTimeSendMessage];
        chatNewModel *model = [self creatMessageModelData:self.jsonStr andType:@"Goods" messageIdString:messageIdString];
        if ([[YHMQTTClient sharedClient] isMQTTConnect]) {
            [[YHMQTTClient sharedClient] sendMessage:[model mj_keyValues] withTopic:self.MQTTTopic complete:^(NSError *error) {
                if (!error) {
                    [self sendCMDRequestService];
                }else{
                    self.lastTimeSendMessage = currentTime;
                    MessageModel *message = [[MessageModel alloc] initWithProductJsonText:self.jsonStr messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
                    [self.messageList addMessageOrderWith:message];
                    [self.messageList scrollToBottomWith:YES];
                }
            }];
        }else{
            self.lastTimeSendMessage = currentTime;
            MessageModel *message = [[MessageModel alloc] initWithProductJsonText:self.jsonStr messageId:model.MessageID fromUser:user timeString:timeStr isOutgoing:user.isOutgoing status:IMUIMessageStatusFailed];
            [self.messageList addMessageOrderWith:message];
            [self.messageList scrollToBottomWith:YES];
        }
        [self compareDate];
    };
}
@end