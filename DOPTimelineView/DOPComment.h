//
//  DOPComment.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/04.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOPComment : NSObject

@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *commentText;

- (instancetype) initWithUserName:(NSString *) userName comment:(NSString *) comment;

@end
