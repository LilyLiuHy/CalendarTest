//
//  CalendarMonthModel.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "CalendarMonthModel.h"
#import "NSDate+Calendar.h"

@implementation CalendarMonthModel

- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        _monthDate = date;
        
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        
    }
    return self;
}


- (NSInteger)setupTotalDays {
    return [_monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [_monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [_monthDate dateYear];
}

- (NSInteger)setupMonth {
    return [_monthDate dateMonth];
}



@end
