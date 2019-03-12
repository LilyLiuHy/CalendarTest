//
//  UILabel+Custom.m
//  meta
//
//  Created by ll on 16/8/4.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)


+(UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font textAlightment:(NSTextAlignment)alightment
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.textAlignment = alightment;
    label.numberOfLines = 0;
    return label;
}


+(UILabel *)createLabelWithLineInPoint:(CGPoint)point iconImg:(NSString *)imageName iconColor:(UIColor *)color font:(UIFont *)font
{
    UILabel *imgLabel = [[UILabel alloc]init];
    
    imgLabel.font = font;
    imgLabel.text = imageName;
//    CGSize size = [Common labelRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) LabelText:imageName Font:font];
//    imgLabel.frame = CGRectMake(point.x, point.y, size.width,size.height);
    imgLabel.textColor = color;
    
    return imgLabel;
}






+(UILabel *)createLabelWithLineInFrame:(CGRect)frame leftImg:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = img;
    imgView.frame = CGRectMake(25, 5, 25, 25);
    [label addSubview:imgView];
    
    UILabel *sublabel = [UILabel createLabelWithFrame:CGRectMake(imgView.frame.origin.x+imgView.frame.size.width+5, 0, kScreenW-imgView.frame.origin.x-imgView.frame.size.width, frame.size.height) title:title titleColor:color font:font textAlightment:NSTextAlignmentLeft];
    [label addSubview:sublabel];
    
    UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, label.frame.size.height-1, kScreenW, 1)];
    bottomLine.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [label addSubview:bottomLine];

    return label;
}






@end
