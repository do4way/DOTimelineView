//
//  DOPTimelineCellPhotos.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "DOPTimelineCellPhotos.h"
#import "DOPhoto.h"
#import "DOPImageLoader.h"

static CGFloat const PHOTO_CELL_PADDING = 8.0f;
static NSString *const PHOTO_PLACEHOLDER = @"photo_placeholder";

@interface DOPTimelineCellPhotos()

@property (nonatomic,strong) NSArray *photos;
@property (nonatomic,strong) NSMutableArray *imageViewers;

@end

@implementation DOPTimelineCellPhotos

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewers = [[NSMutableArray alloc] initWithCapacity:9];
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    NSLog(@"===update photos constraints");
    NSInteger photosCnt = [self.photos count];
    if (photosCnt == 1) {
        [self updateConstraintsOnlyOne];
    }else {
        [self updateConstraintsInRow];
    }
}


- (void) setPhotos:(NSArray *)photos withFrame:(CGRect) frame
{
    _photos = photos;
    //self.frame = CGRectMake(0,0, frame.size.width, frame.size.height);
    for (DOPhoto *photo in self.photos)
    {
        NSInteger tag = 0;
        UIImageView *imageView = [UIImageView newAutoLayoutView];
        imageView.tag = tag++;
        [self addSubview:imageView];
        [self.imageViewers addObject:imageView];
        [imageView setImageWithURL:photo.thumbUrl
                  placeholderImage:[UIImage imageNamed:PHOTO_PLACEHOLDER]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
    }
    
}

- (void) prepareForReuse
{
    for (UIView *view in [self subviews]) {
        
        [view removeFromSuperview];
    }
    self.imageViewers = [[NSMutableArray alloc] initWithCapacity:9];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    
}

#pragma mark - update constraints for differect situation

- (void) updateConstraintsOnlyOne
{
    CGFloat deviceWidth = [self currentScreenBoundsDependOnOrientation].size.width;
    CGFloat height = deviceWidth * 3.0f / 4.0f;
    UIImageView *imageView = [self.imageViewers firstObject];
    [imageView autoRemoveConstraintsAffectingViewAndSubviews];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [imageView autoSetDimension:ALDimensionWidth toSize:deviceWidth];
    [imageView autoSetDimension:ALDimensionHeight  toSize:height];
    
}

- (void) updateConstraintsInRow
{
    CGFloat deviceWidth = [self currentScreenBoundsDependOnOrientation].size.width;
    
    CGFloat width = ( deviceWidth - 2 * PHOTO_CELL_PADDING ) / 3.0f;
    CGSize photoSize = (CGSize) {
        .width = width,
        .height = width
    };
    NSLog(@"Photo size: %f, %f", photoSize.width, photoSize.height);
    NSInteger cnt = [self.photos count];
    NSInteger icnt = ceil(cnt / 3.0f) ;
    for (NSInteger i= 0; i<icnt; i++) {
        for (NSInteger j=0; j<3; j++) {
            NSInteger idx = i * 3 +  j;
            if (idx > cnt - 1)
                return;
            CGRect frame = CGRectMake(j * (photoSize.width + PHOTO_CELL_PADDING),
                                     i * (photoSize.height + PHOTO_CELL_PADDING),
                                     photoSize.width,
                                     photoSize.height);
            
            [self updatePhotoConstraintsAtIndex:idx
                                      withFrame:frame];
            
        }
    
    }
    
}

- (void) updatePhotoConstraintsAtIndex: (NSInteger) idx withFrame: (CGRect)frame
{
    UIImageView *imageView = [self.imageViewers objectAtIndex:idx];
    
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [imageView autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    [imageView autoRemoveConstraintsAffectingViewAndSubviews];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:frame.origin.y];
    [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:frame.origin.x];
    
    [imageView autoSetDimension:ALDimensionWidth toSize:frame.size.width];
    [imageView autoSetDimension:ALDimensionHeight toSize:frame.size.height];
    
}

- (CGRect) currentScreenBoundsDependOnOrientation
{
    
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
}

@end
