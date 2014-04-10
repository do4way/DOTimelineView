//
//  DOPFadeOutSegueForward.m
//  Pods
//
//  Created by Yongwei Dou on 2014/04/10.
//
//

#import "DOPFadeOutSegueForward.h"
#import "DOPApplicationUtils.h"

@implementation DOPFadeOutSegueForward


- (void) perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    
    CGRect screen = [DOPApplicationUtils currentScreenDependsOrientation];
    UIView* background = [[UIView alloc]initWithFrame:screen];
    
    [background setBackgroundColor:[UIColor blackColor]];
    [sourceViewController.view.superview insertSubview:background belowSubview:sourceViewController.view];
    sourceViewController.view.alpha = 1;
    
    [UIView animateWithDuration:0.6
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sourceViewController.view.alpha = 0;
                         
                     }
                     completion:^(BOOL finished){
                         destinationViewController.view.alpha = 0;
                         [sourceViewController.view.superview addSubview:destinationViewController.view];
                         
                         [UIView animateWithDuration:0.6
                                               delay:0.0
                                             options:UIViewAnimationOptionTransitionFlipFromLeft
                                          animations:^{
                                              destinationViewController.view.alpha = 1;
                                          }
                                          completion:^(BOOL finished) {
                                              sourceViewController.view.alpha = 1.0;
                                              [destinationViewController.view removeFromSuperview]; // remove from temp super view
                                              [background removeFromSuperview]; // remove from temp super view
                                              [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
                                              
                                          } ];
                         
                     }];
    
}
@end
