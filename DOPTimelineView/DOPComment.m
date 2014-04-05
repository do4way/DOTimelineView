//
//  DOPComment.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/04.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPComment.h"

@implementation DOPComment

- (instancetype) initWithUserName:(NSString *)userName comment:(NSString *)comment
{
    if (self = [super init]) {
        _userName = userName;
        _commentText = comment;
    }
    return self;
}

@end
