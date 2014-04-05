//
//  DOPTimelineCellLayout.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/03.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DOPost;

@interface DOPTimelineCellLayout : NSObject

- (instancetype) initWithDOPost:(DOPost *) post cellWidth:(CGFloat) width;

- (CGRect) headerRect;
- (CGRect) photosRect;
- (CGRect) captionRect;
- (CGRect) likedByIconRect;
- (CGRect) likedByTextRect;
- (CGRect) commentsRect;

- (CGFloat) height;


@end
