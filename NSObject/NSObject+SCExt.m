//
//  NSObject+SCExt.m
//  4.7-字典转模型
//
//  Created by 车雨欣 on 15/4/7.
//  Copyright (c) 2015年 车雨欣. All rights reserved.
//

#import "NSObject+SCExt.h"

@implementation NSObject (SCExt)

- (void)loadPlist:(NSString *)plistName withType:(NSString *)type{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    if ([type isEqualToString:@"NSDictionary"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        [self printAttributeFromDictionary:dic withDicName:plistName];
        
    }else{
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        [self printAttributeFromArray:array withArrayName:plistName];
    }
    
}


/**
 *方法名：- (void)printAttributeFromArray:
 *参数：数组
 *功能：打印数组中的所有属性
 *返回值：无
 *
 **/
- (void)printAttributeFromArray:(NSArray *)array withArrayName:(NSString *)arrayName{
    
    //定义成员变量的各个修饰符
    NSString *decorate = [NSString string];
    NSString *type = [NSString string];
    
    
    NSString *objectType = NSStringFromClass([[array firstObject] class]);
    
    if ([objectType isEqualToString:@"__NSCFDictionary"]) {
        //如果下一级类型为字典，传递给字典方法

        [self printAttributeFromDictionary:array[0] withDicName:arrayName];
        
    }else if([objectType isEqualToString:@"__NSCFBoolean"]){
        decorate = @"assign";
        type = @"BOOL ";
    }else if([objectType isEqualToString:@"__NSCFNumber"]){
        decorate = @"assign";
        type = @"NSInteger ";
    }else if([objectType isEqualToString:@"__NSCFString"]){
        decorate = @"copy";
        type = @"NSString *";
    }else if([objectType isEqualToString:@"__NSCFArray"]){
        //取样：如果下一级还是为array，继续遍历下一级
        [self printAttributeFromArray:array[0] withArrayName:arrayName];
    }

//    NSLog(@"%@",[[array firstObject] class]);
}


/**
 *方法名：- printAttributeFromDictionary:(NSDictionary *)
 *参数：字典
 *功能：归档所有的字典对象
 *返回值：无
 *
 **/
- (void)printAttributeFromDictionary:(NSDictionary *)dic withDicName:(NSString *)dicName{
    
    //定义成员变量的各个修饰符
    NSString *decorate = [NSString string];
    NSString *type = [NSString string];
    
    //定义一个可变数组，用来存储格式化成员变量
    //@property (xx,  xx) xx *xx;
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    
    //取出dic中的属性名
    NSArray *allKeys = [dic allKeys];
    for (NSString *key in allKeys) {
        
        //根据key找到key对应的类型
        Class class = [dic[key] class];
        NSString *keyType = NSStringFromClass(class);
        
        //如果属性的类型是__NSCFArray，继续深入查找打印属性
        if ([keyType isEqualToString:@"__NSCFArray"]) {
            //查看数组下一级类型，本级类型名dic[name]
//            NSLog(@"%@",[[dic[name] firstObject] class]);
            
            //传递给数组处理方法
            [self printAttributeFromArray:dic[key] withArrayName:key];
            
            decorate = @"strong";
            type = @"NSArray *";
        }else if([keyType isEqualToString:@"__NSCFNumber"]){
            decorate = @"assign";
            type = @"NSInteger ";
        }else if([keyType isEqualToString:@"__NSCFBoolean"]){
            decorate = @"assign";
            type = @"BOOL ";
        }else if([keyType isEqualToString:@"__NSCFString"]){
            decorate = @"copy";
            type = @"NSString *";
        }if ([keyType isEqualToString:@"__NSCFDictionary"]) {
            //如果下一级类型为字典，传递给字典方法
            
            [self printAttributeFromDictionary:dic[key] withDicName:key];
            decorate = @"strong";
            type = [NSString stringWithFormat:@"%@ *",key];
            
        }
        
//        printf("%s",name);
//        printf("请输入......");
//        char *str1;
//        scanf("%s",str1);
        
        
        NSString *str = [NSString stringWithFormat:@"\n@property (nonatomic, %@)%@%@\n",decorate,type,key];
        
        [propertyArray addObject:str];
        
        
        

//        NSLog(@"%@",str);
        
    }
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *name = [NSString stringWithFormat:@"%@.txt",dicName];
    NSString *fileName = [docPath stringByAppendingPathComponent:name];
    
    [propertyArray writeToFile:fileName atomically:YES];


    NSLog(@"%@",fileName);
    
    //    NSLog(@"%lu",dic.count);

}


@end
