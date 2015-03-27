//
//  UnderRightViewController.m
//  PayVK
//
//  Created by Mahesh Dhakad on 6/30/14.
//  Copyright (c) 2014 Mahesh Dhakad. All rights reserved.
//

#import "UnderRightViewController.h"

@interface UnderRightViewController()

@property (nonatomic, assign) CGFloat peekLeftAmount;

@end

@implementation UnderRightViewController

@synthesize peekLeftAmount;

@synthesize imgView_Profile,lbl_ProfileName;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.peekLeftAmount = 40.0f;
  [self.slidingViewController setAnchorLeftPeekAmount:self.peekLeftAmount];
  self.slidingViewController.underRightWidthLayout = ECVariableRevealWidth;
    
    

    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *str_UserName=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserName"];
    
    if (str_UserName) {
        self.lbl_ProfileName.text = str_UserName;

    }else{
        self.lbl_ProfileName.text = @"User Name";
    }

}



#pragma mark - Button Action Methods
#pragma mark -


-(IBAction)action_ProfileSetting:(id)sender
{
   
    
}

-(IBAction)action_PayVKCase:(id)sender
{
    
}

-(IBAction)action_OrderHistory:(id)sender
{
    
}

-(IBAction)action_Logout:(id)sender
{
    
    
}



@end
