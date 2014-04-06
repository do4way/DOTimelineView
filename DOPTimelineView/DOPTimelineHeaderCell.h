//
//  DOPTimelineCellHeader.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOPTimelineHeaderCell : UITableViewCell



- (void) setHeaderWithAvatarUrl:(NSURL *) url
                       userName:(NSString *) userName
                     updateTime:(NSString *) time;

@end
