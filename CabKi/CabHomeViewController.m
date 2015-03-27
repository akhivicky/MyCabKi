//
//  HomeViewController.m
//  CabKi
//
//  Created by Administrator on 04/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CabHomeViewController.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "HGMovingAnnotation.h"
#import "HGMovingAnnotationView.h"



@interface CabHomeViewController ()

@end

@implementation CabHomeViewController
@synthesize  mapView,locationManager,headerView,cab_active_unactive_btn,switch_label,menubtn,requestbtn;





#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    switch_label.transform = CGAffineTransformMakeScale(1.0, 0.72);
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSLog(@"Aastha");

    if ([def valueForKey:@"cab_cloud_status"]!=nil) {
        
        if ([[def valueForKey:@"cab_cloud_status"] isEqualToString:@"1"]) {
            [switch_label setOn:YES];
             [self.cab_active_unactive_btn setTitle:@"CLOUD ACTIVE" forState:UIControlStateNormal];
        }
        
    }

    
    geocoder = [[CLGeocoder alloc] init];
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter=1.0f;
    
#ifdef __IPHONE_8_0
    
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];

    unsigned rgbValue = 0;
    

    NSScanner *scanner1 = [NSScanner scannerWithString:@"#393939"];
    [scanner1 setScanLocation:1]; // bypass '#' character
    [scanner1 scanHexInt:&rgbValue];
    
   
    
    headerView.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
   
    

   
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
   
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        
        float spanX = 0.00025;
        float spanY = 0.00025;
        
        lat=newLocation.coordinate.latitude;
        lon=newLocation.coordinate.longitude;
        
        MKCoordinateRegion region;
        region.center.latitude = newLocation.coordinate.latitude;
        region.center.longitude = newLocation.coordinate.longitude;
        
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        [self.mapView setRegion:region animated:YES];

        
    }
    
    
}
- (IBAction)leftMenu:(id)sender {
    
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
   
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        
        
        NSLog(@"In Sliding View1 = %@",self.slidingViewController.underLeftViewController);
        
        
    }
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    //getting that have any booking already
    
    [self getMyBooking];
    
    
}

-(void)getMyBooking{
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
   
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :GETBOOKING_API :@"getmybooking":HUD];
    
    

}


-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    NSMutableArray *obj=[dict valueForKey:@"result"];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
        
        NSArray *data=[obj valueForKey:@"data"];
        NSDictionary *finaldata=[data objectAtIndex:0];
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        [def setObject:finaldata forKey:@"finaldata"];
       
        if ([[finaldata valueForKey:@"privatebookingflag"] isEqualToString:@"1"] || [[finaldata valueForKey:@"privatebookingflag"] isEqualToString:@"2"]) { //1 for private
            
            if ([[finaldata valueForKey:@"privatebookingflag"] isEqualToString:@"1"]){
                CabprivatebookingPage *rcchvc=[[CabprivatebookingPage alloc] initWithNibName:@"CabprivatebookingPage" bundle:nil];
            
            [self.navigationController pushViewController:rcchvc animated:YES];
            }else{
                PrivateBookingMeterReadingPage *rcchvc=[[PrivateBookingMeterReadingPage alloc] initWithNibName:@"PrivateBookingMeterReadingPage" bundle:nil];
                
                [self.navigationController pushViewController:rcchvc animated:YES];
                
            }
            
        }else{ //2 for customer booking

            RunningCustomerCabHomeViewController *rcchvc=[[RunningCustomerCabHomeViewController alloc] initWithNibName:@"RunningCustomerCabHomeViewController" bundle:nil];
            
            [self.navigationController pushViewController:rcchvc animated:YES];
        }
       
    }
    
}

- (IBAction)pickUpBtn:(id)sender{
    
   
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
    
    [dict setValue:[NSString stringWithFormat:@"%f", lat] forKey:@"pic_lat"];
    [dict setValue:[NSString stringWithFormat:@"%f", lon] forKey:@"pic_lon"];
    [dict setValue:tzName forKey:@"timezone"];
   
    [HUD show:YES];
    
    [geocoder reverseGeocodeLocation: self.locationManager.location completionHandler:
     
     ^(NSArray *placemarks, NSError *error) {
         
         
         
         //Get nearby address
         
         if (error==nil) {
            
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         //String to hold address
         
         address = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
             
              [dict setValue:[def valueForKey:@"cab_id"] forKey:@"pickupaddress"];
             
             
             
             
             
         WebServiceClass *obj=[[WebServiceClass alloc] init];
         
         [obj ValidateEmailAndPhone:dict :self :ADDPRIVATEBOOKING_API :@"addprivatebooking":HUD];
         }else{
             
             
             [HUD hide:YES];
             _AlertView_WithOut_Delegate(@"Cabki", @"Unable to find the current address.", @"Ok", nil);
         }
     }];
    
   
    
    
    
    
}
-(void)PrivateBookingResponseMessage: (NSDictionary *) dict{
    
    [HUD hide:YES];
    NSArray *obj=[dict valueForKey:@"response"];
    NSMutableArray *data=[obj objectAtIndex:0];
    
    if ([[data valueForKey:@"status"] isEqualToString:@"true"]) {
        
        NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
        
        [def setObject:data forKey:@"finaldata"];
        
        NSDate *date=[[NSDate alloc] init];
        
        
        [def setObject:date forKey:@"privatebookinginitialtime"];
        
        CabprivatebookingPage *rcchvc=[[CabprivatebookingPage alloc] initWithNibName:@"CabprivatebookingPage" bundle:nil];
        
        [self.navigationController pushViewController:rcchvc animated:YES];

        
    }else{
        _AlertView_WithOut_Delegate(@"Cabki", @"Unable to start the private job.", @"Ok", nil);
    }
}
- (IBAction)cloudstatusOnOffbtn:(id)sender{
    
    
      NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    UISwitch *switchh=(UISwitch *)sender;
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
    
    
    if ([def valueForKey:@"cab_cloud_status"]!=nil) {
      if (switchh.isOn)
        {
            [def setObject:@"1" forKey:@"cab_cloud_status"];
            [dict setValue:@"1" forKey:@"cloud_status"];
            [self.cab_active_unactive_btn setTitle:@"CLOUD ACTIVE" forState:UIControlStateNormal];
        }else{
            [def setObject:@"0" forKey:@"cab_cloud_status"];
            [dict setValue:@"3" forKey:@"cloud_status"];
        [self.cab_active_unactive_btn setTitle:@"CLOUD INACTIVE" forState:UIControlStateNormal];
        }
        
    }else{
        [def setObject:@"1" forKey:@"cab_cloud_status"];
        [dict setValue:@"1" forKey:@"cloud_status"];
        [self.cab_active_unactive_btn setTitle:@"CLOUD ACTIVE" forState:UIControlStateNormal];
    }
    
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :ActivateInactivateCloudStatus_API :@"update cloud status":HUD];
    
    
    
}

@end
