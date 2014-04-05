//
//  BSLTimelineViewController.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineViewController.h"
#import "DOPost.h"
#import "DOPostStream.h"
#import "DOPMemoryDataLoader.h"
#import "DOPImageLoader.h"
#import "DOPTimelineCell.h"
#import "DOPTimelineCellLayout.h"

static NSString *const cellReuseIdentifier = @"DOPTimelineCell";

@interface DOPTimelineViewController()

@property (nonatomic,strong) DOPostStream *postStream;
@property (nonatomic,strong) NSMutableDictionary *offscreenCell;

@end

@implementation DOPTimelineViewController

- (instancetype) init
{
    self = [super initWithStyle:UITableViewStylePlain];
    self.offscreenCell = [[NSMutableDictionary alloc] initWithCapacity:3];
    return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[DOPTimelineCell class] forCellReuseIdentifier:@"DOPTimelineCell"];
    self.postStream = [self createPostStream];
    [self.postStream requestMorePosts];
    NSLog(@"Now there are %ld photos in photostream",(long)[self.postStream count]);
    
}

#pragma mark - user interface interative


- (IBAction)onPhotoThumbnailTapped:(UITapGestureRecognizer *)sender {
    
    
}


#pragma mark - table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.postStream count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOPost *post = [self.postStream postAtIndex:indexPath.row];
    DOPTimelineCellLayout *cellLayout = [[DOPTimelineCellLayout alloc] initWithDOPost:post
                                                                            cellWidth:CGRectGetWidth(tableView.bounds)];
    
    return [cellLayout height];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NOTE for iOS 7.0.x ONLY, this bug has been fixed by Apple as of iOS 7.1:
    // A constraint exception will be thrown if the estimated row height for an inserted row is greater
    // than the actual height for that row. In order to work around this, we need to return the actual
    // height for the the row when inserting into the table view - uncomment the below 3 lines of code.
    // See: https://github.com/caoimghgin/TableViewCellWithAutoLayout/issues/6
    //    if (self.isInsertingRow) {
    //        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    //    }
    
    return 300.0f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdendifier = @"DOPTimelineCell";
    DOPTimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdendifier
                                                            forIndexPath:indexPath];
    DOPost *post = [self.postStream postAtIndex:indexPath.row];
    DOPTimelineCellLayout *layout = [[DOPTimelineCellLayout alloc] initWithDOPost:post
                                                                            cellWidth:CGRectGetWidth(tableView.bounds)];
    [cell setUserPost:post withLayout:layout];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.postStream clearData];
    [self.tableView reloadData];
}

#pragma mark - scroll view  delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetWindow = self.tableView.contentOffset.y + self.tableView.bounds.size.height;
    BOOL leachToBottom = contentOffsetWindow >= self.tableView.contentSize.height;
    if (!leachToBottom || self.postStream.loading) return;
    NSLog(@"request more photo");
    [self.postStream requestMorePosts];
    [self.tableView reloadData];
    
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.tableView reloadData];
    
}


#pragma mark - Privates

- (DOPostStream *) createPostStream
{
    DOPMemoryDataLoader *loader = [DOPMemoryDataLoader sharedDataLoader];
    return [[DOPostStream alloc] initWithUserId:@""
                                     dataLoader:(id)loader];
}



@end
