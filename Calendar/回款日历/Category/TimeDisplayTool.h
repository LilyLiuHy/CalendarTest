//
//  TimeDisplayTool.h
//  HTJF
//
//  Created by ll on 2018/4/9.
//  Copyright © 2018年 ll. All rights reserved.
//


/*
 有关于日期时间的显示
 */


#import <Foundation/Foundation.h>

@interface TimeDisplayTool : NSObject


/*
** 单例，减少NSDateFormatter时间开销
*/
+ (NSDateFormatter *)ShareDateFormatter;

/*
 ** 获取当前时间data(时分秒)
 */
+ (NSDate *)getCurrentTimeData;
/*
 ** 获取当前时间字符串
 */
+ (NSString *)getCurrentTimeStr;

/*
 ** 获取当前时间戳（以毫秒为单位）
 */
+(NSString *)getNowTimeTimestamp;

/*
 ** 获取当前时间戳（以秒为单位）
 */
+(NSString *)getNowTimeTimeStampWithSecondUnit;






/*
 ** 时间戳转换为时间(yyyy-MM-dd)
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

/*
 ** 时间戳转换为时间(yyyy-MM-dd HH:mm:ss)
 */
+ (NSString *)timeWithTimeIntervalStringDetail:(NSString *)timeString;

/*
 ** 时间戳转换为时间(年/月/日)
 */
+ (NSString *)timeIntervalChangeToChineseForm:(NSString *)timeString;


/*
 ** 比较两个时间的大小
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/*
 ** 判断当前时间和某个时间相比，是否过期
 */
+ (BOOL)isTimeOutSinceNowWithOneTime:(NSString *)lastTimeStr lastingMinutes:(NSInteger)second;

/*
 ** 当前时间和某个时间相比，相差多少天多少小时多少分钟多少秒
 *  文章发布时间的时候使用
 */
+ (NSString *)compareWithTime:(NSString *)timeInterval;


/*
 ** 当前时间和当前时间和某个时间相比，相差多少天多少小时多少分钟多少秒
 *  账户详情显示使用
 */
+ (NSString *)accountDetailsShowTimeWithTimeIntervalString:(NSString *)timeString;






@end
