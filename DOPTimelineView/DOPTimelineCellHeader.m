//
//  DOPTimelineCellHeader.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCellHeader.h"
#import "DOPImageLoader.h"

const static CGFloat AVATOR_MARGIN_TOP = 0.0f;
const static CGFloat AVATOR_MARGIN_LEFT = 10.0f;
const static CGFloat USERNAME_MARGIN_TOP = 10.0f;
const static CGFloat USERNAME_MARGIN_LEFT = 55.0f;
const static CGFloat TIMER_MARGIN_TOP = 13.5f;
const static CGFloat TIMER_MARGIN_RIGHT = -2.0f;
const static CGFloat UPDATETIME_MARGIN_TOP = 11.5f;
const static CGFloat UPDATETIME_MARGIN_RIGHT = 15.0f;
static NSString *timerIconName = @"timer";

@interface DOPTimelineCellHeader()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation DOPTimelineCellHeader

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.avatar = [UIImageView newAutoLayoutView];
        self.userName = [UILabel newAutoLayoutView];
        [self.userName setTextColor:[UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.0f]];
        [self.userName setFont: [UIFont boldSystemFontOfSize:14]];
        
        self.timer = [UIImageView newAutoLayoutView];
        [self.timer setBackgroundColor:[UIColor clearColor]];
        UIImage *timer = [UIImage imageNamed:timerIconName];
        [self.timer setImage:timer];
        self.updateTime = [UILabel newAutoLayoutView];
        [self.updateTime setTextColor:[UIColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
        [self.updateTime setFont:[UIFont systemFontOfSize:11]];
        [self addSubview:self.avatar];
        [self addSubview:self.userName];
        [self addSubview:self.timer];
        [self addSubview:self.updateTime];
        
    }
    return self;
}

- (void) updateConstraints
{
    [super updateConstraints];
    
    
    if (self.didSetupConstraints)
        return;
    
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:AVATOR_MARGIN_TOP ];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:AVATOR_MARGIN_LEFT ];
    [self.avatar autoSetDimension:ALDimensionWidth toSize:35.0f];
    [self.avatar autoSetDimension:ALDimensionHeight toSize:35.0f];
    
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:USERNAME_MARGIN_TOP];
    [self.userName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:USERNAME_MARGIN_LEFT];
    
    [self.updateTime autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:UPDATETIME_MARGIN_TOP];
    [self.updateTime autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:UPDATETIME_MARGIN_RIGHT];
    
    [self.timer autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:TIMER_MARGIN_TOP];
    [self.timer autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.updateTime withOffset:TIMER_MARGIN_RIGHT];
    [self.timer autoSetDimension:ALDimensionWidth toSize:10];
    [self.timer autoSetDimension:ALDimensionHeight toSize:10];
    
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
