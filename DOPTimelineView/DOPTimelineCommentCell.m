//
//  DOPTimelineCommentCell.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCommentCell.h"
#import "DOPTimelineAppearance.h"
#import "DOPComment.h"

@interface DOPTimelineCommentCell ()

@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *separator;
@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,assign) BOOL didConstraintsUpdated;

@end
@implementation DOPTimelineCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userName = [UILabel newAutoLayoutView];
        self.separator = [UILabel newAutoLayoutView];
        self.separator.text = DOPTL_COMMENT_UNC_SPEPARATOR_STRING;
        self.commentLabel = [UILabel newAutoLayoutView];
        
        [self.userName setTextColor:[UIColor commentedUserNameTextColor]];
        [self.separator setTextColor:[UIColor commentedUserNameTextColor]];
        [self.commentLabel setTextColor:[UIColor commentContentTextColor]];
        
        [self.userName setFont:[UIFont commentedUserNameFont]];
        [self.separator setFont: [UIFont commentedUserNameFont]];
        [self.commentLabel setFont:[UIFont commentContentFont]];
        
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.separator];
        [self.contentView addSubview:self.commentLabel];
        
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    if (self.didConstraintsUpdated) return;
    
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_COMMENT_USERNAME_MARGIN_TOP];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_COMMENT_USERNAME_MARGIN_LEFT];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.separator autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
        [self.userName autoSetContentHuggingPriorityForAxis:ALAxisHorizontal];
    }];
    [self.separator autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userName withOffset:DOPTL_COMMENT_UNC_SPEPARATOR_MARGIN_RELATED_LEFT];
    [self.separator autoSetDimension:ALDimensionWidth toSize:DOPTL_COMMENT_UNC_SPEPARATOR_WIDTH];
    [self.separator autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userName];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.commentLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    [self.commentLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.separator withOffset:DOPTL_COMMENT_CONTENT_MARGIN_RELATED_LEFT];
    [self.commentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:ALEdgeRight];
    [self.commentLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userName];
    
    self.didConstraintsUpdated = YES;
}

- (void) setComment:(DOPComment *)comment
{
    self.userName.text = comment.userName;
    self.commentLabel.text = comment.commentText;
}

@end
