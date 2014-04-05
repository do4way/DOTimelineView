//
//  BSLImageLoader.m
//  LifelogTimeline
//
//  Created by Yongwei Dou on 2014/03/12.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPImageLoader.h"
#import "DOPImageProcessor.h"


@implementation DOPImageLoader

+ (void) loadImageWithUrl:(NSURL *)imageUrl completion:(DOPImageLoadCompletion)completion
{
    
    void (^onComplete)(NSURLResponse *response, NSData *data, NSError *connectionError) =
        ^void (NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (connectionError) {
                NSLog(@"Err:%@",connectionError);
                completion(nil, connectionError);
                return;
            }
            UIImage *image = [[UIImage alloc]initWithData:data];
            completion(image,nil);
        };
    
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:onComplete];
    
}

+ (void) loadRoundedImageWithUrl:(NSURL *)imageUrl completion:(DOPImageLoadCompletion)completion
{
    [self loadImageWithUrl:imageUrl
                completion:^(UIImage *image, NSError *error) {
                    if (error) {
                        completion(nil,error);
                        return;
                    }
                    __block UIImage *roundedImage = image;
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        roundedImage = [DOPImageProcessor roundImage:(UIImage*)roundedImage];
                        dispatch_async(dispatch_get_main_queue(),^{
                            completion(roundedImage,nil);
                        });
                    });
                }];
}
@end
