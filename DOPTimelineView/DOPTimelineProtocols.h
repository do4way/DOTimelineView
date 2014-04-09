//
//  DOPTimelineProtocols.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/09.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DOPostsLoaderDelegate <NSObject>

- (NSArray *) loadPostsWithId:(NSString*)gid
                       pageNo:(NSInteger)pageNo
                     pageSize:(NSInteger)pageSize;

@end

@protocol DOPTimelineGestureHandler <NSObject>

- (void) onPhotosDoubleTapped:(NSArray*) photoUrls startAt:(NSInteger)idx;

@end