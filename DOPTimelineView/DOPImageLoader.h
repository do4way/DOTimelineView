//
//  BSLImageLoader.h
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DOPImageLoadCompletion) (UIImage * image, NSError *error);

@interface DOPImageLoader : NSObject

+ (void) loadImageWithUrl:(NSURL *) imageUrl
               completion:(DOPImageLoadCompletion) completion;
+ (void) loadRoundedImageWithUrl:(NSURL *) imageUrl
               completion:(DOPImageLoadCompletion) completion;

@end
