//
//  BSLPhotoStream.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DOPost;

@protocol DOPostsLoaderDelegate <NSObject>

- (NSArray *) loadPostsWithId:(NSString*)gid
                       pageNo:(NSInteger)pageNo
                     pageSize:(NSInteger)pageSize;

@end

@interface DOPostStream : NSObject

@property (nonatomic) BOOL loading;

- (instancetype) initWithUserId:(NSString *) userId
                     dataLoader:(id<DOPostsLoaderDelegate>) dataLoader;

- (NSUInteger) count;
- (void) requestMorePosts;
- (DOPost *) postAtIndex:(NSUInteger)idx;
- (void) clearData;

@end
