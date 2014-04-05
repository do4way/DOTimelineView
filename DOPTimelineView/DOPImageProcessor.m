//
//  BSLImageProcessor.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/13.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPImageProcessor.h"

@implementation DOPImageProcessor

+ (UIImage *) roundImage:(UIImage *)image
{
    
    const CGFloat cornerRadius = 35;
    
    const CGFloat h = image.size.height;
    const CGFloat w = image.size.width;
    CGImageRef cimage = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h,
                                                 CGImageGetBitsPerComponent(cimage),
                                                 CGImageGetBitsPerComponent(cimage) * 4 * w,
                                                 colorSpace,
                                                 kCGBitmapAlphaInfoMask & kCGImageAlphaNoneSkipLast);
    CGColorSpaceRelease(colorSpace);
    
    // Fill background with white color
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, CGRectMake(0, 0, w, h));
    
    [self addRoundedCornerPathWithContext:context width:w height:h cornerRadius:cornerRadius];
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), cimage);
    
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    return roundedImage;
}

+ (void)addRoundedCornerPathWithContext:(CGContextRef)context width:(CGFloat)w height:(CGFloat)h cornerRadius:(CGFloat)r
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, r);
    CGContextAddArcToPoint(context, 0, h, r, h, r);
    CGContextAddArcToPoint(context, w, h, w, h-r, r);
    CGContextAddArcToPoint(context, w, 0, w-r, 0, r);
    CGContextAddArcToPoint(context, 0, 0, 0, r, r);
    CGContextClosePath(context);
}




@end
