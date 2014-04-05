//
//  BSLPhotoStream.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPostStream.h"
#import "DOPost.h"

@interface DOPostStream ()

@property (nonatomic,readonly,strong) NSString *userId;
@property (nonatomic,weak) id<DOPostsLoaderDelegate> dataLoader;
@property (nonatomic) NSInteger currentPageNo;
@property (nonatomic, readonly) NSInteger pageSize;
@property (nonatomic,readonly,strong) NSArray *crtPosts;

@end

@implementation DOPostStream

- (instancetype) initWithUserId:(NSString *)userId
                     dataLoader:(id<DOPostsLoaderDelegate>)dataLoader
{
    self = [super init];
    if (self) {
        _userId = userId;
        _dataLoader = dataLoader;
        _currentPageNo = 0;
        _pageSize = 50;
        _crtPosts = @[];
        _loading = NO;
    }
    return self;
    
}

- (NSUInteger) count
{
    return [self.crtPosts count];
}


- (DOPost *)postAtIndex:(NSUInteger)idx;
{
    NSLog(@"request data index: %d", idx);
    return self.crtPosts[idx];
}

- (void) requestMorePosts
{
    self.loading = YES;
    NSArray *newPosts = [self.dataLoader loadPostsWithId:self.userId
                                                  pageNo:++self.currentPageNo
                                                pageSize:self.pageSize];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.crtPosts];
    for (DOPost *post in newPosts) {
        [array addObject:post];
    }
    _crtPosts = array;
    self.loading = NO;
}

- (void) clearData
{
    self.loading = YES;
    _crtPosts = @[];
    self.currentPageNo = 0;
    [self requestMorePosts];
}


@end
