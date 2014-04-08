//
//  DOPTimelineCellHeader.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineHeaderCell.h"
#import "DOPTimelineAppearance.h"
#import "DOPImageLoader.h"


@interface DOPTimelineHeaderCell()

@property (nonatomic,strong) IBOutlet UIImageView *avatar;
@property (nonatomic,strong) IBOutlet UILabel     *userName;
@property (nonatomic,strong) IBOutlet UIImageView *timerIcon;
@property (nonatomic,strong) IBOutlet UILabel     *updateTime;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation DOPTimelineHeaderCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatar = [UIImageView newAutoLayoutView];
        [self.avatar setClipsToBounds:YES];
        
        self.userName = [UILabel newAutoLayoutView];
        [self.userName setTextColor:[UIColor userNameTextColor]];
        [self.userName setFont:[UIFont userNameFont]];
        
        self.timerIcon = [UIImageView newAutoLayoutView];
        [self.timerIcon setImage:[UIImage timerIcon]];
        [self.timerIcon setClipsToBounds:YES];
        
        self.updateTime = [UILabel newAutoLayoutView];
        [self.updateTime setTextColor:[UIColor updateTimeTextColor]];
        [self.updateTime setFont:[UIFont updateTimeFont]];
        
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.timerIcon];
        [self.contentView addSubview:self.updateTime];
        
    }
    return self;
}

- (void) prepareForReuse
{
    self.userName.text = nil;
    self.updateTime.text = nil;
    
}

- (void) updateConstraints
{
    [super updateConstraints];
    
    if (self.didSetupConstraints)
        return;
    
    [UIView autoSetPriority:UILayoutPriorityDefaultHigh forConstraints:^{
        [self.updateTime autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    
    }];
    [UIView autoSetPriority:UILayoutPriorityDefaultLow forConstraints:^{
        [self.userName autoSetContentCompressionResistancePriorityForAxis:ALAxisHorizontal];
    
    }];
    
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:DOPTL_AVATOR_MARGIN_TOP];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:DOPTL_AVATOR_MARGIN_LEFT];
    [self.avatar autoSetDimension:ALDimensionWidth toSize:DOPTL_AVATOR_WIDTH];
    [self.avatar autoSetDimension:ALDimensionHeight toSize:DOPTL_AVATOR_HEIGHT];
    
    [self.userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatar withOffset:DOPTL_USERNAME_MARGIN_RELATED_LEFT];
    [self.userName autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.timerIcon withOffset:DOPTL_USERNAME_MARGIN_RELATED_RIGHT];
    
    [self.updateTime autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.updateTime autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:DOPTL_UPDATETIME_MARGIN_RIGHT];
    
    
    [self.timerIcon autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.avatar];
    [self.timerIcon autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.updateTime withOffset:DOPTL_TIMERICON_MARGIN_RELATED_RIGHT];
    [self.timerIcon autoSetDimension:ALDimensionWidth toSize:10];
    [self.timerIcon autoSetDimension:ALDimensionHeight toSize:10];
    
    self.didSetupConstraints = YES;
    
}

- (void) setHeaderWithAvatarUrl:(NSURL *)url userName:(NSString *)userName updateTime:(NSString *)time
{
    self.userName.text = userName;
    self.updateTime.text = time;
    [DOPImageLoader loadRoundedImageWithUrl:url
                                 completion:^(UIImage *image, NSError *error){
                                     if (!error) {
                                         self.avatar.image = image;
                                     }
                                 }];
}

@end
