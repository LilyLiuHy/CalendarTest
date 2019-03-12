//
//  styleDefine.h
//  HTJF
//
//  Created by ll on 2017/9/1.
//  Copyright © 2017年 ll. All rights reserved.
//

#ifndef styleDefine_h
#define styleDefine_h






// iPhone X 宏定义
#define  iPhoneX (kScreenW == 375.f && kScreenH == 812.f ? YES : NO)
// 适配iPhone X 状态栏高度
#define  StatusBarHeight      (iPhoneX ? 44.f : 20.f)
// 适配iPhone X Tabbar高度
#define  TabbarHeight         (iPhoneX ? (49.f+34.f) : 49.f)
// 适配iPhone X Tabbar距离底部的距离
#define  TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// 适配iPhone X 导航栏高度
#define  NavHeight  (iPhoneX ? 88.f : 64.f)

//iOS11安全边距适配，防止tableview偏移。automaticallyAdjustsScrollViewInsets = NO
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

/// 第一个参数是当下的控制器适配iOS11 一下的，第二个参数表示scrollview或子类
#define AdjustsScrollViewInsetNever(controller,view) if(@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;} else if([controller isKindOfClass:[UIViewController class]]) {controller.automaticallyAdjustsScrollViewInsets = false;}



/*
 iphone相关
 */
#pragma mark - 机型

#define isiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define isiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define isiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define isiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) : NO)

#pragma mark - 设备

#define is_iOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define is_iOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define is_iOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define is_iOS_10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define is_iOS_11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)


//pragma mark - 尺寸大小
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


//颜色
#define RandomColor   [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];//随机色

#define baseColor ColorRGBValue(0xf5f5f9)
#define spaceColor ColorRGBValue(0xECEBF3)
#define bgColor ColorRGBValue(0xf5f5f9)
#define linesColor ColorRGBValue(0xECEBF3)

#define color333 ColorRGBValue(0x333333)
#define color999 ColorRGBValue(0x999999)
#define color555 ColorRGBValue(0x555555)
#define color000 ColorRGBValue(0x000000)
#define color666 ColorRGBValue(0x666666)
#define colorfff ColorRGBValue(0xffffff)

#define colorOrange ColorRGBValue(0xd8832)
#define colorGreen ColorRGBValue(0x2cccaa)
#define colorPrice ColorRGBValue(0xfd5f61)

#define btnColor ColorRGBValue(0xFF6C03)

#define detailGreenColor ColorRGBValue(0x4bd964);
#define detailBlueColor ColorRGBValue(0x758ffb);
#define detailRedColor ColorRGBValue(0xff3b30);

/*
 字体（6上的字体）
 */

#define font32  [UIFont systemFontOfSize:32]
#define font24  [UIFont systemFontOfSize:24]
#define PriceFont  [UIFont systemFontOfSize:22]
#define font18  [UIFont systemFontOfSize:18]
#define normalFont  [UIFont systemFontOfSize:15]
#define font14  [UIFont systemFontOfSize:14]
#define font13  [UIFont systemFontOfSize:13]
#define font12  [UIFont systemFontOfSize:12]
#define font11  [UIFont systemFontOfSize:10]


/*********************定义颜色字体等********************/
#define htColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]


#define ColorRGBValue(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorRGB(rgbValue,x)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:x]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/*
 距离、比例、高度
 */

#define widthRatio kScreenW/375
#define heightRatio kScreenH*2/1334
#define aspectRatio 375/667
#define spaceW 15*widthRatio
#define spaceH 15*heightRatio
#define kWJHeightCoefficient (kWJScreenHeight == 812.0 ? 667.0/667.0 : kWJScreenHeight/667.0)

#define btnHeight 44*heightRatio
#define btnWidth (375-30)*widthRatio
#define spaceW 15*widthRatio
#define spaceH 15*heightRatio
#define normalCellH  (isiPhone6Plus || isiPhoneX) ? 60 : 50

#define myInvestmentHeaderHeight 110*heightRatio
#define accIncomeHeaderHeight 110*heightRatio
#define tradeDetailHeaderHeight 130*heightRatio
#define kTitleHeight 45*heightRatio



#endif /* styleDefine_h */
