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
    return self.crtPosts[idx];
}

- (void) requestMorePosts
{
    self.loading = YES;
    //dispatch_queue_t dataRequestQueue = dispatch_queue_create("com.dodopipe.doptimeline.post.requester",Nil);
    
    [self performSelector:@selector(didRequestMorePosts) withObject:self afterDelay:1.0];
    /*dispatch_async(dataRequestQueue, ^{
        self.loading = YES;
        NSLog(@"requestMorePosts");

    });*/
}

- (void) clearData
{
    _crtPosts = @[];
    self.currentPageNo = 0;
    [self requestMorePosts];
}

- (void) didRequestMorePosts
{
    NSArray *newPosts = [self.dataLoader loadPostsWithId:self.userId
                                                  pageNo:++self.currentPageNo
                                                pageSize:self.pageSize];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.crtPosts];
    for (DOPost *post in newPosts) {
        [array addObject:post];
    }
    _crtPosts = array;
    self.loading = NO;
    NSLog(@"GET data");
    
    dispatch_async(dispatch_get_main_queue() , ^{
        
        [self.streamDelegate didPostStreamLoaded];
        
    });
}



@end
