//
//  NSDate+Calendar.h
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;


/**
 *  获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)previousMonthDate;

/**
 *  获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)nextMonthDate;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;


/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)isLeapYear;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)offsetMonths:(int)numMonths;


- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;


@end
