//
//  DOPTimelineCellLayout.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/03.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DOPost;

/** --------------------------------------------
 *   Timeline Header Layout
 *  --------------------------------------------*/
extern CGFloat  const DOPTL_HEADER_HEIGHT;
extern CGFloat  const DOPTL_AVATOR_MARGIN_TOP;
extern CGFloat  const DOPTL_AVATOR_MARGIN_LEFT;
extern CGFloat  const DOPTL_AVATOR_WIDTH;
extern CGFloat  const DOPTL_AVATOR_HEIGHT;
extern CGFloat  const DOPTL_USERNAME_MARGIN_RELATED_RIGHT;
extern CGFloat  const DOPTL_USERNAME_MARGIN_RELATED_LEFT;
extern CGFloat  const DOPTL_USERNAME_FONT_SIZE;
extern CGFloat  const DOPTL_UPDATETIME_MARGIN_RIGHT;
extern CGFloat  const DOPTL_UPDATETIME_FONT_SIZE;
extern CGFloat  const DOPTL_TIMERICON_MARGIN_RELATED_RIGHT;
extern CGFloat  const DOPTL_TIMERICON_WIDTH;
extern CGFloat  const DOPTL_TIMERICON_HEIGHT;


/** ------------------------------------------
 *    Timeline photos Layout
 *  ------------------------------------------*/
extern CGFloat  const DOPTL_PHOTOS_MARGIN_TOP;
extern CGFloat  const DOPTL_PHOTOS_MARGIN_LEFT;
extern CGFloat  const DOPTL_PHOTOS_MARGIN_RIGHT;
extern CGFloat  const DOPTL_SINGLE_PHOTO_ASPECTRADIO;
extern CGFloat  const DOPTL_PHOTOS_GRID_PADDING;
extern NSInteger  const DOPTL_PHOTOS_GRID_COLUMN_NUM;
extern NSInteger  const DOPTL_PHOTOS_GRID_ROW_NUM;

/** ------------------------------------------
 *    Timeline caption Layout
 *  ------------------------------------------*/

extern CGFloat  const DOPTL_CAPTION_MARGIN_TOP;
extern CGFloat  const DOPTL_CAPTION_MARGIN_LEFT;
extern CGFloat  const DOPTL_CAPTION_MARGIN_RIGHT;
extern CGFloat  const DOPTL_CAPTION_FONT_SIZE;

/** ------------------------------------------
 *    Timeline likedBy Layout
 *  ------------------------------------------*/
extern CGFloat  const DOPTL_LIKEDBY_ICON_MARGIN_TOP;
extern CGFloat  const DOPTL_LIKEDBY_ICON_MARGIN_LEFT;
extern CGFloat  const DOPTL_LIKEDBY_ICON_WIDTH;
extern CGFloat  const DOPTL_LIKEDBY_ICON_HEIGHT;
extern CGFloat  const DOPTL_LIKEDBY_TEXT_MARGIN_RELATED_LEFT;
extern CGFloat  const DOPTL_LIKEDBY_TEXT_MARGIN_RIGHT;
extern CGFloat  const DOPTL_LIKEDBY_TEXT_FONT_SIZE;
extern CGFloat  const DOPTL_LIKEDBY_TEXT_HEIGHT;

/** ------------------------------------------
 *    Timeline Comment Layout
 *  ------------------------------------------*/
extern CGFloat  const DOPTL_COMMENT_USERNAME_MARGIN_TOP;
extern CGFloat  const DOPTL_COMMENT_USERNAME_MARGIN_LEFT;
extern CGFloat  const DOPTL_COMMENT_USERNAME_HEIGHT;
extern CGFloat  const DOPTL_COMMENT_UNC_SPEPARATOR_MARGIN_RELATED_LEFT;
extern CGFloat  const DOPTL_COMMENT_UNC_SPEPARATOR_WIDTH;
extern NSString *const DOPTL_COMMENT_UNC_SPEPARATOR_STRING;
extern CGFloat  const DOPTL_COMMENT_CONTENT_MARGIN_RELATED_LEFT;
extern CGFloat  const DOPTL_COMMENT_CONTENT_MARGING_RIGHT;
extern CGFloat  const DOPTL_COMMENT_USERNAME_FONT_SIZE;
extern CGFloat  const DOPTL_COMMENT_CONTENT_FONT_SIZE;

/** ------------------------------------------
 *    Timeline Command Layout
 *  ------------------------------------------*/

extern CGFloat  const DOPTL_COMMAND_LIKEBTN_MARGIN_TOP;
extern CGFloat  const DOPTL_COMMAND_LIKEBTN_MARGIN_LEFT;
extern CGFloat  const DOPTL_COMMAND_LIKEBTN_WIDTH;
extern CGFloat  const DOPTL_COMMAND_LIKEBTN_HEIGHT;
extern CGFloat  const DOPTL_COMMAND_LIKEBTN_FONT_SIZE;
extern CGFloat  const DOPTL_COMMAND_COMMENTBTN_MARGIN_RELATED_LEFT;
extern CGFloat  const DOPTL_COMMAND_COMMENTBTN_WIDTH;
extern CGFloat  const DOPTL_COMMAND_COMMENTBTN_HEIGHT;
extern CGFloat  const DOPTL_COMMAND_COMMENTBTN_FONT_SIZE;
extern CGFloat  const DOPTL_COMMAND_COMMENT_NUM_MARGIN_RIGHT;
extern CGFloat  const DOPTL_COMMAND_COMMENT_NUM_FONT_SIZE;
extern CGFloat  const DOPTL_COMMAND_COMMENT_ICON_MARGIN_RELATED_RIGHT;
extern CGFloat  const DOPTL_COMMAND_COMMENT_ICON_WIDTH;
extern CGFloat  const DOPTL_COMMAND_COMMENT_ICON_HEIGHT;
extern CGFloat  const DOPTL_COMMAND_LIKED_NUM_MARGIN_RELATED_RIGHT;
extern CGFloat  const DOPTL_COMMAND_LIKED_NUM_FONT_SIZE;
extern CGFloat  const DOPTL_COMMAND_LIKED_ICON_MARGIN_RELATED_RIGHT;
extern CGFloat  const DOPTL_COMMAND_LIKED_ICON_WIDTH;
extern CGFloat  const DOPTL_COMMAND_LIKED_ICON_HEIGHT;

/** ----------------------------------------
 *    Localizable table name
 *  ----------------------------------------*/
extern NSString *const DOPTL_LOCALIZABLE_STRING_TABLE_NAME;



@interface UIColor(DOPTimeline)

+ (UIColor *) userNameTextColor;
+ (UIColor *) updateTimeTextColor;
+ (UIColor *) captionTextColor;
+ (UIColor *) likedByTextColor;
+ (UIColor *) commentedUserNameTextColor;
+ (UIColor *) commentContentTextColor;
+ (UIColor *) likeBtnTextColor;
+ (UIColor *) likedNumTextColor;
+ (UIColor *) commentBtnTextColor;
+ (UIColor *) commentedNumTextColor;
+ (UIColor *) btnBackgroundColor;
@end

@interface UIFont(DOPTimeline)

+ (UIFont *) userNameFont;
+ (UIFont *) updateTimeFont;
+ (UIFont *) captionFont;
+ (UIFont *) likedByTextFont;
+ (UIFont *) commentedUserNameFont;
+ (UIFont *) commentContentFont;
+ (UIFont *) likeBtnTextFont;
+ (UIFont *) commentBtnTextFont;
+ (UIFont *) likedNumTextFont;
+ (UIFont *) commentedNumTextFont;

@end

@interface UIImage(DOPTimeline)

+ (UIImage *) timerIcon;
+ (UIImage *) likeIcon;
+ (UIImage *) commentIcon;

@end

@interface DOPTLocalizableString : NSObject

+ (NSString*) likeBtnText;
+ (NSString*) likeBtnEnabledText;
+ (NSString*) commentBtnText;

@end

@interface DOPTimelineAppearance : NSObject

- (instancetype) initWithDOPost:(DOPost *) post;
- (instancetype) initWithDOPost:(DOPost *) post width:(CGFloat)width;


- (CGFloat) heightOfPartIndex: (NSInteger) idx;


@end
