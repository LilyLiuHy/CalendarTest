//
//  CalendarHearder.h
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarMonthModel.h"

@interface CalendarHearder : UIView

@property(nonatomic,strong)CalendarMonthModel *model;

//
@property(nonatomic,copy) void(^selectMonthBlock)(NSString *upOrDown,int apart);

@end
