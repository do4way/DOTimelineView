//
//  BSLPhotoStream.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DOPost;
@protocol DOPostsLoaderDelegate;

@protocol DOPostStreamDelegate <NSObject>

- (void) didPostStreamLoaded;

@end



@interface DOPostStream : NSObject

@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) id<DOPostStreamDelegate> streamDelegate;

- (instancetype) initWithUserId:(NSString *) userId
                     dataLoader:(id<DOPostsLoaderDelegate>) dataLoader;

- (NSUInteger) count;
- (void) requestMorePosts;
- (DOPost *) postAtIndex:(NSUInteger)idx;
- (void) clearData;

@end
