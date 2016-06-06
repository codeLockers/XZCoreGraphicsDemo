//
//  XZView2.m
//  XZCoreGraphicsDemo
//
//  Created by 徐章 on 16/6/6.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZView2.h"

@implementation XZView2


- (void)drawRect:(CGRect)rect {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, CGRectMake(0, 0, 20, 20));
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    [image drawAtPoint:CGPointMake(0, 0)];
//    
    context = UIGraphicsGetCurrentContext();
//
//    CGContextTranslateCTM(context, 30, 0);
//    
//    [image drawAtPoint:CGPointMake(0, 0)];
//    
//    CGContextTranslateCTM(context, -30, 0);
    
    CGContextRotateCTM(context, M_PI_4);
    
    [image drawAtPoint:CGPointMake(0, 0)];
}


@end
