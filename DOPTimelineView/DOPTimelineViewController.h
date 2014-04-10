//
//  BSLTimelineViewController.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DOPostsLoaderDelegate;
@protocol DOPTimelineDelegate;

static NSString *const kSEGUE_FORWARDNAME = @"DOPTimelineSegueForward";

@interface DOPTimelineViewController : UITableViewController

@property (nonatomic, weak) IBOutlet id<DOPostsLoaderDelegate> dataLoader;
@property (nonatomic, weak) IBOutlet id<DOPTimelineDelegate> delegate;

- (IBAction) segueBackToTimeline:(UIStoryboardSegue *)sender;

@end
