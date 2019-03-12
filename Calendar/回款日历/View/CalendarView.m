//
//  CalendarView.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#define currentMonthTitleColor color333 //当前月的title颜色
#define lastMonthTitleColor color999   //上月的title颜色
#define nextMonthTitleColor color999   //下月的title颜色
#define selectBackColor colorPrice     //选中的背景颜色
#define todayTitleColor colorfff       //今日的title颜色
#define todayBackColor ColorRGBValue(0xeaeaea)  //今天的背景颜色


#import "CalendarView.h"
#import "CalendarHearder.h"
#import "CalendarWeekView.h"
#import "MCalenderCell.h"

#import "NSDate+Calendar.h"
#import "CalendarMonthModel.h"
#import "CalendarDayModel.h"

@interface CalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)CalendarHearder *calendarHeader; //头部
@property(nonatomic,strong)CalendarWeekView *calendarWeekView;//周
@property(nonatomic,strong)UICollectionView *collectionView;//日历
@property(nonatomic,strong)NSMutableArray *monthData;//当月的模型集合
@property(nonatomic,strong)NSDate *currentMonthDate;//当月的日期

@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property(nonatomic,strong)UISwipeGestureRecognizer *rightSwipe;//右滑手势

@property(nonatomic,strong)NSMutableArray *daysMondelArray;


@end






@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.currentMonthDate = [NSDate date];
        
        [self setupUI];
        [self setupGuesture];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.calendarHeader.frame = CGRectMake(0, 0, kScreenW, 40);
}

- (void)setupUI{
    [self addSubview:self.calendarHeader];
    [self addSubview:self.calendarWeekView];
    [self addSubview:self.collectionView];
    
    __weak typeof(self)weakSelf = self;
    self.calendarHeader.selectMonthBlock = ^(NSString *upOrDown, int apart) {
        [weakSelf setupMonthTap:upOrDown apart:apart];
    };
}

#pragma -mark 点击头部的月份
- (void) setupMonthTap:(NSString *)upOrDown apart:(int)apart{
    
    //获取之前的月份
    self.currentMonthDate = [self.currentMonthDate offsetMonths:apart];
    if([upOrDown isEqualToString:@"up"]){
        [self performAnimations:kCATransitionFromRight];
        
    }else{
        [self performAnimations:kCATransitionFromLeft];
    }
    [self responseDataDeal];
}

#pragma -mark 添加左滑右滑手势
- (void)setupGuesture{
    
    self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:self.rightSwipe];
}

#pragma mark --左滑手势--
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self leftSlide];
}
#pragma mark --左滑处理--
-(void)leftSlide{
    //判断是否在指定时间段内
    
    NSDate *leftLimitDate = [[NSDate date] offsetMonths:12];
    if([self.currentMonthDate isEarlierThanDate:leftLimitDate]){
        self.currentMonthDate = [self.currentMonthDate nextMonthDate];
        [self performAnimations:kCATransitionFromRight];
        [self responseDataDeal];
    }
}
#pragma mark --右滑处理--
-(void)rightSlide{
    
    NSDate *rigftLimitDate = [[NSDate date] offsetMonths:-11];
    if([self.currentMonthDate isLaterThanDate:rigftLimitDate]){
        self.currentMonthDate = [self.currentMonthDate previousMonthDate];
        [self performAnimations:kCATransitionFromLeft];
        [self responseDataDeal];
    }
}
#pragma mark --右滑手势--
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    
    [self rightSlide];
}
#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma -mark
- (void) setSignArray:(NSArray *)signArray{
    
    _signArray = signArray;
    NSLog(@"*******============================*******");
    NSLog(@"signArraysignArray:%@",signArray);
    NSLog(@"*******============================*******");
    
    for (CalendarDayModel *model in self.monthData) {
        //标识是否有回款
        NSString *nowDateStr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",model.year,model.month,model.day];
        for (NSString *str in signArray) {
            if([nowDateStr isEqualToString:str]){
                model.isSign = YES;
                break;
            }
        }
    }
    [self.collectionView reloadData];
}

- (void) setDefaultSelectedItem:(NSString *)defaultSelectedItem{
    
    for (CalendarDayModel *model in self.monthData) {
        NSString *nowDateStr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",model.year,model.month,model.day];
        if([nowDateStr isEqualToString:defaultSelectedItem]){
            model.isSelected = YES;
        }
    }
}

#pragma mark 数据以及更新处理
- (void) responseDataDeal{
    
    if(self.changeMonthBlcok){
        self.changeMonthBlcok(self.currentMonthDate.dateYear, self.currentMonthDate.dateMonth);
    }
    
    [self.monthData removeAllObjects];
    //获取当前月前后月的日期（以15号)
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    
    //初始化当月以及前后月的数据
    CalendarMonthModel *monthModel = [[CalendarMonthModel alloc]initWithDate:self.currentMonthDate];
    CalendarMonthModel *lastMonthModel = [[CalendarMonthModel alloc]initWithDate:previousMonthDate];
    
    //初始化头部
    self.calendarHeader.model = monthModel;
    
    //判断当月第一天是周几
    NSInteger firstWeekday = monthModel.firstWeekday;
    NSInteger totalDays = monthModel.totalDays;
    NSArray *signArray = monthModel.dotArray;
    for (int i = 0; i <42; i++) {
        
        CalendarDayModel *model =[[CalendarDayModel alloc]init];
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        model.month = monthModel.month;
        model.year = monthModel.year;
        model.isShowLastAndNextDate = YES;
        
        //上个月的日期
        if (i < firstWeekday) {
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            
            model.day = i -firstWeekday +1;
            model.isCurrentMonth = YES;
            //标识是今天
            if ((monthModel.month == [[NSDate date] dateMonth]) && (monthModel.year == [[NSDate date] dateYear])) {
                if (i == [[NSDate date] dateDay] + firstWeekday - 1) {
                    model.isToday = YES;
                    model.isSelected = YES;
                }
            }
        }
        //下月的日期
        if (i >= (firstWeekday + monthModel.totalDays)) {
            
            model.day = i - firstWeekday - totalDays +1;
            model.isNextMonth = YES;
        }
        //把这些model存进数组
        [self.monthData addObject:model];
    }
    //刷新数据
    [self.collectionView reloadData];
}


#pragma -mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.monthData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = @"MCalenderCellIden";
    MCalenderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if (!cell) {
        cell =[[MCalenderCell alloc]init];
    }
    cell.model = self.monthData[indexPath.row];
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
}
#pragma -mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayModel *model = self.monthData[indexPath.row];
    model.isSelected = YES;
    [self.monthData enumerateObjectsUsingBlock:^(CalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj != model) {
            obj.isSelected = NO;
        }
    }];
    if (self.selectBlock) {
        self.selectBlock(model.year, model.month, model.day);
    }
    [collectionView reloadData];
}



#pragma -mark lazy
-(CalendarHearder *)calendarHeader{
    if (!_calendarHeader) {
        _calendarHeader =[[CalendarHearder alloc]init];
        _calendarHeader.frame = CGRectMake(0, 0, kScreenW, 40);
        _calendarHeader.backgroundColor =[UIColor whiteColor];
    }
    return _calendarHeader;
}
-(CalendarWeekView *)calendarWeekView{
    if (!_calendarWeekView) {
        _calendarWeekView =[[CalendarWeekView alloc]initWithFrame:CGRectMake(0, self.calendarHeader.frame.size.height, kScreenW, 40)];
        _calendarWeekView.weekTitles = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _calendarWeekView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc]init];
        //325*403
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset =UIEdgeInsetsMake(0 , 0, 0, 0);
        
        flow.itemSize = CGSizeMake(kScreenW/7, 40);
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, self.calendarWeekView.frame.origin.y+self.calendarWeekView.frame.size.height, kScreenW, 6 * 40) collectionViewLayout:flow];
        _collectionView.backgroundColor = ColorRGBValue(0xf9f9f9);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        //一定注册cell
        [_collectionView registerClass:[MCalenderCell class] forCellWithReuseIdentifier:@"MCalenderCellIden"];
    }
    return _collectionView;
}

- (NSMutableArray *)monthData{
    if(!_monthData){
        _monthData = [NSMutableArray array];
    }
    return _monthData;
}
- (NSMutableArray *)daysMondelArray{
    if(!_daysMondelArray){
        _daysMondelArray = [NSMutableArray array];
    }
    return _daysMondelArray;
}


#pragma -mark 选中的是否动画效果
-(void)setIsHaveAnimation:(BOOL)isHaveAnimation{
    
    _isHaveAnimation  = isHaveAnimation;
}

#pragma -mark 是否禁止手势滚动
-(void)setIsCanScroll:(BOOL)isCanScroll{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}


-(void)dealData{
    [self responseDataDeal];
}




@end

