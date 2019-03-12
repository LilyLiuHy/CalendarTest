//
//  CalendarWeekView.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "CalendarWeekView.h"

@implementation CalendarWeekView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
-(void)setWeekTitles:(NSArray *)weekTitles{
    _weekTitles = weekTitles;
    
    CGFloat width = kScreenW /weekTitles.count;
    for (int i = 0; i< weekTitles.count; i++) {
        UILabel *weekLabel = [UILabel createLabelWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height) title:weekTitles[i] titleColor:color999 font:normalFont textAlightment:NSTextAlignmentCenter];
        weekLabel.backgroundColor =[UIColor whiteColor];
        [self addSubview:weekLabel];
    }
}

@end
