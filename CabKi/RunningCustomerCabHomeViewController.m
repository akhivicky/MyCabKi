//

//  HomeViewController.m

//  CabKi

//

//  Created by Administrator on 04/12/14.

//  Copyright (c) 2014 Administrator. All rights reserved.

//



#import "RunningCustomerCabHomeViewController.h"

#import "AFNetworking.h"

#import "Constant.h"

#import "HGMovingAnnotation.h"

#import "HGMovingAnnotationView.h"







@interface RunningCustomerCabHomeViewController ()



@end



@implementation RunningCustomerCabHomeViewController

@synthesize  mapView,locationManager,headerView,constraintBtn,cab_active_unactive_btn,showAddressLbl,switch_label,countLbl,cancel,menubtn,customerImageview,customernameLbl,bottomview,requestbtn;











#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)



- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    
    
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
    
    
    
    //hiding popup box content
    
    //  [self hidePopupBoxAndContent];
    
    
    
    NSScanner *scanner1 = [NSScanner scannerWithString:@"#393939"];
    
    [scanner1 setScanLocation:1]; // bypass '#' character
    
    [scanner1 scanHexInt:&rgbValue];
    
    
    
    
    
    
    
    headerView.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    
    
    self.view.backgroundColor=[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    
    
    
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *finaldata=[def valueForKey:@"finaldata"];
    
    
    
    
    
    UIImage *myImage = nil;
    
    
    
    myImage=[UIImage imageNamed:@"user_profile_pic_imag2.png"];
    
    NSURL *url=[NSURL URLWithString:[finaldata valueForKey:@"user_image"]];
    
    [customerImageview setImageWithURL:url placeholderImage:myImage];
    
    customernameLbl.text=[finaldata valueForKey:@"user_name"];
    
    customerPhoneNumber=[finaldata valueForKey:@"user_contact"];
    
    showAddressLbl.text=[finaldata valueForKey:@"from_address"];
    
    //hello
    
    [cab_active_unactive_btn setTitle:@"MAKE YOUR WAY TO PICKUP LOCATION" forState:UIControlStateNormal];
    
    [requestbtn setTitle:@"Arrived at Pickup" forState:UIControlStateNormal];
    
    
    constraintBtn =[NSLayoutConstraint
                    constraintWithItem:cab_active_unactive_btn
                    attribute:NSLayoutAttributeTop
                    relatedBy:NSLayoutRelationEqual
                    toItem:self.view
                    attribute:NSLayoutAttributeTop
                    multiplier:1.0
                    constant:120];
    [self.view addConstraint:constraintBtn];
    
    [self hideViewsSecond];
    
    [self showViewsFirst];
    
    
}

-(void)hideViewsFirst{
    
    
    
    showAddressLbl.hidden=YES;
    
    cancel.hidden=YES;
    
    countLbl.hidden=YES;
    
    cab_active_unactive_btn.hidden=YES;
    
    customerImageview.hidden=YES;
    
    bottomview.hidden=YES;
    
}

-(void)showViewsFirst{
    
    showAddressLbl.hidden=NO;
    
    cancel.hidden=NO;
    
    countLbl.hidden=NO;
    
    
    
}

-(void)hideViewsSecond{
    
    //cab_active_unactive_btn.hidden=YES;
    
    switch_label.hidden=YES;
    
    menubtn.hidden=YES;
    
    
    
}

-(void)showViewsSecond{
    
    cab_active_unactive_btn.hidden=NO;
    
    switch_label.hidden=NO;
    
    menubtn.hidden=NO;
    
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    
    
    
    for(int i=0;i<locations.count;i++){
        
        
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        
        
        
        float spanX = 0.00025;
        
        float spanY = 0.00025;
        
        
        
        MKCoordinateRegion region;
        
        region.center.latitude = newLocation.coordinate.latitude;
        
        region.center.longitude = newLocation.coordinate.longitude;
        
        
        
        region.span.latitudeDelta = spanX;
        
        region.span.longitudeDelta = spanY;
        
        [self.mapView setRegion:region animated:YES];
        
        
        
        
        
    }
    
    
    
    
    
}





- (IBAction)phoneCallbtn:(id)sender {
    
    
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:customerPhoneNumber];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    
    
}



- (IBAction)addDestinationBtnAction:(id)sender {
    
    
    
}





- (IBAction)pickUpBtn:(id)sender{
    
    
    
}







- (IBAction)cancelBtn:(id)sender {
    
}

@end

