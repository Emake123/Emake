//
//  NSDate+Common.h
//  emake
//
//  Created by 袁方 on 2017/7/21.
//  Copyright © 2017年 emake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)


/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;

/**
 * NSString --> NSDate
 */
+ (NSDate *)dateFromString:(NSString *)dateStr;

/**
 * 获取当前时间（格式）
 */
+(NSString *)getCurrentTime;

/**
 * 获取当前时间戳
 */
+(NSString *)getCurrentTimeStr;

/**
 * 获取当前时间(年月日)
 */
+(NSString *)getCurrentTimeYearMonthDay;
/**
 * 获取时间差并与有效时间做对比 返回YES代表有效，反之无效
 */
+(BOOL)isValideTimeDifferenceWithLastLoginTime:(NSString *)lastLoginTime currentLoginTime:(NSString *)currentLoginTime ValidTime:(NSString *)validTime;

+(BOOL)isValideTimeDifferenceWithTime:(NSString *)lastTime currentTime:(NSString *)currentTime ValidTime:(NSString *)validTime andValidTimeInterval:(NSInteger)interval;

//时间戳比较
+(BOOL)isValideTimeIntervalDifferenceWithTime:(NSString *)lastTime currentTime:(NSString *)currentTime;
@end
