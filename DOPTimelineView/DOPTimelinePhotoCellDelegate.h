//
//  DOPTimelinePhotoCellDelegate.h
//  Pods
//
//  Created by Yongwei Dou on 2014/04/10.
//
//

#import <Foundation/Foundation.h>

@protocol DOPTimelinePhotoCellDelegate <NSObject>

- (void) didPhotosTapped:(UIGestureRecognizer *) gesture
               photoUrls:(NSArray *) photoUrls
                   tapAt:(NSInteger) idx;

@end
