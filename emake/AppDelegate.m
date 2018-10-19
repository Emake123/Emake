//
//  AppDelegate.m
//  emake
//
//  Created by chenyi on 2017/7/11.
//  Copyright © 2017年 emake. All rights reserved.
//
#import "AppDelegate.h"
#import "YHLoginViewController.h"
#import "YHTabBarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <CloudPushSDK/CloudPushSDK.h>
#import <UserNotifications/UserNotifications.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "YHMQTTClient.h"
#import <UMMobClick/MobClick.h>
#import "YHCertificationStateOriginalViewController.h"
#import "YHCertificationStateViewController.h"
#import "YHOrderManageNewViewController.h"
#import "YHShoppingCartNewViewController.h"
#import "ChatNewViewController.h"
#import "YHSendFileTipsView.h"
#import "YHGuidePageViewController.h"
#import <Bugly/Bugly.h>
#import "FMDBManager.h"
#import "YHSendMessageToStoreListViewController.h"
#import "YHMainMessageCenterViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "YHSuperGroupDetailViewController.h"
#import "YHPayViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate,YHSendFileTipsViewDelegete,UNUserNotificationCenterDelegate,WXApiDelegate>{
    // iOS 10通知中心
    UNUserNotificationCenter *_notificationCenter;
    NSTimer *_timer;
    int count;
    __block UIBackgroundTaskIdentifier _backIden;
}
@end

@implementation AppDelegate

static NSUserDefaults * _Nonnull extracted() {
    return [NSUserDefaults standardUserDefaults];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //获取首页云工厂的ids
    [self getcatagoryID];
 
    //注册通知
    [[JZUserNotification sharedNotification] registerNotification];
    
    //监测网络连接状态
    [[YHAFNetWorkingRequset sharedRequset] monitorNetworkStatus];
    
    //shareSDK 和 第三方登录
    [self registerShareSDK];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:TitleIndex];

    //友盟统计
    UMConfigInstance.appKey = UMMobClikAPPKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:YES];
    
    //Bugly
    [Bugly startWithAppId:EmakeAppleID];
    

    
    /*----------   阿里Push  -----------*/
    // APNs注册，获取deviceToken并上报
    [self registerAPNS:application];
    // 初始化SDK
    [self initALIPushSDK];
    // 监听推送通道打开动作
    [self listenerOnChannelOpened];
    // 监听推送消息到达
    [self registerMessageReceive];
    [CloudPushSDK sendNotificationAck:launchOptions];
    
    //MQTT
    if ([extracted() objectForKey:LOGIN_USERID]) {
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USERID];
        [[YHMQTTClient sharedClient] connectToHost:MQTT_IP Port:MQTT_PORT withUserID:userId];
        [[FMDBManager sharedManager] initMessageDataBaseWithUserId:userId];
        [[FMDBManager sharedManager] initAdditionalMessageDataBaseWithUserId:userId];
        [[FMDBManager sharedManager] initMessageListDataBaseWithUserId:userId];
        [[FMDBManager sharedManager] initServerListListDataBaseWithUserID:userId];
    }

    //注册通知 阿里云消息推送
    [[JZUserNotification sharedNotification] registerNotification];
    
    
    /*----------  分割线  -----------*/
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:ISFRISTLOGIN]) {
        YHGuidePageViewController *vc = [[YHGuidePageViewController alloc]init];
        vc.block = ^{
            YHTabBarViewController *tab = [[YHTabBarViewController alloc] init];
            tab.delegate = self;
            self.window.rootViewController = tab;
        };
        self.window.rootViewController = vc;
    }else{
        YHTabBarViewController *tab = [[YHTabBarViewController alloc] init];
        tab.delegate = self;
        self.window.rootViewController = tab;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)getcatagoryID
{
    [[YHJsonRequest shared] getCatagoryIDsSuccessBlock:^(NSArray *success) {
        
        [[NSUserDefaults standardUserDefaults] setObject:success forKey:CatagoryIDs];
        
    } fialureBlock:^(NSString *errorMessages) {
        
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self beginTask];
    count =0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(go:) userInfo:nil repeats:YES];
  
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.applicationDidEnterBackground
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
    if([CLOUD_URL(@"") containsString:@"mallapi.emake.cn"]){
        [self getAppVersion];
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:HidenCatagoryVip];//is_payment 是否展示付款信息 0 不展示 1 展示

    }
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// 禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskPortrait;
    
}
//scheme打开APP调用
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"appde==host=%@",url.host);

    if ([url.host isEqualToString:@"pay"]) {
        UIViewController *vc = [Tools currentViewController];
        return [WXApi handleOpenURL:url delegate:vc];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSInteger successState = 0;
            //8000 正在处理中 4000  订单支付失败 6001 用户中途取消/重复操作取消 6002  网络连接出错
            
            if([resultStatus isEqualToString:@"6001"])
            {
                successState =1;
                
            }else//取消
            {
                
                successState = [resultStatus isEqualToString:@"9000"]==YES?2:0;
                [self payState:successState];
                
            }
        }];
        return YES;

    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSInteger successState = 0;
            //8000 正在处理中 4000  订单支付失败 6001 用户中途取消/重复操作取消 6002  网络连接出错
            
            if([resultStatus isEqualToString:@"6001"])
            {
                successState =1;
                
            }else//取消
            {
                
                successState = [resultStatus isEqualToString:@"9000"]==YES?2:0;
                [self payState:successState];
                
            }
        }];
        return YES;

    }
    if ([url.absoluteString containsString:@"emakeNice"]) {
        NSArray * array = [url.absoluteString componentsSeparatedByString:@"?"];
        if (array[0]) {
            NSArray * items = [array[1] componentsSeparatedByString:@"="];
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.phoneNumberFromWeb = url.absoluteString;
            [[NSUserDefaults standardUserDefaults] setObject:items[1] forKey:LOGIN_MOBILEPHONE];
            self.window.rootViewController = loginViewController;
        }
        return YES;
    }
    if (self.window) {
        if (url) {
          NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        
            if ( phone.length <= 0) {
                    YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
                    loginViewController.navigationController.navigationBarHidden = YES;
                    loginViewController.hidesBottomBarWhenPushed =YES;
                    [[Tools currentNavigationController] pushViewController:loginViewController animated:YES];

            }else{
                NSString *messageIdString = [[NSUUID UUID] UUIDString];
                NSString *fileNameStr = [url lastPathComponent];
                NSString *fileNameTotal = [NSString stringWithFormat:@"%@_%@",messageIdString,fileNameStr];
                if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileNameTotal]]) {
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    if (data.bytes>0&&data) {
                        BOOL isSuccess = [data writeToFile:[Tools getPath:fileNameTotal] atomically:YES];
                        if (isSuccess) {
                            NSLog(@"写入成功");
                        }else{
                            NSLog(@"写入失败");
                        }
                    }
                }
                
                if (fileNameStr.length > 0) {
                    YHSendMessageToStoreListViewController *list = [[YHSendMessageToStoreListViewController alloc] init];
                    list.fileNameStr = fileNameStr;
                    list.urlStr = url.absoluteString;
                    list.hidesBottomBarWhenPushed = YES;
                    [[Tools currentNavigationController] pushViewController:list animated:YES];
                }
            }
        }
    }
    return YES;
}
// NOTE:9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    NSLog(@"appde==host=%@",url.host);
    UIViewController *vc = [Tools currentViewController];
    if ([url.host isEqualToString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:vc];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSInteger successState = 0;
            //8000 正在处理中 4000  订单支付失败 6001 用户中途取消/重复操作取消 6002  网络连接出错
            
            if([resultStatus isEqualToString:@"6001"])
            {
                successState =1;
                
            }else//取消
            {
                
                successState = [resultStatus isEqualToString:@"9000"]==YES?2:0;
                [self payState:successState];
                
            }
            NSLog(@"result = %@",resultDic);
        }];
        return YES;

    }
    if ([url.absoluteString containsString:@"emakeNice"]) {
        NSArray * array = [url.absoluteString componentsSeparatedByString:@"?"];
        if (array[0]) {
            NSArray * items = [array[1] componentsSeparatedByString:@"="];
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.phoneNumberFromWeb = url.absoluteString;
            [[NSUserDefaults standardUserDefaults] setObject:items[1] forKey:LOGIN_MOBILEPHONE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.window.rootViewController = loginViewController;
        }
        return YES;

    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            
            NSString *resultStatus = resultDic[@"resultStatus"];
            NSInteger successState = 0;
            //8000 正在处理中 4000  订单支付失败 6001 用户中途取消/重复操作取消 6002  网络连接出错
            
            if([resultStatus isEqualToString:@"6001"])
            {
                successState =1;
                
            }else//取消
            {
                
                successState = [resultStatus isEqualToString:@"9000"]==YES?2:0;
                [self payState:successState];
                
            }
       
            NSLog(@"result = %@",resultDic);
        }];
        return YES;

    }
    if (self.window) {
        if (url) {
            NSString *fileNameStr = [url lastPathComponent];
            NSString *  phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
      
            if ( phone.length <= 0) {
                if (fileNameStr.length>0) {
                    YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
                    loginViewController.navigationController.navigationBarHidden = YES;
                    loginViewController.hidesBottomBarWhenPushed =YES;
                    [[Tools currentNavigationController] pushViewController:loginViewController animated:YES];
                }
               
                
            }else{
                NSString *messageIdString = [[NSUUID UUID] UUIDString];
                NSString *fileNameTotal = [NSString stringWithFormat:@"%@_%@",messageIdString,fileNameStr];

                if (![[NSFileManager defaultManager] fileExistsAtPath:[Tools getPath:fileNameTotal]]) {
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    if (data.bytes>0&&data) {
                        BOOL isSuccess = [data writeToFile:[Tools getPath:fileNameTotal] atomically:YES];
                        if (isSuccess) {
                            NSLog(@"写入成功");
                        }else{
                            NSLog(@"写入失败");
                        }
                    }
                }
                if (fileNameStr.length > 0) {
//                    YHSendMessageToStoreListViewController *list = [[YHSendMessageToStoreListViewController alloc] init];
                    YHMainMessageCenterViewController *list = [[YHMainMessageCenterViewController alloc] init];

                    list.fileNameStr = fileNameStr;
                    list.urlStr = url.absoluteString;
                    list.hidesBottomBarWhenPushed = YES;
                    if ([[Tools currentNavigationController] isKindOfClass:[YHMainMessageCenterViewController class]]) {
                        
                        
                    }else
                    {
                       [[Tools currentNavigationController] pushViewController:list animated:YES];
                    }

                }
        
            }
        }
    }
    return YES;
}
#pragma mark----- ShareSDK
-(void)registerShareSDK{
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeQQ),@(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType){
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:SharedSDKQQAppId appKey:SharedSDKQQAppKey authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:SharedSDKWeiXinAppId appSecret:SharedSDKWeiXinAppKey];
                break;
            default:
                break;
        }
    }];
    
}

#pragma mark-------UITabBarControllerDelegate
//是否允许选择不同item触发后续操作，YES  允许，NO不允许
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSArray *array = tabBarController.viewControllers;
    if([array indexOfObject:viewController] == 1){
        [MobClick event:@"TodayPrice" label:@"当日售价"];
    }
    if ([array indexOfObject:viewController] == 2 ||[array indexOfObject:viewController] == 3){
        NSString * phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_MOBILEPHONE];
        if (phone.length<=0) {
            YHLoginViewController *loginViewController = [[YHLoginViewController alloc] init];
            loginViewController.navigationController.navigationBarHidden = YES;
            loginViewController.hidesBottomBarWhenPushed =YES;
            loginViewController.hidesBottomBarWhenPushed = YES;
            [[Tools currentNavigationController] pushViewController:loginViewController animated:YES];
            return NO;
        }

            //判断点击tabbar让购物车，订单类的导航的返回按钮隐藏
            if (viewController.childViewControllers.count>0) {
                UIViewController *vc = viewController.childViewControllers.firstObject;
                if([vc isKindOfClass:[YHOrderManageNewViewController class]]){
                    
                    YHOrderManageNewViewController *order = (YHOrderManageNewViewController *)vc;
                    order.isShowLeftButton = YES;
                }
                if([vc isKindOfClass:[YHShoppingCartNewViewController class]]){
                    
                    YHShoppingCartNewViewController *shop = (YHShoppingCartNewViewController *)vc;
                    shop.isShowLeftButton = NO;
                }
            }
            return true;
    }else{
        //判断点击tabbar让购物车，订单类的导航的返回按钮隐藏
        if (viewController.childViewControllers.count>0) {
            UIViewController *vc = viewController.childViewControllers.firstObject;
            if([vc isKindOfClass:[YHOrderManageNewViewController class]]){
                YHOrderManageNewViewController *order = (YHOrderManageNewViewController *)vc;
                order.isShowLeftButton = YES;
            }
            if([vc isKindOfClass:[YHShoppingCartNewViewController class]]){
                YHShoppingCartNewViewController *shop = (YHShoppingCartNewViewController *)vc;
                shop.isShowLeftButton = NO;
            }
        }
        return true;
    }
    return YES;
}


#pragma mark----- 推送
- (void)registerAPNS:(UIApplication *)application {
    float systemVersionNum = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersionNum >= 10.0) {
        // iOS 10 notifications
        _notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        // 创建category，并注册到通知中心
        [self createCustomNotificationCategory];
        _notificationCenter.delegate = self;
        // 请求推送权限
        [_notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // granted
                NSLog(@"User authored notification.");
                // 向APNs注册，获取deviceToken
                //                [application registerForRemoteNotifications];
            } else {
                // not granted
                NSLog(@"User denied notification.");
            }
        }];
    } else if (systemVersionNum >= 8.0) {
        // iOS 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [application registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
                                           categories:nil]];
        [application registerForRemoteNotifications];
#pragma clang diagnostic pop
    } else {
        // iOS < 8 Notifications
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
#pragma clang diagnostic pop
    }
}
/**
 *  主动获取设备通知是否授权(iOS 10+)
 */
- (void)getNotificationSettingStatus{
    
    [_notificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            NSLog(@"User authed.");
        } else {
            NSLog(@"User denied.");
        }
    }];
}
/*
 *  APNs注册成功回调，将返回的deviceToken上传到CloudPush服务器
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Upload deviceToken to CloudPush server.");
    //自定义通知。将deviceToken发送给后台
    [CloudPushSDK registerDevice:deviceToken withCallback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Register deviceToken success, deviceToken: %@", [CloudPushSDK getApnsDeviceToken]);
        } else {
            NSLog(@"Register deviceToken failed, error: %@", res.error);
        }
    }];
}
/*
 *  APNs注册失败回调
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}
/**
 *  创建并注册通知category(iOS 10+)
 */
- (void)createCustomNotificationCategory {
    // 自定义`action1`和`action2`
    UNNotificationAction *action1 = [UNNotificationAction actionWithIdentifier:@"action1" title:@"test1" options: UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"action2" title:@"test2" options: UNNotificationActionOptionNone];
    // 创建id为`test_category`的category，并注册两个action到category
    // UNNotificationCategoryOptionCustomDismissAction表明可以触发通知的dismiss回调
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"test_category" actions:@[action1, action2] intentIdentifiers:@[] options:
                                        UNNotificationCategoryOptionCustomDismissAction];
    // 注册category到通知中心
    [_notificationCenter setNotificationCategories:[NSSet setWithObjects:category, nil]];
}
/**
 *  处理iOS 10通知(iOS 10+)
 */
- (void)handleiOS10Notification:(UNNotification *)notification {
    UNNotificationRequest *request = notification.request;
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];//request.content;
    
    //sendNotificationAck
    content.userInfo = request.content.userInfo;
    NSDictionary *userInfo = content.userInfo;
    // 通知时间
    NSDate *noticeDate = notification.date;
    // 标题
    NSString *title = content.title;
    // 副标题
    NSString *subtitle = content.subtitle;
    // 内容
    NSString *body = content.body;
    // 角标
    int badge = [content.badge intValue];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *extras = [userInfo valueForKey:@"Extras"];
    // 通知打开回执上报
    [CloudPushSDK sendNotificationAck:userInfo];

    NSLog(@"Notification, date: %@, title: %@, subtitle: %@, body: %@, badge: %d, extras: %@.", noticeDate, title, subtitle, body, badge, extras);
}
/**
 *  App处于前台时收到通知(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"Receive a notification in foregound.");
    // 处理iOS 10通知，并上报通知打开回执
    [self handleiOS10Notification:notification];
    // 通知不弹出
//    completionHandler(UNNotificationPresentationOptionNone);
    
    // 通知弹出，且带有声音、内容和角标
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}
/**
 *  触发通知动作时回调，比如点击、删除通知和点击自定义action(iOS 10+)
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSString *userAction = response.actionIdentifier;
    // 点击通知打开
    if ([userAction isEqualToString:UNNotificationDefaultActionIdentifier]) {
        NSLog(@"User opened the notification.");
        // 处理iOS 10通知，并上报通知打开回执
        [self handleiOS10Notification:response.notification];
    }
    // 通知dismiss，category创建时传入UNNotificationCategoryOptionCustomDismissAction才可以触发
    if ([userAction isEqualToString:UNNotificationDismissActionIdentifier]) {
        NSLog(@"User dismissed the notification.");
    }
    NSString *customAction1 = @"action1";
    NSString *customAction2 = @"action2";
    // 点击用户自定义Action1
    if ([userAction isEqualToString:customAction1]) {
        NSLog(@"User custom action1.");
    }
    
    // 点击用户自定义Action2
    if ([userAction isEqualToString:customAction2]) {
        NSLog(@"User custom action2.");
    }
    completionHandler();
}
#pragma mark -----CloudPushSDK Init
- (void)initALIPushSDK{
    
    // SDK初始化
    [CloudPushSDK asyncInit:ALIPushAppKey appSecret:ALIPushAppSecret callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
            
        } else {
            
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
    
}
#pragma mark ------ Notification Open
/*
 *  App处于启动状态时，通知打开回调
 */
- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo {
    
    NSLog(@"Receive one notification.");
    // 取得APNS通知内容
    NSDictionary *dict = userInfo;
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    // 内容
    NSString *content = [aps valueForKey:@"alert"];
    // badge数量
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue];
    // 播放声音
    NSString *sound = [aps valueForKey:@"sound"];
    // 取得通知自定义字段内容，例：获取key为"Extras"的内容
    NSString *Extras = [userInfo valueForKey:@"Extras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"userInfo==%@,dict%@ apsDictionary==%@,content = [%@], badge = [%ld], sound = [%@], Extras = [%@]",userInfo,dict,aps, content, (long)badge, sound, Extras);
    // iOS badge 清0
    application.applicationIconBadgeNumber = 0;
    // 通知打开回执上报
    // [CloudPushSDK handleReceiveRemoteNotification:userInfo];(Deprecated from v1.8.1)
    [CloudPushSDK sendNotificationAck:userInfo];
}


#pragma mark Channel Opened
/**
 *    注册推送通道打开监听
 */
- (void)listenerOnChannelOpened {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChannelOpened:)
                                                 name:@"CCPDidChannelConnectedSuccess"
                                               object:nil];
}
/**
 *    推送通道打开回调
 *
 *
 */
- (void)onChannelOpened:(NSNotification *)notification {
    
    NSLog(@"-----消息通道建立成功------");
    
}

#pragma mark Receive Message
/**
 *    @brief    注册推送消息到来监听
 */
- (void)registerMessageReceive {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageReceived:)
                                                 name:@"CCPDidReceiveMessageNotification"
                                               object:nil];
}
/**
 *    处理到来推送消息
 *
 *
 */
- (void)onMessageReceived:(NSNotification *)notification {
    
    NSLog(@"Receive one message!");
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
    NSLog(@"Receive message title: %@, content: %@.", title, body);
}

#pragma mark ---- method
- (void)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [[YHJsonRequest shared] getAppVersionSucceededBlock:^(NSDictionary *dict){
        NSString *is_paymentstr =  dict[@"is_payment"];
        [[NSUserDefaults standardUserDefaults] setObject:is_paymentstr forKey:HidenCatagoryVip];//is_payment 是否展示付款信息 0 不展示 1 展示
        

        if (![[dict objectForKey:@"app_version"] isEqualToString:app_Version]) {
            if ([[dict objectForKey:@"is_update"] isEqualToString:@"2"]) {
                if ([dict objectForKey:@"app_version"]&&[dict objectForKey:@"update_text"]) {
                    YHAlertView *alert = [[YHAlertView alloc]initWithTitle:[dict objectForKey:@"app_version"] AndUpdateNecessaryText:[dict objectForKey:@"update_text"]];
                    alert.rightBlock = ^(NSString *text) {
                        if ([[dict objectForKey:@"isNeedClearFMDB"] isEqualToString:@"1"]){
                            [Tools clearChatFMDB];
                        }
                        NSString*str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1260429389"];
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
                    };
                    [alert showAnimated];
                }
            }else if ([[dict objectForKey:@"is_update"] isEqualToString:@"1"]) {
                if ([dict objectForKey:@"app_version"]&&[dict objectForKey:@"update_text"]) {
                    YHAlertView *alert = [[YHAlertView alloc]initWithTitle:[dict objectForKey:@"app_version"] AndUpdateUnNecessaryText:[dict objectForKey:@"update_text"]];
                    alert.rightBlock = ^(NSString *text) {
                        if ([[dict objectForKey:@"isNeedClearFMDB"] isEqualToString:@"1"]){
                            [Tools clearChatFMDB];
                        }
                        NSString*str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id1260429389"];
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
                    };
                    [alert showAnimated];
                }
            }
        }
    } failedBlock:^(NSString *errorMessage) {
       
    }];
}
-(void)go:(NSTimer *)time{
    count++;
    if (count==24*60*60) {
        [_timer invalidate];
        [self endBack]; // 任务执行完毕，主动调用该方法结束任务
    }
}
-(void)beginTask{
    
    _backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBack]; // 如果在系统规定时间内任务还没有完成，在时间到之前会调用到这个方法，一般是10分钟
    }];
}
-(void)endBack{
    
    [[UIApplication sharedApplication] endBackgroundTask:_backIden];
    _backIden = UIBackgroundTaskInvalid;
}

-(void)payState:(NSInteger )successState
{
    YHPayViewController *vc =( YHPayViewController *) [Tools currentViewController];
    NSDictionary *dic;
    dic = @{@"NsuserDefaultsPaySuccessState":@(successState),@"OrderNo":vc.OrderNo.length>0?vc.OrderNo:@""};
    
    if (vc.isHidenTopTitle==false) {//超级团付款
        
        
        if (successState==2) {
            for (UIViewController *vc2 in vc.navigationController.viewControllers) {
                if ([vc2 isKindOfClass:[YHSuperGroupDetailViewController class]]) {
                    YHSuperGroupDetailViewController *vc11 = (YHSuperGroupDetailViewController *)vc2;
                    [[Tools currentNavigationController] popToViewController:vc11 animated:YES];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NsuserDefaultsPaySuccessState object:nil userInfo:dic];
        } else {
            
            [[Tools currentNavigationController] popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:NsuserDefaultsPayFailState object:nil userInfo:dic];
            
        }
    } else {//会员付款
        if (successState==1) {
            [vc.view makeToast:@"支付已取消，请重新支付" duration:2 position:CSToastPositionCenter];
            return;
        }
        if (successState==-1) {
            [vc.view makeToast:@"支付失败，请重新支付" duration:2 position:CSToastPositionCenter];
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NsuserDefaultsPaySuccessState object:nil userInfo:dic];
        
        [[Tools currentNavigationController] popViewControllerAnimated:YES];
        dic = @{@"NsuserDefaultsPaySuccessState":@(successState)};
    }
    
}
@end
