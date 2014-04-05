//
//  DOPhoto.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/01.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPhoto.h"

@implementation DOPhoto


- (instancetype) initWithUrl:(NSString *)urlStr thumbUrl:(NSString *)thumbUrlStr
{
    self = [super init];
    if (self) {
        _thumbUrl = [NSURL URLWithString:thumbUrlStr];
        _url = [NSURL URLWithString:urlStr];
    }
    return self;
}

@end
