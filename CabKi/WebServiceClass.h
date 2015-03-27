//
//  WebServiceClass.h
//  CabKi
//
//  Created by Administrator on 24/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignupFirst1.h"
#import "AFNetworking.h"
#import "SignupSecond.h"
#import "SignupThird.h"
#import "SignupFourth.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "ForgetPasswordViewController.h"
#import "CustomerRequestViewController.h"
#import "CabHomeViewController.h"
#import "HomeViewController.h"
#import "CabprivatebookingPage.h"
#import "TripHistoryViewController.h"
#import "TripDetailViewController.h"
@interface WebServiceClass : NSObject
{
  // MBProgressHUD *HUD;
}
-(void)ValidateEmailAndPhone : (NSDictionary *) dict : (id) obj : (NSString *) url : (NSString *) controllerflag : (MBProgressHUD *) HUD ;
@end
