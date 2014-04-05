//
//  BSLPhotoTimelineCell.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/13.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCell.h"
#import "DOPTimelineCellLayout.h"
#import "DOPTimelineCellHeader.h"
#import "DOPTimelineCellPhotos.h"
#import "DOPTimelineCommentLabel.h"
#import "DOPImageLoader.h"
#import "DOPost.h"
#import "DOPhoto.h"

static CGFloat const PHOTO_CELL_PADDING = 2.0f;



@interface DOPTimelineCell()


@property (nonatomic, strong) IBOutlet DOPTimelineCellHeader *header;
@property (nonatomic, strong) IBOutlet DOPTimelineCellPhotos *photos;
@property (nonatomic, strong) IBOutlet UILabel *caption;
@property (nonatomic, strong) IBOutlet UIImageView *likedByIcon;
@property (nonatomic, strong) IBOutlet UILabel *likedBy;
@property (nonatomic, strong) IBOutlet DOPTimelineCommentLabel *commentsLabel;
@property (nonatomic, strong) DOPTimelineCellLayout *layout;


@end

@implementation DOPTimelineCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"init cell");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.header = [DOPTimelineCellHeader newAutoLayoutView];
        self.photos = [DOPTimelineCellPhotos newAutoLayoutView];
        self.caption = [UILabel newAutoLayoutView];
        self.likedByIcon = [UIImageView newAutoLayoutView];
        self.likedBy = [UILabel newAutoLayoutView];
        self.commentsLabel = [DOPTimelineCommentLabel newAutoLayoutView];
        
        [self.caption setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.caption setNumberOfLines:0];
        [self.caption setTextAlignment:NSTextAlignmentLeft];
        [self.caption setTextColor:[UIColor colorWithRed:0.20f
                                                   green:0.20f
                                                    blue:0.20f
                                                   alpha:1.0f]];
        [self.caption setFont: [UIFont systemFontOfSize:14]];
        [self.caption setHighlighted:YES];
        
        [self.likedByIcon setImage:[UIImage imageNamed:@"likedByIcon"]];
        [self.likedByIcon setClipsToBounds:YES];
        [self.likedByIcon setHidden:YES];
        
        [self.likedBy setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.likedBy setNumberOfLines:1];
        [self.likedBy setTextAlignment:NSTextAlignmentLeft];
        [self.likedBy setTextColor:[UIColor colorWithRed:0.0f green:0.21f blue:0.31f alpha:1.0f]];
        [self.likedBy setFont: [UIFont boldSystemFontOfSize:14]];
        [self.likedBy setHidden:YES];
        
        [self.commentsLabel setHidden:YES];
        
        [self.contentView addSubview:self.header];
        [self.contentView addSubview:self.photos];
        [self.contentView addSubview:self.caption];
        [self.contentView addSubview:self.likedByIcon];
        [self.contentView addSubview:self.likedBy];
        [self.contentView addSubview:self.commentsLabel];
        
    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    [self.photos removeFromSuperview];
    self.photos = [DOPTimelineCellPhotos newAutoLayoutView];
    
    [self.commentsLabel removeFromSuperview];
    self.commentsLabel = [DOPTimelineCommentLabel newAutoLayoutView];
    
    [self.caption setHidden:YES];
    [self.likedByIcon setHidden:YES];
    [self.likedBy setHidden:YES];
    [self.commentsLabel setHidden:YES];
    
    [self.contentView addSubview:self.photos];
    [self.contentView addSubview:self.commentsLabel];
}

- (void) setUserPost:(DOPost *)userPost withLayout:(DOPTimelineCellLayout*) layout
{
    _userPost = userPost;
    _layout = layout;
    NSLog(@"set user post");
    NSLog(@"--%@", self.caption);
    [self.header setHeaderWithAvatarUrl:_userPost.avatarUrl
                          userName:_userPost.userName
                        updateTime:[_userPost timestampAsString]];
    [self.photos setPhotos:userPost.photos
                 withFrame:[self.layout photosRect]];
    if (_userPost.caption) {
        [self.caption setHidden:NO];
        self.caption.text = userPost.caption;
    }
    
    if (_userPost.numLikedBy > 0 ) {
        [self.likedByIcon setHidden:NO];
        [self.likedBy setHidden:NO];
        self.likedBy.text = _userPost.likedBy;
    }
    
    if (_userPost.numCommentedBy > 0 ) {
        [self.commentsLabel setHidden:NO];
        NSInteger len = MIN(1, [_userPost.comments count]);
        [self.commentsLabel setComments:[_userPost.comments subarrayWithRange:NSMakeRange(0,len)]];
    }
    
}

- (void)updateConstraints
{
    [super updateConstraints];
    NSLog(@"update constraints");
    // Note: if the constraints you add below require a larger cell size than the current size (which is likely to be the default size {320, 44}), you'll get an exception.
    // As a fix, you can temporarily increase the size of the cell's contentView so that this does not occur using code similar to the line below.
    //      See here for further discussion: https://github.com/Alex311/TableCellWithAutoLayout/commit/bde387b27e33605eeac3465475d2f2ff9775f163#commitcomment-4633188
    self.contentView.bounds = CGRectMake(0.0f, 0.0f, 99999.0f, 99999.0f);
    
    CGRect hRect = [self.layout headerRect];
    
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:hRect.origin.y];
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:hRect.origin.x];
    [self.header autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self.header autoSetDimension:ALDimensionHeight toSize:hRect.size.height];
    
    
    CGRect pRect = [self.layout photosRect];
    [self.photos autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.header withOffset:3.0f];
    [self.photos autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [self.photos autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    [self.photos autoSetDimension:ALDimensionHeight toSize:pRect.size.height];
    
    CGRect cRect = [self.layout captionRect];
    [self.caption autoRemoveConstraintsAffectingView];
    [self.caption autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.photos withOffset:cRect.origin.y];
    [self.caption autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:cRect.origin.x];
    [self.caption autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:cRect.origin.x];
    [self.caption autoSetDimension:ALDimensionHeight toSize:cRect.size.height];
    
    CGRect likedByIconRect = [self.layout likedByIconRect];
    [self.likedByIcon autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.caption withOffset:likedByIconRect.origin.y];
    [self.likedByIcon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:likedByIconRect.origin.x];
    [self.likedByIcon autoSetDimension:ALDimensionWidth toSize:likedByIconRect.size.width];
    [self.likedByIcon autoSetDimension:ALDimensionHeight toSize:likedByIconRect.size.height];
    
    CGRect likedByTextRect = [self.layout likedByTextRect];
    [self.likedBy autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.caption withOffset:likedByTextRect.origin.y];
    [self.likedBy autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:likedByTextRect.origin.x];
    [self.likedBy autoSetDimension:ALDimensionHeight toSize:likedByTextRect.size.height];
    
    CGRect commentsRect = [self.layout commentsRect];
    [self.commentsLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.likedByIcon withOffset:commentsRect.origin.y];
    [self.commentsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:commentsRect.origin.x];
    [self.commentsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:commentsRect.origin.x];
    [self.commentsLabel autoSetDimension:ALDimensionHeight toSize:commentsRect.size.height];
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
}

#pragma mark - private methods

- (void) aspectFitImage:(UIImage *)image
{
    
}


@end
