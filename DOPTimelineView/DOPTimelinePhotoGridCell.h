//
//  DOPTimelinePhotoGridCell.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/07.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DOPhoto;
@protocol DOPTimelinePhotoCellDelegate;

@interface DOPTimelinePhotoGridCell : UITableViewCell

@property (nonatomic,weak) id<DOPTimelinePhotoCellDelegate> delegate;
- (void) setPhotos:(NSArray *) photos;

@end

