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

@protocol DOPTimelineDelegate <NSObject>

@optional
- (void) onPhotosTapped:(UIGestureRecognizer*)gesture
              photoUrls:(NSArray*)photoUrls
                startAt:(NSInteger)idx;

-(void) readyForSegueForward:(UIStoryboardSegue *) segue sender:(id)sender;

@end
