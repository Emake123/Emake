//
//  YHAFNetWorkingRequset.h
//  emake
//
//  Created by 谷伟 on 2017/11/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <CommonCrypto/CommonCrypto.h>
// 网络请求方法枚举
typedef enum : NSUInteger{
    GET,
    POST,
    PUT,
    DELETE
} YHRequestMethod;
//网络状态
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NetworkStatusUnknown          = -1,
    NetworkStatusNotReachable     = 0,
    NetworkStatusReachableViaWWAN = 1,
    NetworkStatusReachableViaWiFi = 2,
};

typedef void(^YHRequestCallBack)(id result,NSError *error);
typedef void(^YHRequestProgressCallBack)(NSProgress *uploadProgress);

@interface YHAFNetWorkingRequset : AFHTTPSessionManager

@property (nonatomic,assign)NetworkStatus networkStatu;

//单例
+(instancetype)sharedRequset;

/*
 * 监听网络
 */
- (void)monitorNetworkStatus;

/*
 * 网络是否可用
 * @return YES：网络连接正常 NO：断网
 */
- (BOOL)isNetworkAvailable;

/**
 *  封装AFN请求方法
 *  @param method     请求类型
 *  @param urlString  请求的网络地址
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)request:(YHRequestMethod)method
      urlString:(NSString *)urlString
     parameters:(id)parameters
       finished:(YHRequestCallBack) finished;

/**
 *  封装GET请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)GET:(NSString *)urlString
 parameters:(id)parameters
   finished:(YHRequestCallBack)finished;

/**
 *  封装POST请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)POST:(NSString *)urlString
  parameters:(id)parameters
    finished:(YHRequestCallBack)finished;

/**
 *  封装PUT请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)PUT:(NSString *)urlString
  parameters:(id)parameters
    finished:(YHRequestCallBack)finished;
/**
 *  封装DELETE请求
 *
 *  @param urlString  请求的字符串
 *  @param parameters 请求的参数
 *  @param finished   请求成功或者失败的回调
 */
- (void)DELETE:(NSString *)urlString
 parameters:(id)parameters
   finished:(YHRequestCallBack)finished;

/**
 *   Dic转Json
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

/*
 *   字符串转dic
 */
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

/*
 *   字符串转arr
 */
+(NSMutableArray* )parseJSONStringToNSArray:(NSString* )JSONString;

//单独银行卡扫描API接口 POST请求
- (void)requestScanAPIWithParameters:(id)parameters
                            finished:(YHRequestCallBack) finished;
//上传图片到服务器
- (void)uploadImageToSevireURl:(NSString *)url param:(id)parameters progress:(YHRequestProgressCallBack)progressing finished:(YHRequestCallBack)finished;
@end
