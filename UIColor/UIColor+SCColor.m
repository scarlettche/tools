//
//  UIColor+SCColor.m
//  3.31-简单的图形绘制
//
//  Created by 车雨欣 on 15/4/1.
//  Copyright (c) 2015年 车雨欣. All rights reserved.
//

#import "UIColor+SCColor.h"

@implementation UIColor (SCColor)
+ (UIColor *)resetColorWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.5 green:green/255.5 blue:blue/255.5 alpha:alpha];
}
@end
