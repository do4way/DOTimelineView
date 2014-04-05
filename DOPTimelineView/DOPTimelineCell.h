//
//  BSLPhotoTimelineCell.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/13.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DOPost, DOPTimelineCellLayout;

@interface DOPTimelineCell : UITableViewCell

@property (nonatomic,strong) DOPost* userPost;

- (void) setUserPost: (DOPost*) post withLayout:(DOPTimelineCellLayout *) layout;

@end
