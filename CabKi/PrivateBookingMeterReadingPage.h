//
//  PrivateBookingMeterReadingPage.h
//  CabKi
//
//  Created by admin on 13/02/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"
@interface PrivateBookingMeterReadingPage : UIViewController<MKMapViewDelegate>
{
    NSMutableDictionary *tmp;
    MBProgressHUD *HUD;
    UIButton *done_btn;
    BOOL tableviewflag;
    NSString *bookingid_str;
}
@property (nonatomic, strong) NSArray *iconIdentiferArray;
@property (nonatomic, strong) NSArray *iconSearchArray;
@property (weak, nonatomic) IBOutlet UILabel *currencyIconLbl;
@property (weak, nonatomic) IBOutlet UILabel *readingTime;
@property (weak, nonatomic) IBOutlet UILabel *readingDate;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,retain) IBOutlet UIButton *done_btn;
-(void)PrivatebookingCloseResponseMessage : (NSDictionary *) dict;
-(IBAction)donebtn_action:(id)sender;

@end
