//
//  DOPLoremIpsumGenerator.h
//  DOPTimelineView
//
//  Created by Yongwei Dou on 2014/04/04.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOPLoremIpsumGenerator : NSObject

+ (instancetype) sharedGenerator;

- (NSString *) randomWord;
- (NSString *) words:(NSInteger) count;
- (NSString *) words:(NSInteger) count withSeparator:(NSString *) sep;

@end
