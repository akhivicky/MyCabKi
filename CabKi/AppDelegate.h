//
//  AppDelegate.h
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MBProgressHUD.h"
#import "CabHomeViewController.h"
#import "HomeViewController.h"
#import "CustomerRequestViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,CLLocationManagerDelegate, MBProgressHUDDelegate>
{
    NSString *user_type;
     CLLocationManager *locationManager;
    UIBackgroundTaskIdentifier bgTask;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)  UINavigationController *nav;


-(void)settingLocationManager;

@end

