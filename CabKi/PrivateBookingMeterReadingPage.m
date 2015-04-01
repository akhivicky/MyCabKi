//
//  PrivateBookingMeterReadingPage.m
//  CabKi
//
//  Created by admin on 13/02/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "PrivateBookingMeterReadingPage.h"
#import "NSString+FontAwesome.h"
#import "Constant.h"
#import "WebServiceClass.h"

@interface PrivateBookingMeterReadingPage ()

@end

@implementation PrivateBookingMeterReadingPage
@synthesize iconIdentiferArray,currencyIconLbl;
@synthesize priceField;
- (void)viewDidLoad {
    [super viewDidLoad];
    tmp = [[NSMutableDictionary alloc] init];
    
    tmp[@"fa-eur"]				= @(FAEur);
    
    if (nil == iconIdentiferArray) {
        iconIdentiferArray = [[tmp allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    
    currencyIconLbl.text = [NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:0]]];
    currencyIconLbl.textColor=[UIColor grayColor];
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", [NSString fontAwesomeIconStringForIconIdentifier:[self.iconIdentiferArray objectAtIndex:0]]]];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontAwesomeFamilyName size:22] range:NSMakeRange(0, 1)];

    [currencyIconLbl setAttributedText:attributedString];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSDictionary *dict=[def valueForKey:@"finaldata"];
    self.readingTime.text=[dict valueForKey:@"booking_elapsed_time"];
    self.readingDate.text=[dict valueForKey:@"booking_date"];
    bookingid_str=[dict valueForKey:@"booking_id"];
    
    float spanX = 0.025;
    float spanY = 0.025;
    
  
    MKCoordinateRegion region;
    region.center.latitude = [[dict valueForKey:@"from_lat"] doubleValue];
    region.center.longitude = [[dict valueForKey:@"from_lon"] doubleValue];
    
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
    [self price];
}
-(void)price
{
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
   priceField.inputAccessoryView = keyboardDoneButtonView;

}
- (void)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
-(IBAction)donebtn_action:(id)sender
{
    [HUD show:YES];
    if([priceField.text length]==0)
    {
        _AlertView_WithOut_Delegate(@"ERROR", @"Please enter a price.", @"Ok", nil);
        
        return;
    }else
    {
        WebServiceClass *obj=[[WebServiceClass alloc] init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    NSString *amount_str=self.priceField.text;
    [dict setValue:bookingid_str forKey:@"booking_id"];
    [dict setValue:amount_str forKey:@"amount"];
    [obj ValidateEmailAndPhone:dict :self :ClosePrivateJob :@"PrivateJobClose":HUD];

    [self.navigationController popToRootViewControllerAnimated:YES];
   
    }
}
-(void)PrivatebookingCloseResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSArray *obj=[dict valueForKey:@"response"];
    NSMutableArray *data=[obj objectAtIndex:0];
    
    if ([[data valueForKey:@"status"] isEqualToString:@"true"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
