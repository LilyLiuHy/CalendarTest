//
//  CalendarDayModel.h
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDayModel : NSObject

@property (nonatomic, assign) NSInteger totalDays; //!< 当前月的天数
@property (nonatomic, assign) NSInteger firstWeekday; //!< 标示第一天是星期几（0代表周日，1代表周一，以此类推）
@property (nonatomic, assign) NSInteger year; //!< 所属年份
@property (nonatomic, assign) NSInteger month; //!< 当前月份
@property (nonatomic, assign) NSInteger day;   //每天所在的位置

@property(nonatomic,assign)BOOL isLastMonth;//属于上个月的
@property(nonatomic,assign)BOOL isNextMonth;//属于下个月的
@property(nonatomic,assign)BOOL isCurrentMonth;//属于当月

@property(nonatomic,assign)BOOL isToday;//今天

@property(nonatomic,assign)BOOL isSelected;//是否被选中

@property(nonatomic,assign)BOOL isSign;//是否有标识
/*
 * 是否显示上月，下月的的数据
 */
@property(nonatomic,assign)BOOL isShowLastAndNextDate;
/*
 * 选中的是否动画效果
 */
@property(nonatomic,assign)BOOL isHaveAnimation;

@end
