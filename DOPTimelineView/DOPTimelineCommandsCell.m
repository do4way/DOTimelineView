//
//  DOPTimelineCommandsCell.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCommandsCell.h"
#import "UIView+AutoLayout.h"
#import "DOPTimelineAppearance.h"

@interface DOPTimelineCommandsCell()

@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UILabel *likedNumLabel;
@property (nonatomic,strong) UILabel *commentedNumLabel;
@property (nonatomic,strong) UIImageView *likedIcon;
@property (nonatomic,strong) UIImageView *commentedIcon;
@property (nonatomic,assign) BOOL didConstraintsUpdated;
@property (nonatomic,assign) NSInteger likedByNum;
@property (nonatomic,assign) NSInteger commentedNum;

@end

@implementation DOPTimelineCommandsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.likeBtn = [UIButton newAutoLayoutView];
        self.commentBtn = [UIButton newAutoLayoutView];
        self.likedNumLabel = [UILabel newAutoLayoutView];
        self.likedIcon = [UIImageView newAutoLayoutView];
        self.commentedNumLabel = [UILabel newAutoLayoutView];
        self.commentedIcon = [UIImageView newAutoLayoutView];
        
        [self.likeBtn setTitle:NSLocalizedString(@"Like", nil) forState:UIControlStateNormal];
        [self.likeBtn setTitleColor:[UIColor likeBtnTextColor] forState:UIControlStateNormal];
        [self.likeBtn.titleLabel setFont:[UIFont likeBtnTextFont]];
        [self.likeBtn setBackgroundColor:[UIColor btnBackgroundColor]];
        [self.likeBtn setImage:[UIImage likeIcon] forState:UIControlStateNormal];
        self.likeBtn.contentEdgeInsets = UIEdgeInsetsMake(5.0f,5.0f,5.0f,5.0f);
        
        [self.commentBtn setTitle:NSLocalizedString(@"Comment",nil) forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:[UIColor commentBtnTextColor] forState:UIControlStateNormal];
        [self.commentBtn.titleLabel setFont:[UIFont commentBtnTextFont]];
        [self.commentBtn setBackgroundColor:[UIColor btnBackgroundColor]];
        [self.commentBtn setImage:[UIImage commentIcon] forState:UIControlStateNormal];
        self.commentBtn.contentEdgeInsets = UIEdgeInsetsMake(5.0f,5.0f,5.0f,5.0f);
        
        [self.likedNumLabel setTextColor:[UIColor likedNumTextColor]];
        [self.likedNumLabel setFont:[UIFont likedNumTextFont]];
        
        [self.commentedNumLabel setTextColor:[UIColor commentedNumTextColor]];
        [self.commentedNumLabel setFont:[UIFont commentedNumTextFont]];
        
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.likedNumLabel];
        [self.contentView addSubview:self.likedIcon];
        [self.contentView addSubview:self.commentedNumLabel];
        [self.contentView addSubview:self.commentedIcon];
        
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    if (self.didConstraintsUpdated) return;
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.likeBtn autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
        [self.commentBtn autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.likedNumLabel autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    }];
    [self.likeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_COMMAND_LIKEBTN_MARGIN_TOP];
    [self.likeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_COMMAND_LIKEBTN_MARGIN_LEFT];
    //[self.likeBtn autoSetDimension:ALDimensionWidth toSize:DOPTL_COMMAND_LIKEBTN_WIDTH];
    [self.likeBtn autoSetDimension:ALDimensionHeight toSize:DOPTL_COMMAND_LIKEBTN_HEIGHT];
    
    [self.commentBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeBtn];
    [self.commentBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.likeBtn withOffset:DOPTL_COMMAND_COMMENTBTN_MARGIN_RELATED_LEFT];
    //[self.commentBtn autoSetDimension:ALDimensionWidth toSize:DOPTL_COMMAND_COMMENTBTN_WIDTH];
    [self.commentBtn autoSetDimension:ALDimensionHeight toSize:DOPTL_COMMAND_COMMENTBTN_HEIGHT];
    
    [self.commentedNumLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:DOPTL_COMMAND_COMMENT_NUM_MARGIN_RIGHT];
    [self.commentedNumLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeBtn];
    [self.commentedIcon autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.commentedNumLabel withOffset:DOPTL_COMMAND_COMMENT_ICON_MARGIN_RELATED_RIGHT];
    [self.commentedIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeBtn];
    
    [self.likedNumLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.commentedIcon withOffset:DOPTL_COMMAND_LIKED_NUM_MARGIN_RELATED_RIGHT];
    [self.likedNumLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeBtn];
    
    [self.likedIcon autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.likedNumLabel withOffset:DOPTL_COMMAND_LIKED_ICON_MARGIN_RELATED_RIGHT];
    [self.likedIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.likeBtn];
    self.didConstraintsUpdated = YES;
}


-(void) setLikedByNum:(NSInteger)likedByNum commentedNum:(NSInteger)commentedNum
{
    _likedByNum = likedByNum ? likedByNum : 0;
    _commentedNum = commentedNum ? commentedNum : 0;
    [self updateCommentedNum];
    [self updateLikedByNum];
}

-(void) updateLikedByNum
{
    if (_likedByNum > 0 ) {
        self.likedNumLabel.text = [NSString stringWithFormat:@"%d",_likedByNum];
        self.likedIcon.image = [UIImage likeIcon];
        
    }
}

- (void) updateCommentedNum
{
    if (_commentedNum > 0 ) {
        self.commentedNumLabel.text = [NSString stringWithFormat:@"%d",_commentedNum];
        self.commentedIcon.image = [UIImage commentIcon];
        
    }
}

@end
