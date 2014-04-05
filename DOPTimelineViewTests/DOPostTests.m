//
//  BSLPhotoTests.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DOPost.h"
#import "DOPhoto.h"


@interface DOPostTests : XCTestCase

@end

@implementation DOPostTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testObjectInitialization
{
    DOPhoto *photo = [[DOPhoto alloc] initWithUrl:@"http://example.com/test"
                                        thumbUrl:@"http://example.com/test.png"];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    [photos addObject:photo];
    DOPost *post = [[DOPost alloc] initWithUserName:@"test user name"
                                          avatarUrl:@"http://example.com/test.png"
                                          timestamp:[NSDate date]
                                             photos: photos
                                            caption:@"test caption"
                                         numLikedBy:nil
                                            likedBy:nil
                                     numCommentedBy:nil
                                           comments:[[NSArray alloc]init]];
    XCTAssertNotNil(post, @"Should initialize a photo instance");
    NSLog(@"Username : %@", post.userName);
    XCTAssertEqual(post.userName, @"test user name");
}

@end
