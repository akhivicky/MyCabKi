//
//  CustomerRequestViewController.m
//  CabKi
//
//  Created by admin on 27/01/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "CustomerRequestViewController.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "WebServiceClass.h"

@interface CustomerRequestViewController ()

@end

@implementation CustomerRequestViewController
@synthesize rateView,countdownlable,pickuplable,customerimage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    countdownvalue=11;
    
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
   
    
     self.rateView.notSelectedImage = [UIImage imageNamed:@"bar.png"];
    
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"yellow_bar.png"];
    
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 10;
    self.rateView.delegate = self;
    
    [self.rateView setEditable:false];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownMethod) userInfo:nil repeats:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSDictionary *dict=[def valueForKey:@"notification"];
    
    self.rateView.rating=[[dict valueForKey:@"customer_rating"] intValue];
    UIImage *myImage = nil;
    
    myImage=[UIImage imageNamed:@"default_img.png"];
    
    if (![[dict valueForKey:@"customer_image"] isEqualToString:@""]) {
        
        [customerimage setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"customer_image"]] placeholderImage:myImage];
    }
    
    pickuplable.text=[dict valueForKey:@"pickup_address"];
    booking_id=[dict valueForKey:@"booking_id"];
    

}
-(void)countdownMethod{
    countdownvalue--;
    
    countdownlable.text=[NSString stringWithFormat:@"%d",countdownvalue];
    
    if (countdownvalue==0) {
        [timer invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    
}

- (IBAction)cancelBtn:(id)sender {
    [timer invalidate];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
    [dict setValue:booking_id forKey:@"booking_id"];
    [dict setValue:@"no" forKey:@"status"];
    
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :ACCEPT_API :@"acceptrequest":HUD];
}
- (IBAction)acceptbtn:(id)sender {
    [timer invalidate];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    [dict setValue:[def valueForKey:@"cab_id"] forKey:@"cab_id"];
    [dict setValue:booking_id forKey:@"booking_id"];
    [dict setValue:@"yes" forKey:@"status"];
    
  
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :ACCEPT_API :@"acceptrequest":HUD];
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSMutableArray *obj=[dict valueForKey:@"result"];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
        
       _AlertView_With_Delegate(@"Cabki", [obj valueForKey:@"msg"], @"Ok", nil);
        
    }else{
        
        _AlertView_With_Delegate(@"ERROR", [obj valueForKey:@"msg"], @"Ok", nil);
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
