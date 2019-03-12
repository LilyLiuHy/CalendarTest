//
//  TimeDisplayTool.m
//  HTJF
//
//  Created by ll on 2018/4/9.
//  Copyright © 2018年 ll. All rights reserved.
//

#import "TimeDisplayTool.h"


static NSDateFormatter *_formatter = nil;

@implementation TimeDisplayTool

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

/*
 ** 获取当前时间data(时分秒)
 */
+ (NSDate *)getCurrentTimeData{
    
    NSDateFormatter *formatter = [self ShareDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}
/*
 ** 获取当前时间字符串
 */
+ (NSString *)getCurrentTimeStr{
    
    NSDateFormatter *formatter = [self ShareDateFormatter];
    //hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeStr = [formatter stringFromDate:datenow];
    return timeStr;
}


/*
 ** 获取当前时间戳（以毫秒为单位）
 */
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [self ShareDateFormatter];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}


/*
 ** 获取当前时间戳（以秒为单位）
 */
+(NSString *)getNowTimeTimeStampWithSecondUnit{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}







/*
 ** 时间戳转换为时间(年/月/日)
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    
    // 格式化时间
    NSDateFormatter* formatter = [self ShareDateFormatter];;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/*
 ** 时间戳转换为时间(年/月/日/时/分/秒)
 */
+ (NSString *)timeWithTimeIntervalStringDetail:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [self ShareDateFormatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

/*
 ** 时间戳转换为时间(年/月/日)
 */
+ (NSString *)timeIntervalChangeToChineseForm:(NSString *)timeString{
    
    NSString *timeStr = [self timeWithTimeIntervalString:timeString];
    NSLog(@"timestr:%@",timeStr);
    return [NSString stringWithFormat:@"%@年%@月%@日",[timeStr substringToIndex:4],[timeStr substringWithRange:NSMakeRange(5, 2)],[timeStr substringFromIndex:8]];
}










/*
 ** 比较两个时间的大小
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    
    NSDateFormatter *dateFormatter = [self ShareDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
}


/*
 ** 判断当前时间和某个时间相比，是否过期
 */
+ (BOOL)isTimeOutSinceNowWithOneTime:(NSString *)lastTimeStr lastingMinutes:(NSInteger)second{
 
    NSDateFormatter *dateFormatter = [self ShareDateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *lastdate = [dateFormatter dateFromString:lastTimeStr];
    //获得有效期的最后时间,即上次设置的时间加上间隔
    NSTimeInterval  secondInterval = 1;  //1分钟的长度
    
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSDate *valueDate = [currentDate initWithTimeIntervalSinceNow:-secondInterval * second];

    NSComparisonResult result = [valueDate compare:lastdate];
    NSLog(@"result  :%ld",(long)result);
    if(result == NSOrderedDescending){//下降,超时了，过期了
        return YES;
    }else{
        return NO;
    }
}

/*
 ** 两个时间比较，相差多少天多少小时多少分钟多少秒
 *  文章发布时间的时候使用
        两个时间比较，相差多少天多少小时多少分钟多少秒
        1分钟内：刚刚
        距今分钟：3分钟前
        距今超过1小时，如1小时30分钟：显示1小时前
        不是今天：xx-xx
        不是今年：xxxx-xx-xx
 */
+ (NSString *)compareWithTime:(NSString *)timeInterval{
    
    NSDateFormatter *fmt = [self ShareDateFormatter];
    fmt.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    //时间转换为date
    NSDate* createDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]/ 1000.0];
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    // 获得某个时间的年月日时分秒
    NSDateComponents *createDateCmps = [calendar components:unit fromDate:createDate];
    NSDateComponents *currentDateCmps = [calendar components:unit fromDate:now];
    
    //进行比较得出结果
    NSString *timeStr;
    NSString *createTime = [self timeWithTimeIntervalStringDetail:timeInterval];
    //年份比较
    if(createDateCmps.year == currentDateCmps.year){
        //月份比较
        if(createDateCmps.month == currentDateCmps.month){
            //日子比较
            if(createDateCmps.day == currentDateCmps.day){
                //小时比较
                if(cmps.hour < 1){
                    if(cmps.minute < 1){
                        timeStr = @"刚刚";
                    }else{
                        timeStr = [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
                    }
                }else{
                    timeStr = [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
                }
            }else{
                timeStr = [createTime substringWithRange:NSMakeRange(5, 5)];
            }
        }else{
            timeStr = [createTime substringWithRange:NSMakeRange(5, 5)];
        }
    }else{
        timeStr = [createTime substringToIndex:10];
    }
    return timeStr;
}


/*
 ** 当前时间和当前时间和某个时间相比，相差多少天多少小时多少分钟多少秒
 *  账户详情显示使用
        当前时间和显示时间是不是同一天，同一天显示“今天”
        当前时间和显示时间是不是同一年，同一年不显示年份
        不是今年时间，全部显示
 */
+ (NSString *)accountDetailsShowTimeWithTimeIntervalString:(NSString *)timeString{
    
    NSDateFormatter *formatter = [self ShareDateFormatter] ;
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    //当前时间字符串
    NSString *currentTimeString = [formatter stringFromDate:[NSDate date]];
    //显示时间字符串
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* showTimeString = [formatter stringFromDate:date];
    //首先判断当前时间和显示时间是不是同一天，同一天显示“今天”
    if([[currentTimeString substringToIndex:10] isEqualToString: [showTimeString substringToIndex:10]]){
        return [NSString stringWithFormat:@"今天 %@",[showTimeString substringFromIndex:10]];
    }
    //判断当前时间和显示时间是不是同一年，同一年不显示年份
    else if([currentTimeString substringToIndex:4] == [showTimeString substringToIndex:4]){
        return [NSString stringWithFormat:@"%@",[showTimeString substringFromIndex:5]];
    }
    //不是今年时间，全部显示
    else{
        return [NSString stringWithFormat:@"%@",showTimeString ];
    }
}











@end
