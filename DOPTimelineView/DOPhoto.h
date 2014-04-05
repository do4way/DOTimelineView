//
//  DOPhoto.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/01.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOPhoto : NSObject

@property (nonatomic, readonly) NSURL   *thumbUrl;
@property (nonatomic, readonly) NSURL   *url;

- (instancetype) initWithUrl:(NSString *)urlStr
                    thumbUrl:(NSString *)thumbUrlStr;

@end
