//
//  DOPTimelineCellFooter.m
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/03.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPTimelineCommentLabel.h"
#import "DOPComment.h"

static CGFloat const COMMENT_CELL_PADDING = 2.0f;
static CGFloat const COMMENT_CELL_HEIGHT = 11.0f;

@interface DOPTimelineCommentLabel()

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSMutableArray *commentViews;

@end

@implementation DOPTimelineCommentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.commentViews = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void) setComments:(NSArray *)comments
{
    
    NSInteger commentsCnt = [comments count];
    if (commentsCnt > 5) {
        commentsCnt = 5;
        _comments = [comments subarrayWithRange:NSMakeRange(0,5)];
    }else {
        _comments = comments;
    }
    
    for (DOPComment *comment in self.comments){
        UILabel *name = [UILabel newAutoLayoutView];
        [name setLineBreakMode:NSLineBreakByTruncatingTail];
        [name setNumberOfLines:1];
        [name setTextAlignment:NSTextAlignmentLeft];
        [name setFont: [UIFont boldSystemFontOfSize:14.0f]];
        [name setTextColor:[UIColor colorWithRed:0.0f green:0.21f blue:0.31f alpha:1.0f]];
        name.text = comment.userName;
        UILabel *commentLabel = [UILabel newAutoLayoutView];
        [commentLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [commentLabel setNumberOfLines:1];
        [commentLabel setTextAlignment:NSTextAlignmentLeft];
        [commentLabel setFont: [UIFont systemFontOfSize:14.0f]];
        [commentLabel setTextColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
        commentLabel.text = comment.commentText;
        [self.commentViews addObject:name];
        [self.commentViews addObject:commentLabel];
        [self addSubview:name];
        [self addSubview:commentLabel];
    }
    
}

- (void) updateConstraints
{
    [super updateConstraints];
    NSInteger cnt = [self.comments count] ;
    for (NSInteger i = 0; i<cnt; i++) {
        
        CGFloat top = i * (COMMENT_CELL_PADDING + COMMENT_CELL_HEIGHT);
        UILabel *nameLabel = [self.commentViews objectAtIndex:i*2];
        [nameLabel autoRemoveConstraintsAffectingView];
        
        [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset: top];
        [nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
        UILabel *commentLabel = [self.commentViews objectAtIndex:i*2+1];
        [commentLabel autoRemoveConstraintsAffectingView];
        
        DOPComment *comment =[_comments objectAtIndex:i];
        CGFloat marginLeft = [self textWidth:comment.userName] + 5.0f;
        [commentLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:top ];
        [commentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginLeft ];
        [commentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5.0f ];
        
        
    }
    
}

- (CGFloat) textWidth:(NSString *) text
{
    CGSize sizeMax = (CGSize) {
        .width = CGFLOAT_MAX,
        .height = 15.0f
    };
    NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0]};
    CGSize size = [text boundingRectWithSize:sizeMax
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attr
                                              context:nil].size;
    NSLog(@"=====%@ size: %f,%f", text, size.width,size.height);
    return size.width;
    
}

@end
