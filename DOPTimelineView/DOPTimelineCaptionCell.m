//
//  DOPTimelineCaptionCell.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCaptionCell.h"
#import "DOPTimelineAppearance.h"

@interface DOPTimelineCaptionCell ()

@property (nonatomic,strong) UILabel *captionLabel;
@property (nonatomic,assign) BOOL didConstraintsUpdated;
@end

@implementation DOPTimelineCaptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.captionLabel = [UILabel newAutoLayoutView];
        [self.captionLabel setTextColor:[UIColor captionTextColor]];
        [self.captionLabel setFont:[UIFont captionFont]];
        [self.captionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.captionLabel setNumberOfLines:0];
        [self.contentView addSubview:self.captionLabel];
    }
    return self;
}


- (void) updateConstraints
{
    [super updateConstraints];
    if ( self.didConstraintsUpdated ) return;
    /*[UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.captionLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisVertical];
        
    }];*/
    [self.captionLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_CAPTION_MARGIN_TOP];
    [self.captionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_CAPTION_MARGIN_LEFT];
    [self.captionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:DOPTL_CAPTION_MARGIN_RIGHT];
    
    self.didConstraintsUpdated = YES;
    
}

- (void) prepareForReuse
{
    self.captionLabel.text = nil;
}
- (void) setCaption:(NSString *)caption
{
    [self.captionLabel setText:caption];
}


@end
