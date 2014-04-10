//
//  DOPTimelineCellLayout.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/03.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineAppearance.h"
#import "DOPApplicationUtils.h"
#import "DOPost.h"

/** --------------------------------------------
 *   Timeline Header Layout
 *  --------------------------------------------*/
CGFloat  const DOPTL_HEADER_HEIGHT                  = 40.0f;
CGFloat  const DOPTL_AVATOR_MARGIN_TOP              = 30.0f;
CGFloat  const DOPTL_AVATOR_MARGIN_LEFT             = 10.0f;
CGFloat  const DOPTL_AVATOR_WIDTH                   = 35.0f;
CGFloat  const DOPTL_AVATOR_HEIGHT                  = 35.0f;
CGFloat  const DOPTL_USERNAME_MARGIN_RELATED_LEFT   = 12.0f;
CGFloat  const DOPTL_USERNAME_MARGIN_RELATED_RIGHT  = -12.0f;
CGFloat  const DOPTL_USERNAME_FONT_SIZE             = 14.0f;
CGFloat  const DOPTL_UPDATETIME_MARGIN_RIGHT        = 10.0f;
CGFloat  const DOPTL_UPDATETIME_FONT_SIZE           = 10.0f;
CGFloat  const DOPTL_TIMERICON_MARGIN_RELATED_RIGHT = -3.0f;
CGFloat  const DOPTL_TIMERICON_WIDTH                = 10.0f;
CGFloat  const DOPTL_TIMERICON_HEIGHT               = 10.0f;


/** ------------------------------------------
 *    Timeline photos Layout
 *  ------------------------------------------*/
CGFloat  const DOPTL_PHOTOS_MARGIN_TOP             = 0.0f;
CGFloat  const DOPTL_PHOTOS_MARGIN_LEFT            = 0.0f;
CGFloat  const DOPTL_PHOTOS_MARGIN_RIGHT           = 0.0f;
CGFloat  const DOPTL_SINGLE_PHOTO_ASPECTRADIO      = 0.75f;
CGFloat  const DOPTL_PHOTOS_GRID_PADDING           = 8.0f;
NSInteger const DOPTL_PHOTOS_GRID_COLUMN_NUM       = 3;
NSInteger const DOPTL_PHOTOS_GRID_ROW_NUM          = 3;

/** ------------------------------------------
 *    Timeline caption Layout
 *  ------------------------------------------*/

CGFloat  const DOPTL_CAPTION_MARGIN_TOP            = 5.0f;
CGFloat  const DOPTL_CAPTION_MARGIN_LEFT           = 5.0f;
CGFloat  const DOPTL_CAPTION_MARGIN_RIGHT          = 5.0f;
CGFloat  const DOPTL_CAPTION_FONT_SIZE             = 14.0f;

/** ------------------------------------------
 *    Timeline likedBy Layout
 *  ------------------------------------------*/
CGFloat  const DOPTL_LIKEDBY_ICON_MARGIN_TOP       = 5.0f;
CGFloat  const DOPTL_LIKEDBY_ICON_MARGIN_LEFT      = 5.0f;
CGFloat  const DOPTL_LIKEDBY_ICON_WIDTH            = 13.0f;
CGFloat  const DOPTL_LIKEDBY_ICON_HEIGHT           = 12.0f;
CGFloat  const DOPTL_LIKEDBY_TEXT_MARGIN_RELATED_LEFT = 5.0f;
CGFloat  const DOPTL_LIKEDBY_TEXT_MARGIN_RIGHT     = 5.0f;
CGFloat  const DOPTL_LIKEDBY_TEXT_FONT_SIZE        = 14.0f;
CGFloat  const DOPTL_LIKEDBY_TEXT_HEIGHT           = 15.0f;

/** ------------------------------------------
 *    Timeline Comment Layout
 *  ------------------------------------------*/
CGFloat  const DOPTL_COMMENT_USERNAME_MARGIN_TOP   = 0.0f;
CGFloat  const DOPTL_COMMENT_USERNAME_MARGIN_LEFT  = 5.0f;
CGFloat  const DOPTL_COMMENT_USERNAME_HEIGHT       = 16.0f;
CGFloat  const DOPTL_COMMENT_UNC_SPEPARATOR_MARGIN_RELATED_LEFT = 2.0f;
CGFloat  const DOPTL_COMMENT_UNC_SPEPARATOR_WIDTH  = 4.0f;
NSString *const DOPTL_COMMENT_UNC_SPEPARATOR_STRING = @":";
CGFloat  const DOPTL_COMMENT_CONTENT_MARGIN_RELATED_LEFT = 8.0f;
CGFloat  const DOPTL_COMMENT_CONTENT_MARGING_RIGHT = 5.0f;
CGFloat  const DOPTL_COMMENT_USERNAME_FONT_SIZE    = 14.0f;
CGFloat  const DOPTL_COMMENT_CONTENT_FONT_SIZE     = 14.0f;

/** ------------------------------------------
 *    Timeline Command Layout
 *  ------------------------------------------*/

CGFloat  const DOPTL_COMMAND_LIKEBTN_MARGIN_TOP    = 7.0f;
CGFloat  const DOPTL_COMMAND_LIKEBTN_MARGIN_LEFT   = 5.0f;
CGFloat  const DOPTL_COMMAND_LIKEBTN_WIDTH         = 120.0f;
CGFloat  const DOPTL_COMMAND_LIKEBTN_HEIGHT        = 23.0f;
CGFloat  const DOPTL_COMMAND_LIKEBTN_FONT_SIZE     = 15.0f;
CGFloat  const DOPTL_COMMAND_COMMENTBTN_MARGIN_RELATED_LEFT = 8.0f;
CGFloat  const DOPTL_COMMAND_COMMENTBTN_WIDTH      = 120.0f;
CGFloat  const DOPTL_COMMAND_COMMENTBTN_HEIGHT     = 23.0f;
CGFloat  const DOPTL_COMMAND_COMMENTBTN_FONT_SIZE  = 15.0f;
CGFloat  const DOPTL_COMMAND_COMMENT_NUM_MARGIN_RIGHT = 5.0f;
CGFloat  const DOPTL_COMMAND_COMMENT_NUM_FONT_SIZE = 12.0f;
CGFloat  const DOPTL_COMMAND_COMMENT_ICON_MARGIN_RELATED_RIGHT = -5.0f;
CGFloat  const DOPTL_COMMAND_COMMENT_ICON_WIDTH    = 13.0f;
CGFloat  const DOPTL_COMMAND_COMMENT_ICON_HEIGHT   = 12.0f;
CGFloat  const DOPTL_COMMAND_LIKED_NUM_MARGIN_RELATED_RIGHT = -5.0f;
CGFloat  const DOPTL_COMMAND_LIKED_NUM_FONT_SIZE   = 12.0f;
CGFloat  const DOPTL_COMMAND_LIKED_ICON_MARGIN_RELATED_RIGHT = -5.0f;
CGFloat  const DOPTL_COMMAND_LIKED_ICON_WIDTH      = 13.0f;
CGFloat  const DOPTL_COMMAND_LIKED_ICON_HEIGHT     = 12.0f;

/** ----------------------------------------
 *    Localizable table name
 *  ----------------------------------------*/
NSString *const DOPTL_LOCALIZABLE_STRING_TABLE_NAME = @"DOPTimeline";

@implementation UIColor(DOPTimeline)

+ (UIColor *) userNameTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}

+ (UIColor *) updateTimeTextColor
{
    return [UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f];
}

+ (UIColor *) captionTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}

+ (UIColor *) likedByTextColor
{
    return [UIColor colorWithRed:0.0f green:0.21f blue:0.31f alpha:1.0f];
}

+ (UIColor *) commentedUserNameTextColor
{
    return [UIColor colorWithRed:0.0f green:0.21f blue:0.31f alpha:1.0f];
}

+ (UIColor *) commentContentTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}

+ (UIColor *) likeBtnTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}

+ (UIColor *) commentBtnTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}
+ (UIColor *) btnBackgroundColor
{
    return [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.0f];
}
+ (UIColor *) likedNumTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
}

+ (UIColor *) commentedNumTextColor
{
    return [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f];
    
}
@end

@implementation UIFont(DOPTimeline)

+ (UIFont *) userNameFont
{
    return [UIFont boldSystemFontOfSize:DOPTL_USERNAME_FONT_SIZE];
}

+ (UIFont *) updateTimeFont
{
    return [UIFont systemFontOfSize:DOPTL_UPDATETIME_FONT_SIZE];
}

+ (UIFont *) captionFont
{
    return [UIFont systemFontOfSize:DOPTL_CAPTION_FONT_SIZE];
}

+ (UIFont *) likedByTextFont
{
    return [UIFont boldSystemFontOfSize:DOPTL_LIKEDBY_TEXT_FONT_SIZE];
}

+ (UIFont *) commentedUserNameFont
{
    return [UIFont boldSystemFontOfSize:DOPTL_COMMENT_USERNAME_FONT_SIZE];
}

+ (UIFont *) commentContentFont
{
    return [UIFont systemFontOfSize:DOPTL_COMMENT_CONTENT_FONT_SIZE];
}

+ (UIFont *) likeBtnTextFont
{
    return [UIFont systemFontOfSize:DOPTL_COMMAND_LIKEBTN_FONT_SIZE];
}

+ (UIFont *) commentBtnTextFont
{
    return [UIFont systemFontOfSize:DOPTL_COMMAND_COMMENTBTN_FONT_SIZE];
}

+ (UIFont *) likedNumTextFont
{
    return [UIFont systemFontOfSize:DOPTL_COMMAND_LIKED_NUM_FONT_SIZE];
}

+ (UIFont *) commentedNumTextFont
{
    return [UIFont systemFontOfSize:DOPTL_COMMAND_COMMENT_NUM_FONT_SIZE];
}

@end

@implementation UIImage(DOPTimeline)

+ (UIImage *) timerIcon
{
    return [UIImage imageNamed:@"timer"];
}


+ (UIImage *) likeIcon
{
    return [UIImage imageNamed:@"likeIcon"];
}

+ (UIImage *) commentIcon
{
    return [UIImage imageNamed:@"commentIcon"];
}

@end

@implementation DOPTLocalizableString

+ (NSString *)likeBtnText
{
    return NSLocalizedStringFromTable(@"  Like",DOPTL_LOCALIZABLE_STRING_TABLE_NAME,nil);
}

+ (NSString *)likeBtnEnabledText
{
    return NSLocalizedStringFromTable(@"  Liked", DOPTL_LOCALIZABLE_STRING_TABLE_NAME, nil);
}

+ (NSString *)commentBtnText
{
    return NSLocalizedStringFromTable(@"  Comment", DOPTL_LOCALIZABLE_STRING_TABLE_NAME, nil);
}

@end

@interface DOPTimelineAppearance()


@property (nonatomic,strong) DOPost *post;
@property (nonatomic) CGFloat width;
@property (nonatomic) BOOL toUsePhotoPicker;
@property (nonatomic) BOOL hasCaption;
@property (nonatomic) BOOL hasLikedBy;
@property (nonatomic) BOOL hasComment;

@end

@implementation DOPTimelineAppearance


- (instancetype) initWithDOPost:(DOPost *)post
{
    CGFloat width = [DOPApplicationUtils currentScreenDependsOrientation].size.width;
    return [self initWithDOPost:post width:width];
}

- (instancetype) initWithDOPost:(DOPost *)post width:(CGFloat)width
{
    if (self = [super init]) {
        self.post = post;
        self.width = width;
        NSInteger photoCnt = [self.post.photos count];
        self.toUsePhotoPicker = photoCnt > 1;
        self.hasCaption = self.post.caption && [self.post.caption length] > 0 ? YES : NO;
        self.hasLikedBy = self.post.likedBy && [self.post.likedBy length] > 0 ? YES : NO;
        self.hasComment = [self.post.comments count] > 0;
    }
    return self;
    
}

- (CGFloat) heightOfPartIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:
            return DOPTL_HEADER_HEIGHT + DOPTL_AVATOR_MARGIN_TOP;
            break;
        case 1:
            if ( self.toUsePhotoPicker )
                return [self photoPickerHeight];
            else
                return self.width * DOPTL_SINGLE_PHOTO_ASPECTRADIO;
            break;
        case 2:
            if ( self.hasCaption )
                return [self captionHeight] + DOPTL_CAPTION_MARGIN_TOP + 1.0;
            else
                return 1.0f; //important, should consider the separate space in table cell view.
            break;
        case 3:
            if ( self.hasLikedBy )
                return DOPTL_LIKEDBY_ICON_MARGIN_TOP + DOPTL_LIKEDBY_TEXT_HEIGHT + 1.0;
            else
                return 1.0f;
            break;
        case 4:
            if ( self.hasComment )
                return DOPTL_COMMENT_USERNAME_MARGIN_TOP + DOPTL_COMMENT_USERNAME_HEIGHT + 1.0;
            else
                return 1.0f;
            break;
        case 5: {
            return  DOPTL_COMMAND_LIKEBTN_MARGIN_TOP + DOPTL_COMMAND_LIKEBTN_HEIGHT;
            break;
        }
        default:
            return 1.0f;
    }
}


#pragma  mark - private methods


- (CGFloat) photoPickerHeight
{
    CGFloat photoWidth = (self.width - ( DOPTL_PHOTOS_GRID_COLUMN_NUM - 1 ) * DOPTL_PHOTOS_GRID_PADDING ) / DOPTL_PHOTOS_GRID_COLUMN_NUM;
    NSInteger cnt = MIN([self.post.photos count]
                        , DOPTL_PHOTOS_GRID_ROW_NUM * DOPTL_PHOTOS_GRID_COLUMN_NUM);
    NSInteger rowNum = (cnt - 1) / DOPTL_PHOTOS_GRID_COLUMN_NUM + 1;
    
    return rowNum * (photoWidth  + DOPTL_PHOTOS_GRID_PADDING ) - DOPTL_PHOTOS_GRID_PADDING;
    
}

- (CGFloat) captionHeight
{
    CGFloat width = self.width - DOPTL_CAPTION_MARGIN_LEFT - DOPTL_CAPTION_MARGIN_RIGHT;
    
    return [self textRectHeight:self.post.caption font:[UIFont captionFont] width:width];
}


- (CGFloat) textRectHeight:(NSString *)text font:(UIFont *)font width:(CGFloat)width
{
    CGSize sizeMax = (CGSize) {
        .width = width,
        .height = CGFLOAT_MAX
    };
    NSDictionary *attr = @{NSFontAttributeName: [UIFont captionFont]};
    CGSize size = [self.post.caption boundingRectWithSize:sizeMax
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attr
                                                  context:nil].size;
    return ceil(size.height);
}

@end
