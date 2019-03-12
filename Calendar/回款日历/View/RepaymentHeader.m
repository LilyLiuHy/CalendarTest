//
//  RepaymentHeader.m
//  HTJF
//
//  Created by 萧珏 on 2018/6/27.
//  Copyright © 2018年 萧珏. All rights reserved.
//

#import "RepaymentHeader.h"


@interface RepaymentHeader()


@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIView *shouldMoneyView;
@property(nonatomic,strong)UILabel *shouldMoneyLabel;
@property(nonatomic,strong)UILabel *lineLabel1;
@property(nonatomic,strong)UIView *alreadyMoneyView;
@property(nonatomic,strong)UILabel *alreadyMoneyLabel;
@property(nonatomic,strong)UILabel *lineLabel2;

@property(nonatomic,strong)UILabel *planPromptLabel;
@property(nonatomic,strong)UILabel *signLabel;


@end



@implementation RepaymentHeader


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setRepaymentDate:(NSDictionary *)repaymentDate{
    
    _repaymentDate = repaymentDate;
    
    self.alreadyMoneyLabel.text = [NSString stringWithFormat:@"%@元",repaymentDate[@"shouldReturn"]];
    self.shouldMoneyLabel.text = [NSString stringWithFormat:@"%@元",repaymentDate[@"hasReturn"]];
}


- (void)setupUI{
    [self addSubview:self.calendar];
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(320);
    }];
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.calendar.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.shouldMoneyView];
    [self.shouldMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.calendar.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.lineLabel1];
    [self.lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceW);
        make.left.mas_equalTo(spaceW);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.shouldMoneyView.mas_bottom).offset(-1);
    }];
    
    [self addSubview:self.alreadyMoneyView];
    [self.alreadyMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.shouldMoneyView.mas_bottom).offset(1);
        make.height.mas_equalTo(50);
    }];
    
    [self addSubview:self.lineLabel2];
    [self.lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceW);
        make.left.mas_equalTo(spaceW);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.shouldMoneyView.mas_bottom).offset(-1);
    }];
    
    [self addSubview:self.planPromptLabel];
    [self.planPromptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceW);
        make.right.mas_equalTo(-spaceW);
        make.top.mas_equalTo(self.alreadyMoneyView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    [self addSubview:self.signLabel];
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.planPromptLabel.mas_left).offset(-2);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(self.planPromptLabel);
    }];
}


#pragma -MARK
- (CalendarView *)calendar{
    if(!_calendar){
        _calendar = [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 320)];
        _calendar.isCanScroll = YES;
        
        [_calendar dealData];
    }
    return _calendar;
}
- (UILabel *)lineLabel{
    if(!_lineLabel){
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = linesColor;
    }
    return _lineLabel;
}

- (UIView *)shouldMoneyView{
    if(!_shouldMoneyView){
        _shouldMoneyView = [self createView:@"当月应回款" imgStr:@"repaymentPlan_should"];
        _shouldMoneyView.backgroundColor = [UIColor whiteColor];
    }
    return _shouldMoneyView;
}
- (UILabel *)lineLabel1{
    if(!_lineLabel1){
        _lineLabel1 = [[UILabel alloc]init];
        _lineLabel1.backgroundColor = linesColor;
    }
    return _lineLabel1;
}
- (UIView *)alreadyMoneyView{
    if(!_alreadyMoneyView){
        _alreadyMoneyView = [self createView:@"当月已回款" imgStr:@"repaymentPlan_recieve"];
        _alreadyMoneyView.backgroundColor = [UIColor whiteColor];
    }
    return _alreadyMoneyView;
}
- (UILabel *)lineLabel2{
    if(!_lineLabel2){
        _lineLabel2 = [[UILabel alloc]init];
        _lineLabel2.backgroundColor = linesColor;
    }
    return _lineLabel2;
}
- (UILabel *)planPromptLabel{
    if(!_planPromptLabel){
        _planPromptLabel = [UILabel createLabelWithFrame:CGRectZero title:@"当日回款计划" titleColor:color333 font:font14 textAlightment:NSTextAlignmentLeft];
        _planPromptLabel.backgroundColor = ColorRGBValue(0xf9f9f9);
    }
    return _planPromptLabel;
}
- (UILabel *)signLabel{
    if(!_signLabel){
        _signLabel = [[UILabel alloc]init];
        _signLabel.backgroundColor = colorPrice;
    }
    return _signLabel;
}





- (UIView *)createView:(NSString *)promptStr imgStr:(NSString *)imgStr{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImage *iconImg = [UIImage imageNamed:imgStr];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:iconImg];
    [view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceW);
        make.centerY.mas_equalTo(view);
        make.size.mas_equalTo(iconImg.size);
    }];

    UILabel *leftLabel = [UILabel createLabelWithFrame:CGRectZero title:promptStr titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlightment:NSTextAlignmentLeft];
    [view addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_right).offset(4);
        make.centerY.mas_equalTo(view);
    }];
    
    UILabel *rightLabel = [UILabel createLabelWithFrame:CGRectZero title:@"0.00元" titleColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlightment:NSTextAlignmentLeft];
    [view addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(view);
    }];
    if([promptStr isEqualToString:@"当月应回款"]){
        self.shouldMoneyLabel = rightLabel;
    }else{
        self.alreadyMoneyLabel = rightLabel;
    }
    return view;
}






@end
