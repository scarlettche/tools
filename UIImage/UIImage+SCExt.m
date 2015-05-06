//
//  UIImage+SCExt.m
//  4.2-Quartz2D图片裁剪
//
//  Created by 车雨欣 on 15/4/2.
//  Copyright (c) 2015年 车雨欣. All rights reserved.
//

#import "UIImage+SCExt.h"

@implementation UIImage (SCExt)
- (instancetype)clipImageWithName:(NSString *)name isFullImage:(BOOL)full isTransParent:(BOOL)transparent{
    UIImage *img = [UIImage imageNamed:name];
    
    //开启上下文对象
    UIGraphicsBeginImageContextWithOptions(img.size, !transparent, 0.0);
    //获取当前图形上下文对象
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制一个圆
    //计算圆心
    CGFloat roundX = img.size.width * 0.5;
    CGFloat roundY = img.size.height * 0.5;
    CGFloat radius;
    if (full) {
        radius = MAX(roundX, roundY);
    }else{
        radius = MIN(roundX, roundY);
    }
    
    //计算半径
    CGContextAddArc(ctx, roundX, roundY, radius, 0, M_PI * 2, 0);
    
    //裁剪图文上下文对象
    CGContextClip(ctx);
    
    //将图片绘制在图文上下文对象
    [img drawAtPoint:CGPointZero];
    
    //从上下文中获取绘制好的图片对象
    UIImage *imgCliped = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束绘图上下文
    UIGraphicsEndImageContext();
    
    return imgCliped;
}


- (instancetype)clipImageWithCircle:(NSString *)name andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width{
    
    //加载图片
    UIImage *img = [UIImage imageNamed:name];
    
    //开启位图上下文
    CGFloat circleWidth = width;
    CGFloat contextW = img.size.width + circleWidth;
    CGFloat contextH = img.size.height + circleWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW, contextH), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制一个圆形
    CGFloat centerX = contextW * 0.5;
    CGFloat centerY = contextH * 0.5;
    CGFloat radius = MIN(contextW, contextH) * 0.5;
    CGContextAddArc(ctx, centerX, centerY, radius, 0, M_PI * 2, 0);
    
    [color set];
    
    //渲染,把绘制好的图形拿到一边去
    CGContextFillPath(ctx);
    
    //裁剪位图上下文
    
    //    contextW = img.size.width;
    //    contextH = img.size.height;
    CGFloat x = contextW * 0.5;
    CGFloat y = contextH * 0.5;
    
    radius = MIN(img.size.width, img.size.height) * 0.5;
    CGContextAddArc(ctx, x, y, radius, 0, M_PI * 2, 0);
    
    //裁剪图形上下文
    CGContextClip(ctx);
    
    //往裁剪好的图形上下文中添加图片
    [img drawAtPoint:CGPointZero];
    
    UIImage *imgCliped = UIGraphicsGetImageFromCurrentImageContext();
    
    
    //关闭位图上下文
    UIGraphicsEndImageContext();
    
    return imgCliped;
}


+ (instancetype)imageWithWaterPrinting:(NSString *)imageName andWaterPrintingImage:(NSString *)printingName{
    
    UIImage *img = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //这句话不起作用
    //    [img drawInRect:CGRectZero];
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    UIImage *imgIcon = [UIImage imageNamed:printingName];
    
    CGFloat imgIconX = img.size.width - imgIcon.size.width;
    CGFloat imgIconY = img.size.height - imgIcon.size.height;
    [imgIcon drawInRect:CGRectMake(imgIconX , imgIconY , imgIcon.size.width, imgIcon.size.height)];
    //    [imgIcon drawAtPoint:CGPointMake(imgIconX, imgIconY)];
    
    UIImage *imgX = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imgX;
}
@end
