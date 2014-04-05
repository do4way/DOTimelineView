//
//  DOPTimelineCellHeader.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOPTimelineCellHeader : UIView

@property (nonatomic,strong) IBOutlet UIImageView *avatar;
@property (nonatomic,strong) IBOutlet UILabel     *userName;
@property (nonatomic,strong) IBOutlet UIImageView *timer;
@property (nonatomic,strong) IBOutlet UILabel     *updateTime;

- (void) setHeaderWithAvatarUrl:(NSURL *) url
                       userName:(NSString *) userName
                     updateTime:(NSString *) time;

@end
