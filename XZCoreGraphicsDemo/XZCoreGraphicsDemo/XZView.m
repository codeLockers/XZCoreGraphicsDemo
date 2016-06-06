//
//  XZView.m
//  XZCoreGraphicsDemo
//
//  Created by 徐章 on 16/6/5.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZView.h"


@implementation XZView


- (void)drawRect:(CGRect)rect {
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(con);
    
    // 在上下文裁剪区域挖一个三角形孔
    
    CGContextMoveToPoint(con, 90, 100);
    
    CGContextAddLineToPoint(con, 100, 90);
    
    CGContextAddLineToPoint(con, 110, 100);
    
    CGContextClosePath(con);
    
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    
    CGContextEOClip(con);
    
    //绘制一个垂线，让它的轮廓形状成为裁剪区域
    
    CGContextMoveToPoint(con, 100, 100);
    
    CGContextAddLineToPoint(con, 100, 19);
    
    CGContextSetLineWidth(con, 20);
    
    // 使用路径的描边版本替换图形上下文的路径
    
    CGContextReplacePathWithStrokedPath(con);
    
    // 对路径的描边版本实施裁剪
    
    CGContextClip(con);
    
    // 绘制渐变
    
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    
    CGFloat colors[12] = {
        
        0.3,0.3,0.3,0.8, // 开始颜色，透明灰
        
        0.0,0.0,0.0,1.0, // 中间颜色，黑色
        
        0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
        
    };
    
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
    
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    
    CGContextDrawLinearGradient(con, grad, CGPointMake(89,0), CGPointMake(111,0), 0);
    
    CGColorSpaceRelease(sp);
    
    CGGradientRelease(grad);
    
    CGContextRestoreGState(con); // 完成裁剪
    
    // 绘制红色箭头 
    
//    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
    
    CGContextSetFillColorSpace (con, sp2);
    
    CGColorSpaceRelease (sp2);
    
    CGPatternCallbacks callback = {0, &drawStripes, NULL };
    
    CGAffineTransform tr = CGAffineTransformIdentity;
    
    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
    
    CGFloat alph = 1.0;
    
    CGContextSetFillPattern(con, patt, &alph);
    
    CGPatternRelease(patt);
    
    
    
    CGContextMoveToPoint(con, 80, 25); 
    
    CGContextAddLineToPoint(con, 100, 0); 
    
    CGContextAddLineToPoint(con, 120, 25); 
    
    CGContextFillPath(con);
}


void drawStripes (void *info, CGContextRef con) {
    
    // assume 4 x 4 cell
    
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,4,2));
    
}

@end
