//
//  UIImage+SCExt.h
//  4.2-Quartz2D图片裁剪
//
//  Created by 车雨欣 on 15/4/2.
//  Copyright (c) 2015年 车雨欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCExt)
//对象方法
//作用：图片裁剪成圆形图片
//参数：1. 图片名
//              2. 是否按照最大边裁剪
//               3. 裁剪后的多余部分是否透明
- (instancetype)clipImageWithName:(NSString *)name isFullImage:(BOOL)full isTransParent:(BOOL)transparent;




//对象方法
//作用：图片裁剪成圆形图片,并且加一个颜色外圈
//参数：1. name:图片名
//              2. borderColor:外圈颜色
//               3. BorderWidth:外圈宽度
- (instancetype)clipImageWithCircle:(NSString *)name andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width;


/**
 *方法名：imageWithWaterPrinting
 *参数：图片名，水印图片名
 *功能：给图片加水印
 *返回值：加完水印的图片
 *
 **/
+ (instancetype)imageWithWaterPrinting:(NSString *)imageName andWaterPrintingImage:(NSString *)printingName;
@end
