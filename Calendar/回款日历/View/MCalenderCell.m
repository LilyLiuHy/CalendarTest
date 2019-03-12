//
//  MCalenderCell.m
//  HTJF
//
//  Created by little apple on 2018/6/26.
//  Copyright © 2018年 little apple. All rights reserved.
//

#import "MCalenderCell.h"

@interface MCalenderCell()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic)UILabel *sign;

@end




@implementation MCalenderCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.sign];
        self.sign.hidden = YES;
    }
    return self;
}

- (void) setModel:(CalendarDayModel *)model{
    _model = model;
    
    self.label.text = [NSString stringWithFormat:@"%ld",model.day];
    self.layer.cornerRadius = 0.0;
    self.layer.masksToBounds = YES;
    
    //是否显示上个月下个月的
    if (model.isNextMonth || model.isLastMonth) {
        
        self.userInteractionEnabled = NO;
        if (model.isShowLastAndNextDate) {
            self.label.hidden = NO;
            if (model.isNextMonth) {
                self.label.textColor = color999;
            }
            if (model.isLastMonth) {
                self.label.textColor = color999;
            }
            self.label.backgroundColor = colorfff;
        }else{
            self.label.hidden = YES;
        }
        self.sign.hidden = YES;
    }else{
        self.label.hidden = NO;
        self.userInteractionEnabled = YES;
        self.label.textColor = color333;
        //是否被选中
        if (model.isSelected) {
            self.label.layer.cornerRadius = 15;
            self.label.layer.masksToBounds = YES;
            self.label.backgroundColor = colorPrice;
            self.label.textColor = colorfff;
            if (model.isHaveAnimation) {
                [self addAnimaiton];
            }
        }else{
            self.label.backgroundColor = colorfff;
        }
        
        
        //是否是今天
        if (model.isToday) {
            self.label.textColor = color333;
            self.label.layer.cornerRadius = 15;
            self.label.layer.masksToBounds = YES;
            if(model.isSelected){
                self.label.backgroundColor = colorPrice;
                self.label.textColor = colorfff;
            }else{
                self.label.backgroundColor = ColorRGBValue(0xeaeaea);
            }
        }
        //是否需要标识
        if(model.isSign){
            self.sign.hidden = NO;
        }else{
            self.sign.hidden = YES;
        }
    }
}

-(void)addAnimaiton{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.values = @[@0.6,@1.2,@1.0];
    //    anim.fromValue = @0.6;
    anim.keyPath = @"transform.scale";  // transform.scale 表示长和宽都缩放
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 0.25;                // 设置动画执行时间
    //    anim.repeatCount = MAXFLOAT;        // MAXFLOAT 表示动画执行次数为无限次
    
    //    anim.autoreverses = YES;            // 控制动画反转 默认情况下动画从尺寸1到0的过程中是有动画的，但是从0到1的过程中是没有动画的，设置autoreverses属性可以让尺寸0到1也是有过程的
    
    [self.label.layer addAnimation:anim forKey:nil];
}




#pragma -mark lazy
- (UILabel *)label{
    if(!_label){
        _label = [UILabel createLabelWithFrame:CGRectMake((kScreenW/7-30)/2, 0, 30, 30) title:@"" titleColor:color333 font:font14 textAlightment:NSTextAlignmentCenter];
    }
    return _label;
}

- (UILabel *)sign{
    if(!_sign){
        _sign = [UILabel createLabelWithFrame:CGRectMake(40, 0, 6, 6) title:@"" titleColor:colorPrice font:font14 textAlightment:NSTextAlignmentCenter];
        _sign.backgroundColor = colorPrice;
        _sign.layer.masksToBounds = YES;
        _sign.layer.cornerRadius = 3;
    }
    return _sign;
}




@end

