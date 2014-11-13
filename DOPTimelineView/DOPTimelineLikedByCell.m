//
//  DOPTimelineLikeByCell.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIView+AutoLayout.h>
#import "DOPTimelineLikedByCell.h"
#import "DOPTimelineAppearance.h"

@interface DOPTimelineLikedByCell ()

@property (nonatomic,strong) UIImageView *likedByIcon;
@property (nonatomic,strong) UILabel *likedByText;
@property (nonatomic,assign) BOOL didConstraintsUpdated;
@end

@implementation DOPTimelineLikedByCell

- (instancetype)initWithStyle:(UITableViewCellStyle) style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.likedByIcon = [UIImageView newAutoLayoutView];
        self.likedByIcon.image = [UIImage likeIcon];
        
        self.likedByText = [UILabel newAutoLayoutView];
        [self.likedByText setTextColor: [UIColor likedByTextColor]];
        [self.likedByText setFont: [UIFont likedByTextFont]];
        [self.likedByText setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.likedByText setNumberOfLines:1];
        
        [self.contentView addSubview:self.likedByIcon];
        [self.contentView addSubview:self.likedByText];
        
        [self setupConstraints];
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    if (self.didConstraintsUpdated ) return;
    
    [self setupConstraints];

}


- (void) setLikedBy:(NSString *)likedBy
{
    [self.likedByText setText:likedBy];
}

#pragma mark - private method
-(void) setupConstraints
{
    
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.likedByIcon autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.likedByText autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    [self.likedByIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_LIKEDBY_ICON_MARGIN_TOP];
    [self.likedByIcon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_LIKEDBY_ICON_MARGIN_LEFT];
    
    [self.likedByText autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.likedByIcon withOffset:DOPTL_LIKEDBY_TEXT_MARGIN_RELATED_LEFT];
    [self.likedByText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:DOPTL_LIKEDBY_TEXT_MARGIN_RIGHT];
    [self.likedByText autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likedByIcon];
    
    self.didConstraintsUpdated = YES;
    
}

@end
