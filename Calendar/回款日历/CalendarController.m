//
//  CalendarController.m
//  HTJF
//
//  Created by little apple on 2018/6/27.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "CalendarController.h"
#import "RepaymentHeader.h"
#import "NSDate+Calendar.h"
#import "TimeDisplayTool.h"

#define UITableViewCellIdentifier @"UITableViewCellIdentifier"

@interface CalendarController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)RepaymentHeader *header;


@property(nonatomic,strong)NSMutableArray *listArray;
@property(nonatomic,strong)NSMutableArray *monthDateArray;
@property(nonatomic,copy)NSString *dateStr;

@end

@implementation CalendarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupUI];

    self.navigationItem.title = @"回款日历";
    [self setupUI];
    
    self.dateStr = [[TimeDisplayTool getCurrentTimeStr] substringToIndex:10];
    [self requestRepaymentDate:[self.dateStr substringToIndex:7]];
    //self.header.calendar.defaultSelectedItem = self.dateStr;//默认选中
}

- (void)setnav{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateHighlighted];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [backButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backButton];

    self.navigationController.navigationItem.leftBarButtonItem = item;
}

- (void)dismissView{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) requestRepaymentDate:(NSString *)time{

    NSDictionary *jsonDic = @{
        @"hasReturn" : @"1.00",
        @"shouldReturn" : @"9395.18",
        @"returnPlan" :  @[
                @{
                    @"amount" : @"1",
                    @"createTime" : @"1530496554000",
                    @"dueInAmount" : @"1",
                    @"id" : @"1263",
                    @"income" : @"0",
                    @"returnDate" : @" 1530547200000",
                    @"title" : @"测试"
                    },
                @{
                    @"amount" : @"1",
                    @"createTime" : @"1528959399000",
                    @"dueInAmount" : @"1",
                    @"id" : @"1263",
                    @"income" : @"0",
                    @"returnDate" : @" 1531497600000",
                    @"title" : @"我就测试一下"
                    },
                @{
                    @"amount" : @"1",
                    @"createTime" : @"1527246620000",
                    @"dueInAmount" : @"1",
                    @"id" : @"1263",
                    @"income" : @"0",
                    @"returnDate" : @" 1532361600000",
                    @"title" : @"测试222"
                    },
                @{
                    @"amount" : @"1",
                    @"createTime" : @"1523240461000",
                    @"dueInAmount" : @"1",
                    @"id" : @"1263",
                    @"income" : @"0",
                    @"returnDate" : @" 1532793600000",
                    @"title" : @"啦啦啦"
                    }]
        };
    [self ProcessingRepaymentData:jsonDic];
    
}

- (void)ProcessingRepaymentData:(NSDictionary *)dic{
    
    self.header.repaymentDate = dic;
    self.monthDateArray = [NSMutableArray arrayWithArray:dic[@"returnPlan"]];
    [self currentDayRepayment];
    
    NSArray *array = [self getMonthRepayment];
    self.header.calendar.signArray = array;
    
    //self.header.calendar.signArray
    
    
}

- (void) currentDayRepayment{
    
    [self.listArray removeAllObjects];
    for (NSDictionary *dict in self.monthDateArray) {
        NSString *returnDateStr = [TimeDisplayTool timeWithTimeIntervalString:dict[@"returnDate"]];
        if([returnDateStr isEqualToString:self.dateStr]){
            [self.listArray addObject:dict];
        }
    }
    if(self.listArray.count == 0){
        [self noData];
    }
    [self.tbView reloadData];
}

- (void)noData{
    
}



#pragma -mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"回款计划%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


#pragma -mark 头部尾部相关方法实现
- (void) realizationViewMethod{
    
    __weak typeof(self)weakSelf = self;
    self.header.calendar.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        weakSelf.dateStr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",year,month,day];
        [weakSelf currentDayRepayment];
    };
    
    self.header.calendar.changeMonthBlcok = ^(NSInteger year, NSInteger month) {
        NSLog(@"changeMonth----year-:%ld  month:%ld",year, month);
        weakSelf.dateStr = [[TimeDisplayTool getCurrentTimeStr] substringToIndex:10];
        NSString *monthStr = [NSString stringWithFormat:@"%ld-%.2ld",year,month];
        [weakSelf requestRepaymentDate:monthStr];
    };
}

- (void)setupUI{
    
    [self.view addSubview:self.tbView];
    self.tbView.tableHeaderView = self.header;
   
    [self realizationViewMethod];
}



#pragma -mark lazy
- (RepaymentHeader *)header{
    if(!_header){
         _header = [[RepaymentHeader alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 470)];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}

- (UITableView *)tbView{
    if (!_tbView) {
        _tbView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _tbView.rowHeight = 40;
        _tbView.bounces = YES;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.showsHorizontalScrollIndicator = NO;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableFooterView = [UIView new];
    }
    return _tbView;
}

- (NSMutableArray *)listArray{
    if(!_listArray){
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (NSMutableArray *)monthDateArray{
    if(!_monthDateArray){
        _monthDateArray = [NSMutableArray array];
    }
    return _monthDateArray;
}

#pragma -mark 把所有的回款日期放进数组里
- (NSArray *)getMonthRepayment{
    //
    NSMutableArray *repaymentArray = [NSMutableArray array];
    for (NSDictionary *dict in self.monthDateArray) {
        NSString *returnDateStr = [TimeDisplayTool timeWithTimeIntervalString:dict[@"returnDate"]];
        [repaymentArray addObject:returnDateStr];
    }
    //删除重复元素
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (NSString *str in repaymentArray) {
        if (![listAry containsObject:str]) {
            [listAry addObject:str];
        }
    }
    NSLog(@"listAry:%@",listAry);
    return listAry;
}






@end
