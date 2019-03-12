//
//  ViewController.m
//  Calendar
//
//  Created by 萧珏 on 2018/7/2.
//  Copyright © 2018年 small apple. All rights reserved.
//

#import "ViewController.h"

#import "CalendarController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"一年内的回款日历",@"前后对应的日历",@"封装好的日历"];
    [self.view addSubview:self.tbView];
    
}

#pragma -mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vCellWithIdentifier"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"vCellWithIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    UIViewController *ctrl;
    switch (indexPath.row) {
        case 0:
            ctrl = [[CalendarController alloc]init];
            break;
        case 1:
            ctrl = [[UIViewController alloc]init];
            break;
            
        default:
            break;
    }
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:ctrl];
    [self presentViewController:nav animated:YES
                     completion:nil];
}

- (UITableView *)tbView{
    if (!_tbView) {
        _tbView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _tbView.rowHeight = 50;
        _tbView.bounces = YES;
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.showsVerticalScrollIndicator = NO;
        _tbView.showsHorizontalScrollIndicator = NO;
        _tbView.tableFooterView = [UIView new];
    }
    return _tbView;
}

@end
