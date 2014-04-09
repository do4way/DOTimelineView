//
//  BSLTimelineViewController.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DOPostsLoaderDelegate;
@protocol DOPTimelineGestureHandler;

@interface DOPTimelineViewController : UITableViewController

@property (nonatomic, weak) id<DOPostsLoaderDelegate> dataLoader;
@property (nonatomic, weak) id<DOPTimelineGestureHandler> gestureHandler;

@end
