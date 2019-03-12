//
//  RepaymentHeader.h
//  HTJF
//
//  Created by 萧珏 on 2018/6/27.
//  Copyright © 2018年 萧珏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"

@interface RepaymentHeader : UIView

@property(nonatomic,strong)CalendarView *calendar;

@property(nonatomic,strong)NSDictionary *repaymentDate;




@end
