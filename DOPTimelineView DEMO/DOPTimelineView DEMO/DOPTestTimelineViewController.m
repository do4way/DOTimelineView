//
//  DOPTestTimelineViewController.m
//  DOPTimelineView DEMO
//
//  Created by Yongwei Dou on 2014/04/09.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTestTimelineViewController.h"
#import "DOPTimelineViewController.h"
#import "DOPhotoViewerProtocols.h"
#import "DOPTimelineProtocols.h"

@interface DOPTestTimelineViewController () <DOPTimelineGestureHandler,DOPhotoViewerDataSource> 

@property (nonatomic,strong) NSArray *photoUrls;
@property (nonatomic,assign) NSInteger idx;

@end

@implementation DOPTestTimelineViewController


- (void) viewDidLoad {
    
   [self setGestureHandler:self];
    [super viewDidLoad];
}

- (void) onPhotosDoubleTapped:(NSArray *)photoUrls startAt:(NSInteger)idx
{
    NSLog(@"photo tapped: %@, startAt:%d", photoUrls,idx);
    self.photoUrls = photoUrls;
    self.idx = idx;
    [self performSegueWithIdentifier:@"MySegue" sender:self];
}

#pragma mark - DOPhotoViewer data source
- (NSUInteger) numberOfPhotos
{
    return [self.photoUrls count];
    
}

- (NSURL *) photoUrlAtIndex:(NSUInteger) idx;
{
    
    return [NSURL URLWithString:[self.photoUrls objectAtIndex:idx]];
}


- (NSUInteger) startAtPage;
{
    
    return self.idx;
}


@end
