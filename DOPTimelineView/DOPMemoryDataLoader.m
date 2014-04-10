//
//  BSLMemoryDataLoader.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineProtocols.h"
#import "DOPMemoryDataLoader.h"
#import "DOPLoremIpsumGenerator.h"
#import "DOPostStream.h"
#import "DOPost.h"
#import "DOPhoto.h"
#import "DOPComment.h"

@interface DOPMemoryDataLoader() <DOPostsLoaderDelegate>

@property (nonatomic,readonly, strong) NSArray *usersAvatar;
@property (nonatomic,readonly, strong) NSArray *photos;
@property (nonatomic,strong) DOPLoremIpsumGenerator *wordGenerator;

@end

@implementation DOPMemoryDataLoader

+ (instancetype) sharedDataLoader
{
    static DOPMemoryDataLoader *memoryLD = Nil;
    
    if (!memoryLD) {
        memoryLD = [[self alloc ]initPrivate];
    }
    return memoryLD;
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [BSLMemoryDataLoader sharedDataLoader]"
                                 userInfo:Nil];
}

- (instancetype) initPrivate
{
    self = [super init];
    if (self) {
        _wordGenerator = [DOPLoremIpsumGenerator sharedGenerator];
        _usersAvatar = @[ @"https://farm8.staticflickr.com/7356/9326896674_9d9a5d36bf_s.jpg",
                     @"https://farm4.staticflickr.com/3813/10038713633_6ee6988e9e_s.jpg"];
        _photos = @[@{@"thumbnailUrl":@"https://farm5.staticflickr.com/4058/4596406502_12fb47c588.jpg",
                     @"url":@"https://farm5.staticflickr.com/4058/4596406502_12fb47c588_b.jpg"},
                      @{@"thumbnailUrl": @"https://farm2.staticflickr.com/1003/4596407764_e53424fee2.jpg",
                        @"url":@"https://farm2.staticflickr.com/1003/4596407764_e53424fee2_b.jpg"},
                    @{@"thumbnailUrl": @"https://farm5.staticflickr.com/4029/4596406976_983dc88ee8.jpg",
                      @"url":@"https://farm5.staticflickr.com/4029/4596406976_983dc88ee8_b.jpg"},
                    @{@"thumbnailUrl": @"https://farm4.staticflickr.com/3507/3177097877_54b2b91909.jpg",
                      @"url":@"https://farm4.staticflickr.com/3507/3177097877_54b2b91909_b.jpg"}];
       
    }
    return self;
}

- (NSArray *) loadPostsWithId:(NSString *)gid
                       pageNo:(NSInteger)pageNo
                     pageSize:(NSInteger)pageSize
{
    
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    for ( NSInteger i=0; i<pageSize; i++) {
        
        NSString *userName = [self.wordGenerator words:2 withSeparator:@" "];
        NSString *usrAvator = self.usersAvatar[arc4random() % [self.usersAvatar count]];
        NSInteger captionCnt = arc4random() % 20;
        NSString *caption = [self.wordGenerator words:captionCnt];
        NSInteger numLikedBy = arc4random() % 30;
        NSString *likedBy = numLikedBy ? [self.wordGenerator words:(arc4random() % 10 )+ 1 withSeparator:@"、"] : nil;
        NSInteger numCommentedBy = arc4random() % 6;
        NSArray *comments = [[NSArray alloc]init];
        if (numCommentedBy) {
            NSInteger cnt = arc4random() % 8 + 1;
            NSMutableArray *anArray = [[NSMutableArray alloc] initWithCapacity:cnt];
            NSInteger numWords = arc4random() % 10 + 1;
            for (NSInteger i=0; i<cnt; i++ ) {
                DOPComment* comment = [[DOPComment alloc]initWithUserName:[self.wordGenerator words:2 withSeparator:@" "]
                                                                  comment:[self.wordGenerator words:numWords]];
                [anArray addObject:comment];
            }
            comments = [anArray copy];
        }
        
        NSTimeInterval t = 0 - arc4random() % 86400; // 24*60*60
        
        DOPost *post = [[DOPost alloc] initWithUserName:userName
                                      avatarUrl:usrAvator
                                      timestamp:[NSDate dateWithTimeIntervalSinceNow:t]
                                         photos:[self generatePhotosData]
                                        caption:caption
                                     numLikedBy:numLikedBy
                                        likedBy:likedBy
                                 numCommentedBy:numCommentedBy
                                       comments:comments
                ];
        [posts addObject: post];
    }
    return [posts copy];
}

-(NSArray *) generatePhotosData
{
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    NSInteger len = arc4random() % 9;
    if (len == 0 )
        len = 1;
    for (NSInteger i=0; i<len; i++ ) {
        NSDictionary *photoUrl = self.photos[arc4random() % [self.photos count]];
        DOPhoto *photo = [[DOPhoto alloc] initWithUrl:photoUrl[@"url"]
                                             thumbUrl:photoUrl[@"thumbnailUrl"]];
        [photos addObject:photo];
    }
    return photos;
    
}

@end
