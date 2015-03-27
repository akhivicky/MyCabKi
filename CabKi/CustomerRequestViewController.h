//
//  CustomerRequestViewController.h
//  CabKi
//
//  Created by admin on 27/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RateView.h"
#import "MBProgressHUD.h"

@interface CustomerRequestViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,RateViewDelegate, UIAlertViewDelegate>{
    NSTimer *timer;
    int countdownvalue;
    NSString *booking_id;
    MBProgressHUD *HUD;
}
@property (weak, nonatomic) IBOutlet UIImageView *customerimage;
- (IBAction)cancelBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *countdownlable;
@property (weak, nonatomic) IBOutlet UILabel *pickuplable;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet RateView *rateView;

-(void)ResponseMessage : (NSDictionary *) dict;
- (IBAction)acceptbtn:(id)sender;

@end
