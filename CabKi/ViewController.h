//
//  ViewController.h
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupFirst1.h"
#import "SignupFourth.h"
#import "SignupThird.h"
#import "SignupSecond.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "CustomerRequestViewController.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimage;
@property (strong, nonatomic)  UINavigationController *nav;

- (IBAction)CreateAccount:(id)sender;
- (IBAction)login:(id)sender;


@end

