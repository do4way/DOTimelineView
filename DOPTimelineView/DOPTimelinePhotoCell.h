//
//  DOPTimelineCellPhotos.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/02.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOPhoto;
@protocol DOPTimelineGestureHandler;

@interface DOPTimelinePhotoCell : UITableViewCell

@property (nonatomic,weak) id<DOPTimelineGestureHandler> gestureHandler;
- (void) setPhoto:(DOPhoto *)photo;

@end
