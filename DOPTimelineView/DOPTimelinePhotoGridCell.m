//
//  DOPTimelinePhotoGridCell.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "DOPTimelinePhotoGridCell.h"
#import "DOPTimelineAppearance.h"
#import "DOPApplicationUtils.h"
#import "DOPTimelinePhotoCellDelegate.h"
#import "DOPhoto.h"

static NSString *const PHOTO_PLACEHOLDER = @"photo_placeholder";

@interface DOPTimelinePhotoGridCell()

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSMutableArray *photoViews;
@property (nonatomic, assign) BOOL didConstraintsUpdated;
@end

@implementation DOPTimelinePhotoGridCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger cnt = DOPTL_PHOTOS_GRID_COLUMN_NUM * DOPTL_PHOTOS_GRID_ROW_NUM;
        self.photoViews = [[NSMutableArray alloc] initWithCapacity:cnt];
        for ( NSInteger i = 0; i<cnt; i++ ) {
            UIImageView *imageView = [UIImageView newAutoLayoutView];
            [imageView setClipsToBounds:YES];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            [imageView setTag:i ];
            [self.photoViews addObject:imageView];
            [self.contentView addSubview:imageView];
            [imageView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self
                                                          action:@selector(onTapGesture:)];
            [tapGesture setNumberOfTapsRequired:1];
            [imageView addGestureRecognizer:tapGesture];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChanged:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:Nil];
        
        
        
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    if (self.didConstraintsUpdated) return;
    
    CGFloat cellWidth = [DOPApplicationUtils currentScreenDependsOrientation].size.width ;
    CGFloat photoWidth = (cellWidth - ( DOPTL_PHOTOS_GRID_COLUMN_NUM - 1 ) * DOPTL_PHOTOS_GRID_PADDING ) / DOPTL_PHOTOS_GRID_COLUMN_NUM;
    NSInteger cnt = DOPTL_PHOTOS_GRID_COLUMN_NUM * DOPTL_PHOTOS_GRID_ROW_NUM;
    for ( NSInteger i=0; i<cnt; i++) {
        NSInteger row = i  / DOPTL_PHOTOS_GRID_COLUMN_NUM ;
        NSInteger column = i % DOPTL_PHOTOS_GRID_COLUMN_NUM;
        CGRect frame = CGRectMake(column * ( photoWidth + DOPTL_PHOTOS_GRID_PADDING),
                                  row * (photoWidth + DOPTL_PHOTOS_GRID_PADDING),
                                  photoWidth, photoWidth);
        UIImageView *imageView = [self.photoViews objectAtIndex:i];
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [imageView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        }];
        [imageView autoRemoveConstraintsAffectingViewAndSubviews];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:frame.origin.y];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:frame.origin.x];
        
        [imageView autoSetDimension:ALDimensionWidth toSize:frame.size.width];
        [imageView autoSetDimension:ALDimensionHeight toSize:frame.size.height];
    }
    
    self.didConstraintsUpdated = YES;
    
    
    
}


- (void) setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSInteger cnt = [self photoCount];
    for ( NSInteger i=0; i<cnt; i++) {
        DOPhoto *photo = [photos objectAtIndex:i];
        UIImageView *imageView = [self.photoViews objectAtIndex:i];
        [imageView setImageWithURL:photo.thumbUrl placeholderImage:[UIImage imageNamed:PHOTO_PLACEHOLDER ]];
    }
}

- (void) onDeviceOrientationChanged:(NSNotification *) notification
{
    self.didConstraintsUpdated = NO;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

- (void) onTapGesture:(UIGestureRecognizer *) gesture
{
    NSMutableArray *photoUrls = [[NSMutableArray alloc]initWithCapacity:[self photoCount]];
    if ( self.delegate && gesture.state == UIGestureRecognizerStateEnded ) {
        NSInteger idx = gesture.view.tag;
        NSInteger cnt = [self photoCount];
        photoUrls = [[NSMutableArray alloc] initWithCapacity:cnt];
        for (NSInteger i = 0; i<cnt; i++) {
            DOPhoto *photo = [self.photos objectAtIndex:i ];
            [photoUrls addObject:photo.url];
        }
        
        if ( [self.delegate respondsToSelector:@selector(didPhotosTapped:photoUrls:tapAt:)]) {
            
            [self.delegate didPhotosTapped:gesture photoUrls:photoUrls tapAt:idx];
        }
    
    }
    
}

- (NSInteger) photoCount
{
    return MIN([self.photos count], [self.photoViews count]);
}

@end
