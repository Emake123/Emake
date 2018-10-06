//
//  JZUserNotification.h
//  JZNotic
//
//  Created by Jozo.Chan on 16/11/2.
//  Copyright © 2016年 i.Jozo. All rights reserved.
//

//
//  UserNotification.h
//  UserNotification
//
//  Created by 谷伟 on 2017/11/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

typedef NS_ENUM(NSUInteger, AttachmentType) {
    //图片推送
    AttachmentTypeImage,
    //GIF推送
    AttachmentTypeImageGif,
    //音频推送
    AttachmentTypeAudio,
    //视频推送
    AttachmentTypeMovie
};


@interface JZUserNotification : NSObject

#pragma mark - 自定义信息动作
+ (void)addNotificationAction;
+ (void)addNotificationAction2;

//单例
MInterfaceSharedInstance(sharedNotification)

//注册通知
- (void)registerNotification;

#pragma mark - Add Local Notification

//时间间隔触发
- (void)addNotificationWithTimeIntervalTrigger;
//日期触发
- (void)addNotificationWithCalendarTrigger;
//地理位置出发
- (void)addNotificationWithLocationTrigger;

#pragma mark - Categories

- (void)setCategories;

- (void)addNotificationWithCategroy1:(NSString *)eventText;

- (void)addNotificationWithCategroy2:(NSString *)eventText;

- (void)addNotificationWithCategroy3;

#pragma mark - Add Remote Notification

- (void)addRemoteNotification;

- (void)addRemoteNotificationDownload;

- (void)addRemoteNotificationSilentDownload;

- (void)addRemoteNotificationCategory1;

- (void)addRemoteNotificationCategory2;

- (void)addRemoteNotificationCategory3;

#pragma mark - 附件
- (void)addNotificationWithUserDefined1;
- (void)addNotificationWithUserDefined2;
- (void)addNotificationWithAttachmentType:(AttachmentType)type;

#pragma mark - AppDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

@end

