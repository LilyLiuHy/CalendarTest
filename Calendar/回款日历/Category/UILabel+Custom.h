//
//  UILabel+Custom.h
//  meta
//
//  Created by ll on 16/8/4.
//  Copyright © 2016年 ll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)


+(UILabel *)createLabelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font textAlightment:(NSTextAlignment)alightment;



+(UILabel *)createLabelWithLineInFrame:(CGRect)frame leftImg:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font;

//使用自定义字体设置icon图标方法
+(UILabel *)createLabelWithLineInPoint:(CGPoint)point iconImg:(NSString *)imageName iconColor:(UIColor *)color font:(UIFont *)font;


//设置label的内边距
//绘制文字
+ (void)drawTextInRect:(CGRect)rect;






@end
