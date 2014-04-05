//
//  BSLPhoto.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOPost : NSObject

@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, readonly) NSURL    *avatarUrl;
@property (nonatomic, readonly) NSDate   *timestamp;
@property (nonatomic, readonly) NSArray  *photos;
@property (nonatomic, readonly) NSString *caption;
@property (nonatomic, readonly) NSInteger numLikedBy;
@property (nonatomic, readonly) NSString *likedBy;
@property (nonatomic, readonly) NSInteger numCommentedBy;
@property (nonatomic, readonly) NSArray  *comments;

- (instancetype) initWithUserName:(NSString*)name
                        avatarUrl:(NSString*)avator
                        timestamp:(NSDate*)timestamp
                           photos:(NSArray*)photos
                          caption:(NSString*)caption
                       numLikedBy:(NSInteger)numLikedBy
                          likedBy:(NSString*)likedBy
                   numCommentedBy:(NSInteger)numCommentedBy
                         comments:(NSArray*)comments;

- (NSString *) timestampAsString;

@end
