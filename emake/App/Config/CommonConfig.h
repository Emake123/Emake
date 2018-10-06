//
//  CommonConfig.h
//  emake
//
//  Created by 袁方 on 2017/7/17.
//  Copyright © 2017年 emake. All rights reserved.
//

#ifndef CommonConfig_h
#define CommonConfig_h



//友盟统计
#define UMMobClikAPPKey               @"59f96ae28f4a9d0c05000159"

//sharedSDK
#define  SharedSDKQQAppId             @"1106385272"
#define  SharedSDKQQAppKey            @"FbXFGgeitjutXnGk"
#define  SharedSDKWeiXinAppId         @"wx5cf643ea19645e5c"
#define  SharedSDKWeiXinAppKey        @"7e7c876e879ed27f09036764ffbd28b2"

// 阿里推送
#define ALIPushAppKey       @"24922550"
#define ALIPushAppSecret    @"e4a553059353c16932bf4bc96b8adfe0"

//阿里云OSS
#define endPoint @"oss-cn-shanghai.aliyuncs.com"


//扫描银行卡
#define ScanCardAPIAppAppID           @"10115293"
#define ScanCardAPIAppSecretKey       @"rijotNoSwSvDNQHyTtDLe1B9wXv7EtQm"
#define ScanCardAPIAppQQ              @"3022249197"
#define ScanCardAPIAppSecretID        @"AKIDY9mR6pKM7sdO70CneV0vtqnkhiDRpKkN"

//导航栏高度和tablebar高度
#define StatusBarHEIGHT             ScreenHeight==812?44.0f:20.0f
#define TOP_BAR_HEIGHT              ScreenHeight==812?88.0f:64.0f
#define TAB_BAR_HEIGHT              ScreenHeight==812?83.0f:49.0f


//手机系统
#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define iOS11_Former ([UIDevice currentDevice].systemVersion.floatValue <= 11.0f)

//字体
#define SYSTEM_FONT(systemSize) [UIFont systemFontOfSize:systemSize]

//角度转弧度
#define DegreesToRadian(x) (M_PI * (x) / 180.0)

//弧度转角度
#define RadianToDegrees(radian) ((radian) * 180.0 / M_PI)

//判断对象是否为空
#define CONFIRM_NOT_NULL(x) (((x) != nil)&&(![(x) isKindOfClass:[NSNull class]]))

//文件系统
#define PathTemp NSTemporaryDirectory()
#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define PathDocumentCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//#define ISstore [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];

//shared
#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared { \
static className *instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
}

//枚举
enum WebType
{
    WebTypeUserInstructions,
    WebTypeInsurancesInstructions
};

//通知
#define NotificatonOrderState                  @"NotificatonOrderState"
#define NotificatonRefreshCartData             @"NotificatonRefreshCartData"
#define NotificatonRefreshOrderData            @"NotificatonRefreshOrderData"
#define NotificatonRefreshTeamMember           @"NotificatonRefreshTeamMember"
#define NotificatonRefreshTeamList             @"NotificatonRefreshTeamList"
#define NotificatonBankSelected                @"NotificatonBankSelected"
#define NotificatonBankDelete                  @"NotificatonBankDelete"
#define NotificatonBankAddSuccess              @"NotificatonBankAddSuccess"
#define NotificatonShowCatagoryCommitBtn       @"NotificatonShowCatagoryCommitBtn"
#define NotificatonRefreshChatData             @"NotificatonRefreshChatData"
#define NotificatonRefreshMainView             @"NotificatonRefreshMainView"

#define NotificatonGetNewTocken                @"NotificatonGetNewTocken"
#define NotificatonChatMessagesCount           @"NotificatonChatMessagesCount"

#define NsuserDefaultsChatMessagesdict           @"messageCount"
#define NsuserDefaultsPaySuccessState           @"NsuserDefaultsPaySuccessState"

//字体适配
#define SYSTEM_FONT(systemSize)   [UIFont systemFontOfSize:systemSize]
#define AdaptFont(actureValue)    actureValue/375.0*ScreenWidth

// 国际化
#define LANGUAGE_STRING_FILENAME               @"EMakeLocalizable"
#define NSLanguageLocalizedString(key)  \
    NSLocalizedStringFromTable(key, LANGUAGE_STRING_FILENAME, nil)

//屏幕适配
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define WidthRate(actureValue)    actureValue/375.0*ScreenWidth
#define HeightRate(actureValue)   actureValue/667.0*ScreenHeight
#define HeightRateCommon(actureValue) ScreenHeight==812?actureValue:actureValue/667.0*ScreenHeight

//字体
#define FONT_SIZE(size) ([UIFont systemFontOfSize:FontSize(size))

//
#define floorNumber(num) (floorf(num*100)/100)


//table的无header、footer
#define TableViewHeaderNone    0.001
#define TableViewFooterNone    0.001


//字体适配
#define DEFIN_FontSize(fonsize)\
\
static inline CGFloat FontSize(CGFloat fontSize){\
    if (ScreenWidth==320) {\
        return fontSize-2;\
    }else if (ScreenWidth==375){\
        return fontSize;\
    }else{\
        return fontSize+2;\
    }\
}


//存储字段
#define LOGIN_MOBILEPHONE                       @"MobileNumber"
#define LOGIN_HeadImageURLString                @"HeadImageURLString"
#define LOGIN_CAPTCHA                           @"VerificationCode"
#define LOGIN_USERTYPE                          @"UserType"
#define LOGIN_PASSWORD                          @"password"
#define LOGIN_UUID                              @"uuid"
#define LOGIN_USERID                            @"USERID"
#define LOGIN_USENAMEREFERENUSERID              @"ReferenceUserId"
#define LOGIN_USERNAME                          @"UserName"
#define LOGIN_USERTYPE                          @"UserType"
#define LOGIN_USERCARDSTATE                     @"UserCardState" //1(未审核),4(审核失败)，2(正在审核)，3(审核成功)
#define USERSTATEFailReason                     @"USERSTATEFailReason" //失败原因
#define USERSTATECommitDate                     @"USERSTATECommitDate" //提交审核的时间
#define LOGIN_UserDrawState                     @"UserDrawState"
#define LOGIN_USERNICKNAME                      @"NickName"
#define LOGIN_USERREALNAME                      @"RealName"
#define Is_Login                                @"Is_Login"
#define USERSELECCATEGORY                       @"USERSELECCATEGORY" //品类的id
#define USERSELECCATEGORYName                   @"USERSELECCATEGORYName"
#define USERSCardID                             @"USERSCardID"
#define ISFRISTLOGIN                            @"ISFRISTLOGIN"
#define USERSCardName                           @"USERSCardName"
#define USERSISCHECK                            @"USERSISCHECK" //用户是否查看
#define USERREQUESTSERVER                       @"USERREQUESTSERVER"
#define LOGIN_ISSTORE                           @"LOGIN_ISSTORE"
#define LOGIN_Access_Token                      @"LOGIN_access_token"
#define LOGIN_Refresh_Token                     @"refresh_token"

#define LOGIN_UserStyle                         @"LOGIN_UserStyle"
#define IsIndustryCatagory                      @"IsIndustryCatagory"
#define LOGIN_UserStoreID                       @"LOGIN_UserStoreID"
#define CatagoryIDs                             @"CatagoryIDs"
#define VipState                                @"VipState"

#define DelegateMyMoney                         @"DelegateMyMoney"
#define CatagoryVipState                        @"CatagoryVip"// 0普通 1 输配电会员2休闲食品3 输配电会员和休闲食品

//热门搜索关键词
#define  USERSSearchKeywords                          @"USERSSearchKeywords"

#define Userdefault(key)                        [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define boolUserdefault(key)                        [[NSUserDefaults standardUserDefaults] boolForKey:key]

#endif /* CommonConfig_h */