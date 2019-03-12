//
//  NSDate+Calendar.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "NSDate+Calendar.h"

static NSDateFormatter *_formatter = nil;



#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Calendar)

/*
 ** 单例，减少NSDateFormatter时间开销
 */
+ (NSDateFormatter *)ShareDateFormatter{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _formatter = [[NSDateFormatter alloc]init];
        //设置时区,这个对于时间的处理有时很重要
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [_formatter setTimeZone:timeZone];
        //
        [_formatter setDateStyle:NSDateFormatterMediumStyle];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
    });
    return _formatter;
}

- (NSInteger)dateDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)dateMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)dateYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

+ (NSString *)getCurrentTimeStr{
    
    NSDateFormatter *formatter = [self ShareDateFormatter];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeStr = [formatter stringFromDate:datenow];
    return timeStr;
}

- (NSDate *)previousMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
    } else {
        components.month -= 1;
    }
    
    NSDate *previousDate = [calendar dateFromComponents:components];
    
    return previousDate;
}

- (NSDate *)nextMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
    } else {
        components.month += 1;
    }
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    return nextDate;
}

- (NSInteger)totalDaysInMonth {
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}

- (NSDate *)offsetMonths:(int)numMonths {

    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self
                                     options:0];
}



- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}



@end
