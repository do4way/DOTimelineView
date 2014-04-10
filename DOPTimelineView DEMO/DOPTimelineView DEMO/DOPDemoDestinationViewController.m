//
//  DOPDemoDestinationViewController.m
//  DOPTimelineView DEMO
//
//  Created by Yongwei Dou on 2014/04/10.
//  Copyright (c) 2014年 DODOPIPE LIMITED. All rights reserved.
//

#import "DOPDemoDestinationViewController.h"

@interface DOPDemoDestinationViewController ()

@end

@implementation DOPDemoDestinationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"second view loaded");
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:gesture];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onTapped:(UIGestureRecognizer *) gesture
{
    NSLog(@"tapped");
    [self performSegueWithIdentifier:@"DOPTimelineSegueBackward" sender:self];
}

@end
