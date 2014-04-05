//
//  DOPTimelineCellLayout.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/03.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCellLayout.h"
#import "DOPost.h"

static CGFloat const HEADER_HEIGHT = 40.0f;
static CGFloat const HEADER_MARGIN_TOP = 20.0f;
static CGFloat const PHOTO_CELL_PADDING = 2.0f;
static CGFloat const CAPTION_MARGIN_TOP = 5.0f;
static CGFloat const CAPTION_MARGIN_LEFT = 5.0f;
static CGFloat const CAPTION_MARGIN_RIGHT = 5.0f;
static CGFloat const LIKEDBY_ICON_MARGIN_TOP = 7.0f;
static CGFloat const LIKEDBY_ICON_MARGIN_LEFT = 5.0f;
static CGFloat const LIKEDBY_ICON_WIDTH = 10.0f;
static CGFloat const LIKEDBY_ICON_HEIGHT = 10.0f;
static CGFloat const LIKEDBY_TEXT_MARGIN_TOP = 4.0f;
static CGFloat const LIKEDBY_TEXT_MARGIN_LEFT = 18.0f;
static CGFloat const LIKEDBY_TEXT_HEIGHT = 17.0f;

static CGFloat const COMMENTS_MARGIN_TOP = 7.0f;
static CGFloat const COMMENTS_MARGIN_LEFT = 5.0f;
static CGFloat const COMMENT_CELL_PADDING = 2.0f;
static CGFloat const COMMENT_CELL_HEIGHT = 17.0f;
static CGFloat const COMMENT_NUM = 1.0f;

@interface DOPTimelineCellLayout()

@property (nonatomic,strong) DOPost *post;
@property (nonatomic) CGFloat width;

@end

@implementation DOPTimelineCellLayout

- (instancetype) initWithDOPost:(DOPost *)post cellWidth:(CGFloat)width
{
    if (self = [super init]) {
        self.post = post;
        self.width = width;
    }
    return self;
}

- (CGRect) headerRect
{
    return (CGRect) {
        .origin.x = 0.0f,
        .origin.y = HEADER_MARGIN_TOP,
        .size.width = self.width,
        .size.height = HEADER_HEIGHT
    };
}

- (CGRect) photosRect
{
    NSInteger photosCnt = [self.post.photos count] ;
    CGFloat width = self.width;
    CGFloat height = width * 3.0f / 4.0f;
    if ( photosCnt > 1) {
        NSInteger rowCnt = ((int) (photosCnt - 1)/ 3.0f) + 1;
        height = rowCnt * (width - 2 * PHOTO_CELL_PADDING) / 3.0f + (rowCnt - 1) * PHOTO_CELL_PADDING;
    }
    
    return (CGRect) {
        .origin.x = 0.0f,
        .origin.y = HEADER_MARGIN_TOP + HEADER_HEIGHT,
        .size.width = width,
        .size.height = height
    };
    
}

- (CGRect) captionRect
{
    CGSize size = [self captionTextSize];
    return (CGRect) {
        .origin.x = CAPTION_MARGIN_LEFT,
        .origin.y = CAPTION_MARGIN_TOP,
        .size.width = 0.0f,
        .size.height = ceil(size.height)
    };
}

- (CGRect) likedByIconRect
{
    return (CGRect) {
        .origin.x = LIKEDBY_ICON_MARGIN_LEFT,
        .origin.y = LIKEDBY_ICON_MARGIN_TOP,
        .size.width = LIKEDBY_ICON_WIDTH,
        .size.height = LIKEDBY_ICON_HEIGHT
    };
}

- (CGRect) likedByTextRect
{
    return (CGRect) {
        .origin.x = LIKEDBY_TEXT_MARGIN_LEFT,
        .origin.y = LIKEDBY_TEXT_MARGIN_TOP,
        .size.width = 0,
        .size.height = LIKEDBY_TEXT_HEIGHT
    };
}

- (CGRect) commentsRect
{
    NSInteger commentsCnt = MIN([self.post.comments count],1);
    CGFloat height = commentsCnt * (COMMENT_CELL_HEIGHT + COMMENT_CELL_PADDING) - COMMENT_CELL_PADDING;
    return (CGRect) {
        .origin.x = COMMENTS_MARGIN_LEFT,
        .origin.y = COMMENTS_MARGIN_TOP,
        .size.width = 0,
        .size.height = height
    };
}

- (CGFloat) height
{
    return  HEADER_MARGIN_TOP +
            [self headerRect].size.height +
            [self photosRect].size.height +
            CAPTION_MARGIN_TOP +
            [self captionRect].size.height +
            LIKEDBY_TEXT_MARGIN_TOP +
            LIKEDBY_TEXT_HEIGHT +
            COMMENTS_MARGIN_TOP +
            [self commentsRect].size.height +
            1.0f;
}

- (CGSize)captionTextSize
{
    CGSize sizeMax = (CGSize) {
        .width = _width - CAPTION_MARGIN_RIGHT - CAPTION_MARGIN_LEFT,
        .height = CGFLOAT_MAX,
    };
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
    CGSize size = [_post.caption boundingRectWithSize:sizeMax
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attr
                                              context:nil].size;
    NSLog(@"%@ size: %f,%f", _post.caption, size.width,size.height);
    return size;
}


@end
