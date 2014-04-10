//
//  DOPTimelineCellPhotos.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "DOPTimelinePhotoCell.h"
#import "DOPTimelineAppearance.h"
#import "DOPTimelinePhotoCellDelegate.h"
#import "DOPhoto.h"

static NSString *const PHOTO_PLACEHOLDER = @"photo_placeholder";

@interface DOPTimelinePhotoCell() 

@property (nonatomic,strong) DOPhoto *photo;
@property (nonatomic,strong) UIImageView *photoView;
@property (nonatomic,assign) BOOL didConstraintsUpdated;
@end

@implementation DOPTimelinePhotoCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoView = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:self.photoView];
        [self.photoView setClipsToBounds:YES];
        [self.photoView setContentMode:UIViewContentModeScaleAspectFill];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
        
        [tapGesture setNumberOfTapsRequired:1];
        [tapGesture setDelegate:self];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
    
}


- (void) updateConstraints
{
    [super updateConstraints];
    if ( _didConstraintsUpdated ) return;
    [self.photoView autoRemoveConstraintsAffectingView];
    [self.photoView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_PHOTOS_MARGIN_TOP];
    [self.photoView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_PHOTOS_MARGIN_LEFT];
    [self.photoView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:DOPTL_PHOTOS_MARGIN_RIGHT];
    [self.photoView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    //CGFloat width = [self contentView].bounds.size.width;
    //[self.photoView autoSetDimension:ALDimensionHeight toSize:width * DOPTL_SINGLE_PHOTO_ASPECTRADIO ];
    _didConstraintsUpdated = YES;
    
}


- (void) setPhoto:(DOPhoto *)photo
{
    _photo = photo;
    [self.photoView setImageWithURL:_photo.thumbUrl placeholderImage:[UIImage imageNamed:PHOTO_PLACEHOLDER]];
}


- (void) onTapGesture:(UIGestureRecognizer *) gesture
{
    if ( self.delegate && gesture.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(didPhotosTapped:photoUrls:tapAt:)]){
           [self.delegate didPhotosTapped:gesture
                                photoUrls:[NSArray arrayWithObject:self.photo.url]
                                    tapAt:0];
        }
    }
    
}

@end
