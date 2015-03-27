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
#import <AddressBookUI/AddressBookUI.h>

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,CLLocationManagerDelegate,UISearchDisplayDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    //picker content
    MBProgressHUD *HUD;
    NSArray *month_array;
    NSMutableArray *year_array;
    NSArray *day_array;
    NSInteger month_row, year_row, day_row, hour_row, minute_row,card_row;
    UIPickerView *pickerView;
    UIToolbar *toolBar;
    UIView *darkView;
    CGRect toolbarTargetFrame;
    CGRect datePickerTargetFrame;
    BOOL tableviewflag;
    BOOL timeflag,dateflag,cardflag;
    NSString *selected_date;
    NSString *selected_time;
    NSString *selected_card;
    NSString *request_button;
    
    int mappintcoutn;
    NSTimer *timer;
    NSTimer *locationtimer;
    UITableView *tableview;
    double latitude,longitude;
    double latitude1,longitude1;
    MKPointAnnotation *centerAnnotation;
 
    NSUserDefaults *userdegaultvalue;
    
    int p;
    NSMutableArray *listarray;
    NSMutableArray *_annotationList;
    
    
    int selected;
    
    NSString *add,*selectedaddress;
    int flag;
    NSString *date;
    NSString *lat11;
    NSString *lon11;
    NSString *titlee;
    UIButton *pinbutton;
    NSMutableArray *namearr,*latarr,*longarr,*statusarr;
    BOOL check;
    BOOL check1;
    BOOL check2;
    int checkcout;
    BOOL check3;
    BOOL check4;
    BOOL locationcheck;
    BOOL tablecheck1;
    BOOL tablecheck2;
    NSString *creditcardid;
    NSMutableArray *existingcard, *existingcard_id;
    
    
    UIDatePicker *datePicker;
    BOOL checklocation;
    NSString *mylocationaddress;
    CLLocation *mylocation;
    NSString *searchstrr;
    int foursquarelimit;
    int foursquareradius;
    BOOL keyflag;
    BOOL fistchec;
    BOOL visible;
    NSMutableArray *searchAddressArray;
    NSMutableArray *searchAddressArray1;
    
    NSArray *AddressArr;
    NSArray *NameArr;
    NSArray *PostcodeArr;
    NSArray *venueid;
    NSArray *venutype;
    
    
    NSArray *AddressArr1;
    NSArray *NameArr1;
    NSArray *PostcodeArr1;
    NSArray *venueid1;
    NSArray *venutype1;
    
    NSString *searchstring;
    
    double l2,l3,lll1,lll2;
    BOOL animating;
    int coutercheck;
    BOOL searchFlag;
    NSString *drivernumber;

}

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (nonatomic) BOOL lastValidZoomState;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchDisplayController *searchdisplaycontroller;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *pickupBtnLable;
- (IBAction)cancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *home_splash;

@property (weak, nonatomic) IBOutlet UIImageView *cercular;


@property (retain, nonatomic) IBOutlet UIImageView *timeset;
@property (retain, nonatomic) IBOutlet UIButton *requestbutton;


@property (retain, nonatomic) IBOutlet UIButton *nextimg;

@property (retain, nonatomic) IBOutlet UILabel *timeminutee;
@property (retain, nonatomic) IBOutlet UILabel *timeminutee1;

@property (retain, nonatomic) IBOutlet UITableView *seartable;
@property(nonatomic,retain)IBOutlet UIButton *pinbutton;
@property (strong, nonatomic) NSArray *nearbyVenues;
@property (nonatomic,retain) IBOutlet UITextField *txtSearch;

@property (nonatomic,retain) IBOutlet UILabel *popuptext;
@property (nonatomic,retain) IBOutlet UIImageView *popupbox;
@property (nonatomic,retain) IBOutlet UIImageView *searchbutton;


@property (nonatomic,retain) IBOutlet UIView *bottombackground;
@property (nonatomic,retain) IBOutlet UIView *titilebackground;
@property (nonatomic,retain) IBOutlet UIView *requestbtnbacround;
@property (nonatomic) CLLocationDistance requiredPointAccuracy;
@property (nonatomic) BOOL doesDisplayPointAccuracyIndicators;


@property (strong, nonatomic) IBOutlet UIView *searchingview;
@property (strong, nonatomic) IBOutlet UILabel *searchingtxt;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *driverdistanceBtn;


//driver properties
@property (weak, nonatomic) IBOutlet UIImageView *driverImageView;
@property (weak, nonatomic) IBOutlet UILabel *driverNamelbl;
@property (weak, nonatomic) IBOutlet UIView *driverbottomview;
- (IBAction)driverphonecallBtn:(id)sender;


- (IBAction)pickUpBtn:(id)sender;
- (IBAction)leftMenu:(id)sender;
-(void)ResponseMessage : (NSDictionary *) dict;
@end
