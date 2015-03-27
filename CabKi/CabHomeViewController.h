//
//  HomeViewController.h
//  CabKi
//
//  Created by Administrator on 04/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
#import "AddressModel.h"
#import "FSVenue.h"
#import "Foursquare2.h"
#import "FSConverter.h"
#import "CustomTableViewCell.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "RunningCustomerCabHomeViewController.h"
#import "CabprivatebookingPage.h"
@interface CabHomeViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIPickerViewDelegate>
{
    MBProgressHUD *HUD;
    NSString *customerPhoneNumber;
    double lat,lon;
    NSString *address;
    //picker content
    CLGeocoder *geocoder;
    
}

@property (nonatomic) BOOL lastValidZoomState;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *cab_active_unactive_btn;

@property (weak, nonatomic) IBOutlet UISwitch *switch_label;

@property (weak, nonatomic) IBOutlet UIButton *menubtn;


@property (nonatomic,retain) IBOutlet UIButton *requestbtn;
@property (nonatomic) CLLocationDistance requiredPointAccuracy;
@property (nonatomic) BOOL doesDisplayPointAccuracyIndicators;



-(void)ResponseMessage : (NSDictionary *) dict;
-(void)PrivateBookingResponseMessage: (NSDictionary *) dict;
- (IBAction)pickUpBtn:(id)sender;
- (IBAction)leftMenu:(id)sender;
- (IBAction)cloudstatusOnOffbtn:(id)sender;


@end
