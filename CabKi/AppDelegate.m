//
//  AppDelegate.m
//  CabKi
//
//  Created by Administrator on 21/11/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize nav;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //intitializing location manager
    [self settingLocationManager];
    
    
    // register remote notification
    [self registerForPushNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    
    
    
    if([def valueForKey:@"user_id"]!=nil)
    {
        
        HomeViewController *  controller=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        
        InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_HVC.topViewController =  controller;
        
        nav=[[UINavigationController alloc]initWithRootViewController:obj_HVC];
        
       
        
    }
    else if([def valueForKey:@"cab_id"]!=nil)
    {
        CabHomeViewController  * controller=[[CabHomeViewController alloc]initWithNibName:@"CabHomeViewController" bundle:nil];
        InitialSlidingViewController *obj_HVC=[[InitialSlidingViewController alloc]initWithNibName:@"InitialSlidingViewController" bundle:nil];
        
        obj_HVC.topViewController =  controller;
        nav=[[UINavigationController alloc]initWithRootViewController:obj_HVC];
        
    }

    else{
        ViewController * controller=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        nav=[[UINavigationController alloc]initWithRootViewController:controller];
    
    }
    
    [nav setNavigationBarHidden:YES];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    
    [Foursquare2 setupFoursquareWithClientId:@"5P1OVCFK0CCVCQ5GBBCWRFGUVNX5R4WGKHL2DGJGZ32FDFKT"
                                      secret:@"UPZJO0A0XL44IHCD1KQBMAYGCZ45Z03BORJZZJXELPWHPSAR"
                                 callbackURL:@"testapp123://foursquare"];
    
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application

{

    
    
}

-(void)settingLocationManager{
    
    locationManager=[[CLLocationManager alloc] init];
    
    locationManager.delegate=self;
    
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    
    locationManager.distanceFilter=10.0f;
    
    [locationManager startUpdatingLocation];
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSString *lat, *lon;
    
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        
        lat=[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        lon=[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
        
    }
    
    
    //call webservice here
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    if ([def valueForKey:@"cab_id"]!=nil) {
      
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setValue:lat forKey:@"latitude"];
    [dict setValue:lon forKey:@"longitude"];
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
       
    [obj ValidateEmailAndPhone:dict :self :UPDATE_CABLOCATION :@"driver_location_update":[[MBProgressHUD alloc] init]];
        
 
        
        
    }
    
}

#pragma nitification methods
- (void) registerForPushNotification

{
    
    NSLog(@"registerForPushNotification");
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
    {
        
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 //__IPHONE_8_0 is not defined in old xcode (==0). Then use 80000
        
        
        
        NSLog(@"registerForPushNotification: For iOS >= 8.0");
        
        
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:
         [UIUserNotificationSettings settingsForTypes:
          
          (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)
          
                                           categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        
        
        
        
        
        
        
#endif
        
    } else {
        
        NSLog(@"registerForPushNotification: For iOS < 8.0");
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        
    }
    
}
//#if  def __IPHONE_8_0

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings

{//register to receive notifications
    [application registerForRemoteNotifications];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:@"0000" forKey:@"devicetoken"];
    
}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler

{
    
    //handle the actions
    
    if ([identifier isEqualToString:@"declineAction"]){
        
    }
    
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:token forKey:@"devicetoken"];

    NSLog(@"token---%@", token);
    
    
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSArray *aps=[userInfo objectForKey:@"aps"];
   NSDictionary *dict=[aps valueForKey:@"notification"];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setValue:dict forKey:@"notification"];
    if([def valueForKey:@"cab_id"]!=nil){
        CustomerRequestViewController *custres=[[CustomerRequestViewController alloc] init];
        [self.nav pushViewController:custres animated:YES];
    }else{
        UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Cabki" message:@"You are not log in you have a request from customer!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
    }
    
    
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //again intitializing location manager
    [self settingLocationManager];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //again intitializing location manager
    [self settingLocationManager];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
