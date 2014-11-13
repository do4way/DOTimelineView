//
//  BSLPhoto.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPost.h"

@implementation DOPost


- (instancetype) initWithUserName:(NSString *)name
                        avatarUrl:(NSString *)avator
                        timestamp:(NSDate *)timestamp
                           photos:(NSArray *)photos
                          caption:(NSString *)caption
                       numLikedBy:(NSInteger)numLikedBy
                          likedBy:(NSString *)likedBy
                   numCommentedBy:(NSInteger)numCommentedBy
                         comments:(NSArray *)comments
{
    if (self = [super init]) {
        _userName = name;
        _timestamp = timestamp;
        _caption = caption;
        _avatarUrl = [NSURL URLWithString:avator];
        _photos = photos;
        _numLikedBy = numLikedBy;
        _likedBy = likedBy;
        _numCommentedBy = numCommentedBy;
        _comments = comments;
        
    }
    
    return self;
}

- (NSString *) timestampAsString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-mm-dd"];
    return [formatter stringFromDate:self.timestamp];
}

- (id) copyWithZone:(NSZone *) zone
{
    DOPost *post = [[DOPost alloc] initWithUserName:[_userName copyWithZone:zone]
                                          avatarUrl:[_avatarUrl absoluteString]
                                          timestamp:_timestamp
                                             photos:[_photos copyWithZone:zone]
                                            caption:[_caption copyWithZone:zone]
                                         numLikedBy:_numLikedBy
                                            likedBy:[_likedBy copyWithZone:zone]
                                     numCommentedBy:_numCommentedBy
                                           comments:[_comments copyWithZone:zone]];
    return post;
}

@end
