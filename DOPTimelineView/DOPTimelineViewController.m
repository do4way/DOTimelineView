//
//  BSLTimelineViewController.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/11.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "UIView+AutoLayout.h"
#import "DOPTimelineViewController.h"
#import "DOPost.h"
#import "DOPostStream.h"
#import "DOPMemoryDataLoader.h"
#import "DOPImageLoader.h"
#import "DOPTimelineHeaderCell.h"
#import "DOPTimelinePhotoCell.h"
#import "DOPTimelinePhotoGridCell.h"
#import "DOPTimelineCaptionCell.h"
#import "DOPTimelineLikedByCell.h"
#import "DOPTimelineCommentCell.h"
#import "DOPTimelineCommandsCell.h"
#import "DOPTimelineAppearance.h"
#import "DOPTimelineProtocols.h"
#import "DOPTimelinePhotoCellDelegate.h"
#import "DOPFadeInSegueBackward.h"


/** ------------------------------------------
 *    Cell Reuse Identifier
 *  ------------------------------------------*/

static NSString *const DOPTL_HEADER_CELL_REUSE_IDENTIFIER  = @"DOPTL_HEADER_CELL";
static NSString *const DOPTL_PHOTO_CELL_REUSE_IDENTIFIER  = @"DOPTL_PHOTO_CELL";
static NSString *const DOPTL_PHOTOGRID_CELL_REUSE_IDENTIFIER  = @"DOPTL_PHOTOGRID_CELL";
static NSString *const DOPTL_CAPTION_CELL_REUSE_IDENTIFIER  = @"DOPTL_CAPTION_CELL";
static NSString *const DOPTL_LIKEDBY_CELL_REUSE_IDENTIFIER  = @"DOPTL_LIKEDBY_CELL";
static NSString *const DOPTL_COMMENT_CELL_REUSE_IDENTIFIER  = @"DOPTL_COMMENT_CELL";
static NSString *const DOPTL_COMMANDS_CELL_REUSE_IDENTIFIER  = @"DOPTL_COMMANDS_CELL";


@interface DOPTimelineViewController() <DOPostStreamDelegate,DOPTimelinePhotoCellDelegate>

@property (nonatomic, strong) DOPostStream *postStream;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation DOPTimelineViewController

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (void) loadView
{
    [super loadView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = NO;
    self.spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [footerView addSubview:self.spinner];
    [self.tableView setTableFooterView:footerView];
    [self.spinner autoCenterInSuperview];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.spinner startAnimating];
    [self.tableView registerClass:[DOPTimelineHeaderCell class]
           forCellReuseIdentifier:DOPTL_HEADER_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelinePhotoCell class]
           forCellReuseIdentifier:DOPTL_PHOTO_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelinePhotoGridCell class]
           forCellReuseIdentifier:DOPTL_PHOTOGRID_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelineCaptionCell class]
           forCellReuseIdentifier:DOPTL_CAPTION_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelineLikedByCell class]
           forCellReuseIdentifier:DOPTL_LIKEDBY_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelineCommentCell class]
           forCellReuseIdentifier:DOPTL_COMMENT_CELL_REUSE_IDENTIFIER];
    [self.tableView registerClass:[DOPTimelineCommandsCell class]
           forCellReuseIdentifier:DOPTL_COMMANDS_CELL_REUSE_IDENTIFIER];
    self.postStream = [self createPostStream];
    [self.postStream requestMorePosts];
    
}

#pragma mark - table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.postStream count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOPost *post = [self.postStream postAtIndex:indexPath.section];
    DOPTimelineAppearance *appearance = [[DOPTimelineAppearance alloc] initWithDOPost:post];
    return [appearance heightOfPartIndex:indexPath.row];
    
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOPost *post = [self.postStream postAtIndex:indexPath.section];
    
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            
             DOPTimelineHeaderCell *header = [tableView dequeueReusableCellWithIdentifier:DOPTL_HEADER_CELL_REUSE_IDENTIFIER
                                                                  forIndexPath:indexPath];
            [header setHeaderWithAvatarUrl:post.avatarUrl
                                userName:post.userName
                             updateTime:post.timestampAsString];
            cell = header;
            break;
        }
        case 1: {
            
            NSInteger cnt = [post.photos count];
            
            if ( cnt == 1){
                DOPTimelinePhotoCell *photo = [tableView dequeueReusableCellWithIdentifier:DOPTL_PHOTO_CELL_REUSE_IDENTIFIER
                                                                          forIndexPath:indexPath];
                [photo setDelegate:self];
                [photo setPhoto:[post.photos firstObject]];
                cell = photo;
                
            }else if ( cnt > 1) {
               DOPTimelinePhotoGridCell *photos = [tableView dequeueReusableCellWithIdentifier:DOPTL_PHOTOGRID_CELL_REUSE_IDENTIFIER
                                                                                  forIndexPath:indexPath];
                [photos setDelegate:self];
                [photos setPhotos:post.photos];
                cell = photos;
            }
            break;
            
        }
        case 2: {
            
            DOPTimelineCaptionCell *caption = [tableView dequeueReusableCellWithIdentifier:DOPTL_CAPTION_CELL_REUSE_IDENTIFIER
                                                                      forIndexPath:indexPath];
            [caption setCaption: post.caption];
            cell = caption;

            break;
        }
        case 3: {
            DOPTimelineLikedByCell *likedBy = [tableView dequeueReusableCellWithIdentifier:DOPTL_LIKEDBY_CELL_REUSE_IDENTIFIER
                                                                              forIndexPath:indexPath];

            [likedBy setLikedBy:post.likedBy];
            cell = likedBy;
            break;
        }
            
        case 4: {
            DOPTimelineCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:DOPTL_COMMENT_CELL_REUSE_IDENTIFIER
                                                                              forIndexPath:indexPath];
            if ([post.comments count] > 0) {
                [commentCell setComment:[post.comments firstObject]];
            }
            cell = commentCell;
            
            break;
        }
            
        case 5: {
            
            DOPTimelineCommandsCell *commandsCell = [tableView dequeueReusableCellWithIdentifier:DOPTL_COMMANDS_CELL_REUSE_IDENTIFIER
                                                                                    forIndexPath:indexPath];
            [commandsCell setLikedByNum:post.numLikedBy commentedNum:post.numCommentedBy];
            cell = commandsCell;
            break;
        }
        
        default:
            break;
    }
    
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
    [self.spinner startAnimating];
    [self.postStream requestMorePosts];
}



#pragma mark - post stream delegate
- (void) didPostStreamLoaded
{
    [self.spinner stopAnimating];
    [self.tableView reloadData];
    [self.tableView setNeedsUpdateConstraints];
    [self.tableView updateConstraintsIfNeeded];
    
}

- (void) didPhotosTapped:(UIGestureRecognizer *)gesture
               photoUrls:(NSArray *)photoUrls
                   tapAt:(NSInteger)idx
{
    if ([self.delegate respondsToSelector:@selector(onPhotosTapped:photoUrls:startAt:)]){
        [self.delegate onPhotosTapped:gesture photoUrls:photoUrls startAt:idx];
    }
    
    [self performSegueWithIdentifier:kSEGUE_FORWARDNAME sender:self];
    
}

#pragma mark - Navigation

- (IBAction)segueBackToTimeline:(UIStoryboardSegue *)sender
{
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(readyForSegueForward:sender:)]) {
         [self.delegate readyForSegueForward:segue sender:sender];
    }
}

- (UIStoryboardSegue *) segueForUnwindingToViewController:(UIViewController *)toViewController
                                       fromViewController:(UIViewController *)fromViewController
                                               identifier:(NSString *)identifier
{
    NSLog(@"unwinding %@,%@",fromViewController,toViewController);
    DOPFadeInSegueBackward *segue = [[DOPFadeInSegueBackward alloc] initWithIdentifier:identifier
                                                                                source:fromViewController
                                                                           destination:toViewController];
    return segue;
}

#pragma mark - Privates

- (DOPostStream *) createPostStream
{
    id<DOPostsLoaderDelegate> loader = self.dataLoader;
    if ( !loader )
        loader = (id)[DOPMemoryDataLoader sharedDataLoader];
    DOPostStream *postStream = [[DOPostStream alloc] initWithUserId:@""
                                                         dataLoader:loader];
    [postStream setStreamDelegate:self];
    return postStream;
}


@end
