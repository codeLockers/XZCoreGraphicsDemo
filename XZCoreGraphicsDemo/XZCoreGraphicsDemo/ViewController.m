//
//  ViewController.m
//  XZCoreGraphicsDemo
//
//  Created by 徐章 on 16/6/5.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZView.h"
#import "XZView2.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.imageView.image = [self createImage];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self cgImageRef]];
//    
//    imageView.center = self.view.center;
//    
//    [self.view addSubview:imageView];
    
    
//    XZView *view = [[XZView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    
//    view.center = self.view.center;
//    
//    view.backgroundColor = [UIColor greenColor];
//    
//    [self.view addSubview:view];
    
    
    XZView2 *view = [[XZView2 alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    view.center = self.view.center;
    
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)createImage{

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 100));
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRelease(context);
    
    UIGraphicsEndImageContext();

    return image;
}

- (UIImage *)drawImageTranslation{
    
    UIImage *image = [UIImage imageNamed:@"image"];
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width*2, size.height), NO, 0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    [image drawAtPoint:CGPointMake(size.width, 0)];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)drawImageScale{

    UIImage* image = [UIImage imageNamed:@"image"];
    
    CGSize size = [image size];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width*2, size.height*2), NO, 0);
    
    [image drawInRect:CGRectMake(0,0,size.width*2,size.height*2)];
    
    [image drawInRect:CGRectMake(size.width/2.0, size.height/2.0, size.width, size.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)clipImage{

    UIImage *image = [UIImage imageNamed:@"image"];
    
    CGSize size = [image size];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width/2.0f, size.height), NO, 0);
    
    [image drawAtPoint:CGPointMake(-size.width/2.0f, 0)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)cgImageRef{
    
    /* Method 1
    UIImage *image = [UIImage imageNamed:@"image"];
    
    CGSize size = image.size;
//    CGImageRef leftRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, size.width/2.0f, size.height));
//    CGImageRef rightRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(size.width/2.0f, 0, size.width/2.0f, size.height));
    
    CGImageRef imageRef = image.CGImage;
    
    CGSize imageRefSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGImageRef leftRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, imageRefSize.width/2.0f, imageRefSize.height));
    CGImageRef rightRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(imageRefSize.width/2.0f, 0, imageRefSize.width/2.0f, imageRefSize.height));
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, size.width/2.0f, size.height), [self flip:leftRef]);
    CGContextDrawImage(context, CGRectMake(size.width/2.0f, 0, size.width/2.0f, size.height), [self flip:rightRef]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRelease(leftRef);
    CGImageRelease(rightRef);
    return newImage;
     */
    
    UIImage *image = [UIImage imageNamed:@"image"];
    CGSize size = image.size;
    
    CGImageRef imageRef = image.CGImage;
    CGSize imageRefSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    CGImageRef leftRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, 0, imageRefSize.width/2.0f, imageRefSize.height));
    CGImageRef rightRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(imageRefSize.width/2.0f, 0, imageRefSize.width/2.0f, imageRefSize.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);

    [[UIImage imageWithCGImage:leftRef scale:[image scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(0, 0)];
    [[UIImage imageWithCGImage:rightRef scale:[image scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(size.width/2.0f, 0)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRelease(leftRef);
    CGImageRelease(rightRef);
    return newImage;
}

- (CGImageRef)flip:(CGImageRef)imageRef{

    CGSize size = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width,size.height), imageRef);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image.CGImage;
}

@end
