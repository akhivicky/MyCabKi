//
//  InitialSlidingViewController.m
//  PayVK
//
//  Created by Mahesh Dhakad on 6/30/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    
  [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

@end
