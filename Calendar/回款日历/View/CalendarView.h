//
//  CalendarView.h
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectBlock) (NSInteger year ,NSInteger month ,NSInteger day);


@interface CalendarView : UIView


/*
 * 选中的是否动画效果
 */
@property(nonatomic,assign)BOOL     isHaveAnimation;
/*
 * 是否禁止手势滚动
 */
@property(nonatomic,assign)BOOL     isCanScroll;

/*
 * 是否显示上月，下月的的数据
 */
@property(nonatomic,assign)BOOL     isShowLastAndNextDate;
/*
 * 在配置好上面的属性之后执行
 */
-(void)dealData;

/*
 * 选中的回调
 */
@property(nonatomic,copy)SelectBlock selectBlock;

/*
 * 切换月份的时候的回调
 */
@property(nonatomic,copy)void (^changeMonthBlcok)(NSInteger year,NSInteger month);

/*
 * 有回款的数据
 */
@property(nonatomic,strong)NSArray *signArray;


@end
