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
#import "PrivateBookingMeterReadingPage.h"

@interface CabprivatebookingPage : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIPickerViewDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *HUD;
    NSString *customerPhoneNumber;
    //picker content
    
    
    
    NSArray *AddressArr;
    NSArray *AddressArr1;
    NSString *searchstring;
    NSString *searchstrr;
    NSMutableArray *searchAddressArray;
    NSMutableArray *searchAddressArray1;
 
    
    
    double latitude, longitude;
    NSString *destinationaddress;
    NSString *booking_id;
    int kLeftTextPadding;
    BOOL destinationflag;
    CLGeocoder *geocoder;
}


- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchDisplayController *searchdisplaycontroller;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UITableView *seartable;



@property (nonatomic) BOOL lastValidZoomState;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *cab_active_unactive_btn;
@property (weak, nonatomic) IBOutlet UILabel *showAddressLbl;
@property (weak, nonatomic) IBOutlet UISwitch *switch_label;

@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *menubtn;

@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (nonatomic,retain) IBOutlet UIButton *requestbtn;
@property (nonatomic) CLLocationDistance requiredPointAccuracy;
@property (nonatomic) BOOL doesDisplayPointAccuracyIndicators;
@property (nonatomic) IBOutlet NSLayoutConstraint *constraintBtn;


@property (weak, nonatomic) IBOutlet UIImageView *customerImageview;

@property (weak, nonatomic) IBOutlet UILabel *customernameLbl;


@property (weak, nonatomic) IBOutlet UIButton *adddestinationbtn;

@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

- (IBAction)searchbutton:(id)sender;


-(void)ResponseMessage : (NSDictionary *) dict;
-(void)PrivatebookingCompleteResponseMessage : (NSDictionary *) dict;
-(void)PrivatebookingCancelResponseMessage : (NSDictionary *) dict;
- (IBAction)pickUpBtn:(id)sender;

@end
