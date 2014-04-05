//
//  BSLPhotoStreamTests.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DOPostStream.h"
#import "DOPMemoryDataLoader.h"

@interface DOPostStreamTests : XCTestCase


@end

@implementation DOPostStreamTests

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

- (void)testInitialization
{
    DOPostStream *postsStream = [self createMemoryLoaderPostStream];
    XCTAssertNotNil(postsStream, @"BSLPhotoStream should be initialized.");
}

- (void)testLoadPhotoFromeMemoryLoader
{
    DOPostStream *postStream = [self createMemoryLoaderPostStream];
    [postStream requestMorePosts];
    XCTAssertTrue([postStream count] == 50, @"Should returned 50th photos from photostream");
    [postStream requestMorePosts];
    XCTAssertTrue([postStream count] == 100, @"Should returned 50th photos from photostream");
    
}

- (DOPostStream *) createMemoryLoaderPostStream
{
    DOPMemoryDataLoader *dataLoader = [DOPMemoryDataLoader sharedDataLoader];
    DOPostStream *photoStream = [[DOPostStream alloc] initWithUserId:@"usr01"
                                                            dataLoader:(id)dataLoader];
    
    return photoStream;
}


@end
