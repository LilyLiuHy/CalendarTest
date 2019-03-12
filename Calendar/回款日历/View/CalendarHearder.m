//
//  CalendarHearder.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "CalendarHearder.h"
#import "NSDate+Calendar.h"

#define baseTapTag 1120

@interface CalendarHearder()
{
    int _count; //第几年
    int _currentMonthIndex;
    int _currentYear;
}

@property(nonatomic)UIImageView *yearbgView;
@property(nonatomic)UILabel *yearLabel;
@property(nonatomic)UIScrollView *monthScroll;
@property(nonatomic)UILabel *line;

@property(nonatomic)NSMutableArray *monthArray;

@property(assign,nonatomic)NSInteger currentIndex;      //当前点击的第几个
@property(strong,nonatomic)CalendarMonthModel *currentModel;    //当前的monthmodel

@property(nonatomic,strong)NSDate *currentDate;     //当前时间






@end



@implementation CalendarHearder

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.currentDate = [NSDate date];
        _currentMonthIndex = (int)self.currentDate.dateMonth;
        _currentYear = (int)self.currentDate.dateYear;
        
        [self setupUI];
    }
    return self;
}


- (void)setModel:(CalendarMonthModel *)model{
    
    _model = model;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%ld",model.year];
    //当前的date数据
    NSInteger currentYear = self.currentDate.dateYear;
    //判断模型的年份是否=今年，如果是今年，count=1，如果是下一明年，是2，如果是去年则为0；
    if(currentYear == model.year){
        _count = 1;
    }else if (currentYear > model.year){
        _count = 0;
    }else{
        _count = 2;
    }
    NSLog(@"countxxxxxx:%d currentYear:%ld _currentMonthIndex:%d",_count,currentYear,_currentMonthIndex);
    
    NSInteger echo = _count*12 + ((int)model.month-_currentMonthIndex);
    self.currentIndex = echo;
    self.currentModel = model;
    [self currentMonthShow:echo];
    
    NSLog(@"currentIndex:%ld   month:%ld  echo:%ld",self.currentIndex,model.month,echo);
}

- (void) currentMonthShow:(NSInteger)month{
    
    NSLog(@"month:%ld",month);
    //scrollview滑动到对应的位置
    UILabel *currentMonthLabel = self.monthArray[month];
    
    //1.改变label颜色
    for (UILabel *label in self.monthArray) {
        if([label isEqual:currentMonthLabel]){
            currentMonthLabel.textColor = colorPrice;
        }else{
            label.textColor = color333;
        }
    }
    //2.改变scrollview的偏移量
    [self adjustLabelPosition:currentMonthLabel];
}

- (void) tapGesture:(UITapGestureRecognizer *)tap{
    
    UILabel *currentLabel = (UILabel *)tap.view;
    if(currentLabel.tag - baseTapTag == self.currentIndex){
        return;
    }
    NSInteger nowTapIndex = currentLabel.tag - baseTapTag;
    //0.判断是哪一年的月份,然后修改年份
    NSInteger nowTapYear = (int) (nowTapIndex - _currentMonthIndex - 1)/12;
    if(nowTapIndex - _currentMonthIndex < 0){
        _count = 0;
    }else{
        if(nowTapYear == 0){
            _count = 1;
        }else{
            _count = 2;
        }
    }
    self.yearLabel.text = [NSString stringWithFormat:@"%d",_currentYear+_count-1];
    
    //1.改变文字颜色
    UILabel *oldLabel = self.monthArray[self.currentIndex];
    NSInteger oldIndex = self.currentIndex;
    oldLabel.textColor = color333;
    self.currentIndex = nowTapIndex;
    NSInteger currentIndex = self.currentIndex;
    currentLabel.textColor = colorPrice;
    //2.改变滑动位置
    [self adjustLabelPosition:currentLabel];
    //3.代理通知，让日子跟着改变：判断当前月是大于还是小于之前的月
    NSString *upOrDown = oldIndex - currentIndex > 0 ? @"down" : @"up";
    int apart = (int)(currentIndex - oldIndex);
    NSLog(@"upOrDown:%@   apart:%d",upOrDown,apart);
    self.selectMonthBlock(upOrDown, apart);
}

#pragma -mark 计算label月份偏移量
- (void)adjustLabelPosition:(UILabel *)currentLabel{
    //1、计算一下offsetx
    CGFloat monthAllW = (kScreenW-70);
    CGFloat monthW = (kScreenW-70) / 6;
    
    CGPoint contentOffset = _monthScroll.contentOffset;
    contentOffset.x += (self.currentIndex * (monthW-1) + monthW / 2) - _monthScroll.contentOffset.x - monthAllW / 2;
    
    if (contentOffset.x < 0) {
        contentOffset.x = 0;
    }
    
    if (contentOffset.x + monthAllW > _monthScroll.contentSize.width) {
        contentOffset.x = _monthScroll.contentSize.width - monthAllW;
    }
    [self.monthScroll setContentOffset:CGPointMake(contentOffset.x, 0) animated:YES];
    
    //line
    CGFloat scrollLineX = currentLabel.frame.origin.x + (monthW - 28)/2;
    [UIView animateWithDuration:0.1f animations:^{
        CGRect frame = self.line.frame;
        frame.origin.x = scrollLineX;
        self.line.frame = frame;
    }];
}

#pragma -mark
- (void) setupUI{
    
    [self addSubview:self.yearbgView];
    [self.yearbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(40*widthRatio);
        make.width.mas_equalTo(70);
    }];
    
    [self.yearbgView addSubview:self.yearLabel];
    [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.yearbgView);
    }];
    
    [self addSubview:self.monthScroll];
    [self.monthScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.yearLabel.mas_right);
        make.right.mas_equalTo(0);
        make.top.height.mas_equalTo(self.yearbgView);
    }];
    
    //月份
    CGFloat monthW = (kScreenW-70) / 6;
    CGFloat monthCount = 25;
    int j = 0;
    for (int i= 0; i<monthCount; i++) {
        //
        int showNum = j + _currentMonthIndex;
        UILabel *monthLabel = [UILabel createLabelWithFrame:CGRectMake(monthW * i, 0, monthW, 39) title:[NSString stringWithFormat:@"%d月",showNum] titleColor:color333 font:font14 textAlightment:NSTextAlignmentCenter];
        [self.monthArray addObject:monthLabel];
        [self.monthScroll addSubview:monthLabel];
        
        if(j + _currentMonthIndex >= 12){
            j = - _currentMonthIndex;
        }
        j++;
        
        monthLabel.tag = baseTapTag + i;
        monthLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [monthLabel addGestureRecognizer:tap];
    }
    
    self.monthScroll.contentSize = CGSizeMake(monthW*monthCount, 0);
    
    self.line.frame = CGRectMake(0, 38, 28, 2);
    [self.monthScroll addSubview:self.line];
}

#pragma -mark lazy
- (UIImageView *)yearbgView{
    if(!_yearbgView){
        _yearbgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"repayment_year_bg"]];
        _yearbgView.contentMode = UIViewContentModeScaleAspectFill;
        _yearbgView.clipsToBounds = YES;
    }
    return _yearbgView;
}
- (UILabel *)yearLabel{
    if(!_yearLabel){
        _yearLabel = [UILabel createLabelWithFrame:CGRectZero title:@"" titleColor:colorPrice font:font18 textAlightment:NSTextAlignmentCenter];
        _yearLabel.backgroundColor = [UIColor clearColor];
    }
    return _yearLabel;
}

- (UIScrollView *)monthScroll{
    if(!_monthScroll){
        _monthScroll = [[UIScrollView alloc]init];
        _monthScroll.backgroundColor = ColorRGBValue(0xefefef);
        _monthScroll.showsHorizontalScrollIndicator = NO;
        _monthScroll.userInteractionEnabled = YES;
    }
    return _monthScroll;
}
- (UILabel *)line{
    if(!_line){
        _line = [[UILabel alloc]init];
        _line.backgroundColor = colorPrice;
    }
    return _line;
}
- (NSMutableArray *)monthArray{
    if(!_monthArray){
        _monthArray = [NSMutableArray array];
    }
    return _monthArray;
}

@end

