//
//  DOPApplicationUtils.m
//  Pods
//
//  Created by Yongwei Dou on 2014/04/10.
//
//

#import "DOPApplicationUtils.h"

@implementation DOPApplicationUtils

+ (CGRect) currentScreenDependsOrientation
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        CGFloat width = CGRectGetWidth(screenBounds);
        CGFloat height = CGRectGetHeight(screenBounds);
        screenBounds.size = CGSizeMake(height,width);
    }
    return screenBounds;
}

@end
