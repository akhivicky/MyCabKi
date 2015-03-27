//
//  HomeViewController.m
//  CabKi
//
//  Created by Administrator on 04/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "HGMovingAnnotation.h"
#import "HGMovingAnnotationView.h"



@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize searchBar, mapView,locationManager,headerView,searchdisplaycontroller,pinbutton,tableView,menuBtn;


@synthesize popupbox,popuptext,timeminutee1;
@synthesize timeminutee, timeset,nextimg,requestbutton,bottombackground,titilebackground, requestbtnbacround, searchbutton,nearbyVenues, home_splash,driverbottomview,driverdistanceBtn,driverImageView,driverNamelbl;


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    tableviewflag=true;
    self.cancelBtn.hidden=YES;
    
    card_row=0;
      self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    month_array=[[NSArray alloc] initWithObjects:@"January",@"Fabruary",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    year_array=[[NSMutableArray alloc] init];
    
    int p1=1990;
    
    for (int i=0; i<50; i++) {
        [year_array addObject:[NSString stringWithFormat:@"%d",p1]];
        p1+=1;
    }
    
    day_array=[[NSArray alloc] initWithObjects:@"30",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    
    timeflag=false;
    dateflag=false;
    cardflag=false;
    request_button=@"Pick Me Up";
    
    
    
    searchFlag=false;
    mappintcoutn=-1;
    locationcheck=false;
    
    searchBar.layer.borderWidth=0;
    
    self.mapView.delegate = self;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
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
    

    
    [home_splash setBackgroundColor:[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0]];
    
    //first time have to hide the homeSplash
    home_splash.hidden=YES;
    self.cercular.hidden=YES;
   
    
    
    
    // Do any additional setup after loading the view from its nib.
    
    AddressArr=[[NSArray alloc] init];
    AddressArr1=[[NSArray alloc] init];
    searchAddressArray=[[NSMutableArray alloc] init];
    searchAddressArray1=[[NSMutableArray alloc] init];
    
    //calling credit card
    [self getCreditCards];
    
    
    //hiding the views
    [self hidedriverView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //changing layout contraints for bottom table view
    
    self.topConstraint.constant = 154;
    [self.tableView setNeedsUpdateConstraints];
}
-(void)hidedriverView{
    driverImageView.hidden=YES;
    driverbottomview.hidden=YES;
    driverdistanceBtn.hidden=YES;
    self.tableView.hidden=YES;
}
-(void)showdriverView{
    driverImageView.hidden=NO;
    driverbottomview.hidden=NO;
    driverdistanceBtn.hidden=NO;
    
    //hide request view
    menuBtn.hidden=YES;
    bottombackground.hidden=YES;
    requestbutton.hidden=YES;

}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (dateflag) {  //for date picker
      
        if (component==0) {
            return 12;
        }
        else if(component==1){
            return [[day_array objectAtIndex:month_row] intValue];
        }else{
            return  50;
        }
    }
    else if(timeflag){ //for time picker
        
            if (component==1) {
                return 24;
            }
            else{
            return 60;
            }
        
            }
    
    else if(cardflag){
        
        return [existingcard count];
        
    }else{
         return 0;
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (dateflag) {  //for date picker
        return 3;
    }else if(timeflag) { //for time picker
        return 4;
    }
    else if(cardflag){
        return 1;
    }else{
        return 0;
    }
    
}




- (UIView *)pickerView:(UIPickerView *)pickerView1 viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *retval = (id)view;
    
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    
    
   if (dateflag) {  //for date picker
    
       if (component==0) {
           retval.text = [month_array objectAtIndex:row];
       }
       else if(component==1){
        
           NSInteger
           row1=row+1;
           retval.text =[NSString stringWithFormat:@"%ld", (long)row1];
        
       }else{
        retval.text = [year_array objectAtIndex:row];
       }

   }else if(timeflag){ //for time picker
       
       if (component==1 || component==2) {
          
           retval.text = [NSString stringWithFormat:@"%ld", (long)(row)];
           
       }
   }else if(cardflag){
       
       retval.text =[existingcard objectAtIndex:row];
   }
    retval.font = [UIFont systemFontOfSize:16];
    
    [retval setTextAlignment:NSTextAlignmentCenter];
    
    return retval;
}

-(void)viewWillAppear:(BOOL)animated{
    
    mappintcoutn=-2;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        
        
        self.slidingViewController.underLeftViewController  = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];

        
        
        
    }
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    //getcurrent booking
    
    [self getMyBooking];
}
-(void)viewDidAppear:(BOOL)animated{
   
    
}
-(void)getMyBooking{
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    [HUD show:YES];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:[def valueForKey:@"user_id"] forKey:@"user_id"];
    
    
    [HUD show:YES];
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :GETCUSTOMERBOOKING :@"getmybookingcustomer":HUD];
    
    
    
}
-(void)ResponseMessage : (NSDictionary *) dict{
    
    
    
    
    NSMutableArray *obj=[dict valueForKey:@"result"];
    
    if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
   
        NSArray *data=[obj valueForKey:@"data"];
        NSDictionary *finaldata=[data objectAtIndex:0];
        
        
        if (![[finaldata valueForKey:@"cab_id"] isEqualToString:@"0"]) {
            
            //showing driver view
            [self showdriverView];
            
            UIImage *myImage = nil;
            
            myImage=[UIImage imageNamed:@"user_profile_pic_imag2.png"];
            
            NSURL *url=[NSURL URLWithString:[finaldata valueForKey:@"cab_image"]];
            
            [driverImageView setImageWithURL:url placeholderImage:myImage];
            
            driverNamelbl.text=[finaldata valueForKey:@"cab_driver_no_plate"];
            drivernumber=[finaldata valueForKey:@"driver_contact"];
        }
        
    }
    
    [self gettingAddressviaGeocoder:mylocation];
    
  
    
    
}
- (IBAction)driverphonecallBtn:(id)sender {
    
    
    NSString *phoneNumber = [@"tel://" stringByAppendingString:drivernumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self stopSpin];
    [timer invalidate];
    foursquareradius=100000;
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    if (!self.searchdisplaycontroller.isActive) {
        
        [self.searchdisplaycontroller setActive:YES animated:YES];
    }
    
    if (searchString!=nil) {
       
     [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    }
    return YES;
}
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    //When the user taps the Cancel Button, or anywhere aside from the view.
  
    tableviewflag=false;
    [self.searchdisplaycontroller setActive:NO animated:YES];
    
 // self.searchdisplaycontroller.searchBar.text=mylocationaddress;
    
}
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
    tableviewflag=true;
    foursquarelimit=1;
    foursquareradius=50;
    self.tableView.hidden=YES;
    self.searchdisplaycontroller.searchBar.text=@"";
    
    [requestbutton setTitle:request_button forState:UIControlStateNormal];
        //self.searchdisplaycontroller.searchBar.text=mylocationaddress;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{

    searchstrr=searchText;
   
    tablecheck1=false;
    tablecheck2=true;
    
    NSString* result = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    searchstring=result;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self showMap:result];
    });
    
    

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
   
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        
        if (!locationcheck) {
            
            locationcheck=true;
            
            mappintcoutn=0;
            l2=newLocation.coordinate.latitude;
            l3=newLocation.coordinate.longitude;
            
            CLLocation *sslocation=[[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            
            
            mylocation=sslocation;
            foursquarelimit=50;
            foursquareradius=100000;
            
            nearbyVenues=[[NSArray alloc] init];
            [self getDriverList];
            
            
            float spanX = 0.00025;
            float spanY = 0.00025;
            
            MKCoordinateRegion region;
            region.center.latitude = l2;
            region.center.longitude = l3;
            
            region.span.latitudeDelta = spanX;
            region.span.longitudeDelta = spanY;
            [self.mapView setRegion:region animated:YES];
            
        }

        
    }
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    if (!locationcheck) {
        locationcheck=true;
        
    mappintcoutn=0;
    l2=userLocation.coordinate.latitude;
    l3=userLocation.coordinate.longitude;
    
    CLLocation *sslocation=[[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        
        
    mylocation=sslocation;
    foursquarelimit=50;
    foursquareradius=100000;
        
        nearbyVenues=[[NSArray alloc] init];
        [self getDriverList];
        
        
        float spanX = 0.00025;
        float spanY = 0.00025;
        
        MKCoordinateRegion region;
        region.center.latitude = l2;
        region.center.longitude = l3;
        
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        [self.mapView setRegion:region animated:YES];

    }
    
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
    
    BOOL currentZoomStateValid = [self mapIsAtValidZoomScale];
    
    if (self.lastValidZoomState != currentZoomStateValid) {
        self.lastValidZoomState = currentZoomStateValid;
        if (self.doesDisplayPointAccuracyIndicators && self.requiredPointAccuracy > 0) {
            [self updatePointAccuracyIndicators];
        }
        
        
    }
   

    if (mappintcoutn>0) {
        
        
        CLLocation *currentlocation=[[CLLocation alloc] initWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
        
        [self gettingAddressviaGeocoder:currentlocation];
        
    }
    
    mappintcoutn++;

}
- (BOOL)mapIsAtValidZoomScale
{
    
    if (self.requiredPointAccuracy) {
        return [self metersPerViewPoint] <= self.requiredPointAccuracy;
    } else {
        return YES;
    }
}

- (CLLocationDistance)metersPerViewPoint
{
    
    CGRect comparisonRect = CGRectMake(self.mapView.center.x,
                                       self.mapView.center.y,
                                       1,
                                       1);
    
    
    MKCoordinateRegion comparisonRegion = [self.mapView convertRect:comparisonRect toRegionFromView:self.mapView];
    CLLocationCoordinate2D comparisonCoordinate1 = CLLocationCoordinate2DMake(comparisonRegion.center.latitude - comparisonRegion.span.latitudeDelta,
                                                                              comparisonRegion.center.longitude - comparisonRegion.span.longitudeDelta);
    
    CLLocationCoordinate2D comparisonCoordinate2 = CLLocationCoordinate2DMake(comparisonRegion.center.latitude + comparisonRegion.span.latitudeDelta,
                                                                              comparisonRegion.center.longitude + comparisonRegion.span.longitudeDelta);
    CLLocationDistance sizeInMeters = MKMetersBetweenMapPoints(MKMapPointForCoordinate(comparisonCoordinate1),
                                                               MKMapPointForCoordinate(comparisonCoordinate2));
    
    return sizeInMeters;
}
#define INDICATOR_BORDER_WIDTH 5

- (void)updatePointAccuracyIndicators
{
    
    if (self.doesDisplayPointAccuracyIndicators && self.requiredPointAccuracy > 0) {
        if ([self mapIsAtValidZoomScale]) {
            self.mapView.layer.borderColor = [UIColor greenColor].CGColor;
            self.mapView.layer.borderWidth = INDICATOR_BORDER_WIDTH;
        } else {
            self.mapView.layer.borderColor = [UIColor redColor].CGColor;
            self.mapView.layer.borderWidth = INDICATOR_BORDER_WIDTH;
        }
    }
    else
    {
        self.mapView.layer.borderWidth = 0;
    }
    
    
}

- (BOOL) isKeyboardOnScreen
{
    BOOL isKeyboardShown = NO;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if (windows.count > 1) {
        
        NSArray *wSubviews =  [windows[1]  subviews];
        if (wSubviews.count) {
            CGRect keyboardFrame = [wSubviews[0] frame];
            CGRect screenFrame = [windows[1] frame];
            if (keyboardFrame.origin.y+keyboardFrame.size.height == screenFrame.size.height) {
                isKeyboardShown = YES;
            }
        }
    }
    
    return isKeyboardShown;
}

-(void) GetDriverLocation:(double) distance{
    
    
    double duration=(distance/1000)*2; //5minute/km also changing metre distance to km
    
    
    
    int durationn = (int)duration;
    float fractional = fmodf(duration, (float)durationn);
    if(fractional > .5f)
        durationn++;
    
    
    //set it on lable
    int minutes=0;
    int hours=0;
    NSString *vvv;
    if(durationn>60){
        
        hours=durationn/60;
        minutes=durationn-hours*60;
        
        
        vvv=[[NSString alloc] initWithFormat:@"Duration: %d Hour %d Minutes",hours, minutes];
    }
    else{
        if (durationn<=0) {
            vvv=@"1";
        }else{
        vvv=[[NSString alloc] initWithFormat:@"%d",durationn ];
        }
    }
    if ([vvv intValue] >1) {
        timeminutee.text=vvv;
        [requestbutton setTitle:[NSString stringWithFormat:@"Pick Me Up in %@ Minutes", vvv] forState:UIControlStateNormal];
        request_button=[NSString stringWithFormat:@"Pick Me Up in %@ Minutes", vvv];
    }else{
        
        timeminutee.text=@"1";
        
        vvv=@"1";
        request_button=[NSString stringWithFormat:@"Pick Me Up in %@ Minute", vvv];
        [requestbutton setTitle:[NSString stringWithFormat:@"Pick Me Up in %@ Minute", vvv] forState:UIControlStateNormal];
        
    }
   
    
    
}
- (void) startSpin {
    
    if (!animating) {
        animating = YES;
        [self spinWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
    
    
}
- (void) stopSpin {
    animating = NO;
}
- (void) spinWithOptions: (UIViewAnimationOptions) options {
   
    // this spin completes 360 degrees every 2 seconds
    
    
    [UIView animateWithDuration: 0.5f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         self.cercular.transform = CGAffineTransformRotate(self.cercular.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animating) {
                                 // if flag still set, keep spinning with constant speed
                                 [self spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 // one last spin, with deceleration
                                 [self spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}


- (IBAction)pickUpBtn:(id)sender {
    
    self.cancelBtn.hidden=NO;
    
    
        if ([requestbutton.titleLabel.text isEqualToString:@"Confirm Request"]) {
            
            
             home_splash.hidden=NO;
             self.cercular.hidden=NO;
             [self startSpin];
             [self sendRquest];
            
        }else{
        
        tableviewflag=false;
        self.tableView.hidden=NO;
           
            [self setConstriantsForfooterTableView:19];
            
                   
            
        [self updatedatetime];
        
        [requestbutton setTitle:@"Confirm Request" forState:UIControlStateNormal];
        
        [self.tableView reloadData];
        }
        
    
    
}
-(void)setConstriantsForfooterTableView: (int) constvalue{
    self.topConstraint.constant = constvalue;
    [self.tableView setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.8 animations:^{
        [self.tableView layoutIfNeeded];
    }];
}
- (IBAction)leftMenu:(id)sender {
    
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

//table view methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableviewflag) {
       return [AddressArr count];
    }else{
        return 5;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
    if (tableviewflag) {
        return 40;
    }else{
        if (indexPath.row==0) {
            return 9;
        } else if(indexPath.row==4){
            return 9;
        }
        else{
            return 40;
        }

    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        if (!tableviewflag) {
            
    NSString *identifier=@"cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (indexPath.row==1 || indexPath.row==2 || indexPath.row==3) {
        
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewHomeOption" owner:self options:nil];
        
        
        cell=[arr objectAtIndex:0];
        
        if (indexPath.row==1) {
            
            cell.leftValue.text=@"Time";
            cell.rightValue.text=selected_time;
            
        }else if (indexPath.row==2) {
            
            cell.leftValue.text=@"Date";
            cell.rightValue.text=selected_date;
            
        } else if (indexPath.row==3) {
            
            cell.leftValue.text=@"Payment";
            cell.rightValue.text=selected_card;
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            
        }
        
        
        
        
        
        
    }else if(indexPath.row==0 || indexPath.row==4){
        
        NSArray *arr=[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewS1" owner:self options:nil];
        cell=[arr objectAtIndex:0];
        cell.lbl.text=@"";
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
    }
    
            
    return cell;
            
        }else{
            
            
            UITableViewCell *cell;
            
            static NSString *cellIdentifier = @"cell";
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                
            }
            
            if ([AddressArr count]>0) {
                
            
            AddressModel *venue = AddressArr[indexPath.row];
            
                cell.textLabel.text = venue.address;
                    
               
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",venue.type];
                
            }
            
            return cell;
            
 
        }
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!tableviewflag) {
        
        if (indexPath.row==1) {
            
            timeflag=true;
            dateflag=false;
             cardflag=false;
        }else if (indexPath.row==2) {
            
            dateflag=true;
            timeflag=false;
            cardflag=false;
        }
        else if (indexPath.row==3) {
            
            cardflag=true;
            dateflag=false;
            timeflag=false;
        }
        
        [pickerView reloadAllComponents];
        [self setPickerView];

        
    }else{
        
    AddressModel *venue = AddressArr[indexPath.row];
    mylocationaddress=venue.address;
    selected=1;
    
    //accessing actual address using google api
    
    //putting value of latitude and longitude for show map
    latitude1=venue.latitude;
    longitude1=venue.longitude;
    
  
    
    lat11=[[NSString alloc] initWithFormat:@"%f",venue.latitude];
    lon11=[[NSString alloc] initWithFormat:@"%f",venue.longitude];
    
    
    float spanX = 0.00025;
    float spanY = 0.00025;
    
    
    
    MKCoordinateRegion region;
    region.center.latitude = venue.latitude;
    region.center.longitude = venue.longitude;
    
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
        
        mappintcoutn=0;
        
    [self setBarAddress:venue.latitude:venue.longitude:mylocationaddress];
        
    AddressArr=[[NSArray alloc] init];
    
    
  
        
    
    [self.searchdisplaycontroller setActive:NO animated:YES];
    
    self.searchdisplaycontroller.delegate=nil;
    self.searchdisplaycontroller.searchBar.text=mylocationaddress;
    self.searchdisplaycontroller.delegate=self;
    }
  
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getVenues:(NSDictionary *) dict{
    
    NSArray *venues = [dict valueForKeyPath:@"results"];
    searchAddressArray=[[NSMutableArray alloc] init];
    AddressArr=[[NSMutableArray alloc] init];
     [self.searchdisplaycontroller.searchResultsTableView reloadData];
    
    if ([venues count]>0) {
        
        //adding value into global array if not exist
        
        for (int i=0; i<[venues count]; i++) {
          
            int k=0;
            NSMutableArray *venue = [venues objectAtIndex:i];
            
            for (int a=0; a<[searchAddressArray count]; a++) {
                
                AddressModel *adm=[searchAddressArray objectAtIndex:a];
                if ([adm.venue_id isEqualToString: [venue valueForKey:@"place_id"]]) {
                    k=1;
                    break;
                }
                
            }
            if (k==0) {
               
                AddressModel *adm=[[AddressModel alloc]init];
                adm.address=[venue valueForKey:@"formatted_address"];
                adm.venue_id=[venue valueForKey:@"place_id"];
                
                NSMutableArray *geometry=[venue valueForKey:@"geometry"];
                
                NSMutableArray *location=[geometry valueForKey:@"location"];
                
                
                //adm.postal_code=venue.location.postcode;
                adm.distance=[[NSString alloc] initWithFormat:@"%@", [location valueForKey:@"lat"]];
                
                adm.latitude=[[location valueForKey:@"lat"] doubleValue];
                adm.longitude=[[location valueForKey:@"lng"] doubleValue];
                adm.type=@"address";
                
                [searchAddressArray addObject:adm];
                
            }
            AddressArr1=searchAddressArray;
            
            
            
        }
        
        tablecheck1=false;
        tablecheck2=true;
        
        //searching code start here
        
        if ([self isKeyboardOnScreen]) {
            
            AddressArr=AddressArr1;
            [self.searchdisplaycontroller.searchResultsTableView reloadData];
            
            
        }
        
        
        
        
    }
 

}


-(void) showMap:(NSString*)search
{
     float currlat1 = l2;
    float currlon1 = l3;
    
    latitude=currlat1;
    longitude=currlon1;
    
    lat11=[[NSString alloc] initWithFormat:@"%f",latitude];
    lon11=[[NSString alloc] initWithFormat:@"%f",longitude];
    
    
    
    
    NSString *URLString;
    
  
        //another key
        //AIzaSyA2BywOPfEb6N10DH22bp0LZv69HrVwD9o
        //AIzaSyBdc52xIk2YxaDN8bjUbj6cHsgcVqvqxbk
        //http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true
        //https://maps.googleapis.com/maps/api/place/textsearch/json?location=%f,%f&radius=100&query=%@&sensor=true&key=AIzaSyA2BywOPfEb6N10DH22bp0LZv69HrVwD9o
        
        URLString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true",search];
        
    
    
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSError *error = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];

    
    if(error != nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:self
                                              cancelButtonTitle:@"Done"
                                              otherButtonTitles:nil] ;
        
        [alert show];
        
    }
    else
    {
        
        
        [self getVenues:responseDict];
        
        
        
    }
    
}

-(void)gettingAddressviaGeocoder : (CLLocation *) newLocation{
    
     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
       
         
         
         if (error == nil && [placemarks count] > 0)
         {
            CLPlacemark *placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = nil;
             
             strAdd=[[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             
             mylocationaddress=strAdd;
           
             
             lat11=[[NSString alloc] initWithFormat:@"%f",newLocation.coordinate.latitude];
             lon11=[[NSString alloc] initWithFormat:@"%f",newLocation.coordinate.longitude];
             
             
             [self setBarAddress:newLocation.coordinate.latitude: newLocation.coordinate.longitude: mylocationaddress];
             
            
         }else{
             
             [self showMap_another :newLocation.coordinate.latitude: newLocation.coordinate.longitude];
             
         }
         [HUD hide:YES];
    }];
}

-(void) showMap_another : (double) latfinal : (double) longfinal
{
   
    latitude=latfinal;
    longitude=longfinal;
    
    lat11=[[NSString alloc] initWithFormat:@"%f",latfinal];
    lon11=[[NSString alloc] initWithFormat:@"%f",longfinal];
    
    
    
    
    NSString *URLString;
    
   
        
        URLString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latfinal,longfinal];
    
    
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    NSError *error = nil;
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    
    if(error != nil) {
        
       
        
    }
    else
    {
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        

        NSArray *venues = [responseDict valueForKeyPath:@"results"];
        
        if ([venues count]>0) {
            
            
            
            
            
            
           
        for (int i=0; i<1 ; i++) {
            
            NSMutableArray *venue = [venues objectAtIndex:i];
            
           mylocationaddress=[venue valueForKey:@"formatted_address"];
            
            NSMutableArray *geometry=[venue valueForKey:@"geometry"];
            
            NSMutableArray *location=[geometry valueForKey:@"location"];
            
            latfinal=[[location valueForKey:@"lat"] doubleValue];
           longfinal= [[location valueForKey:@"lng"] doubleValue];
            
            //to send into teh server
            lat11=[location valueForKey:@"lat"];
            lon11=[location valueForKey:@"lng"];
            
            
         
            
            
        [self setBarAddress:latfinal:longfinal:mylocationaddress];
            
        }
            
        }else{ //if count is 0
            
            
            [requestbutton setTitle:@"TAXI NOT AVAILABEL" forState:UIControlStateNormal];
            
            
            requestbutton.userInteractionEnabled=NO;
            
        }
        
        
        
    }
    
}
-(void)setBarAddress : (double) latitude2 : (double) longitude2 : (NSString *) mylocationaddress1{
    

    [self.searchdisplaycontroller setActive:NO animated:YES];
    
    self.searchdisplaycontroller.delegate=nil;
    self.searchdisplaycontroller.searchBar.text=mylocationaddress1;
    self.searchdisplaycontroller.delegate=self;
    
    
    float finaldistance=0;
    float finaldistance_another=0;
    
    for (int i=0; i<[latarr count]; i++) {
        
        CLLocation *locA = [[CLLocation alloc] initWithLatitude:[[latarr objectAtIndex:i] doubleValue] longitude:[[longarr objectAtIndex:i] doubleValue]];
        
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
        
        if (i==0) {
            finaldistance = [locA distanceFromLocation:locB];
            finaldistance_another = [locA distanceFromLocation:locB];
        }
        else{
            finaldistance = [locA distanceFromLocation:locB];
        }
        
        
        if (finaldistance<finaldistance_another) {
            finaldistance_another=finaldistance;
        }
    }//for loop end
    
    if(finaldistance_another==0){
        
        if(mappintcoutn>0){
            
            [requestbutton setTitle:@"TAXI NOT AVAILABEL" forState:UIControlStateNormal];
            
        }
        
        requestbutton.userInteractionEnabled=NO;
        
        
    }else{
        
        [self updatedatetime];
        
        requestbutton.userInteractionEnabled=YES;
        
        
            [self GetDriverLocation:finaldistance];

    }
    
}
-(void)updatedatetime{
    
    //updating here the time and date and year
    NSDate *currentDate = [NSDate date];
    
    //increasing time by five minutes
   currentDate= [currentDate dateByAddingTimeInterval:300];
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:currentDate];
    
    // Get necessary date components
    
    month_row= [components month]-1; //gives you month
    day_row=[components day]-1; //gives you day
    NSInteger yearvalue=[components year]; // gives you year
    
    year_row=[year_array indexOfObject:[NSString stringWithFormat:@"%ld", (long)yearvalue]];
    
    selected_date=[NSString stringWithFormat:@"%ld/%ld/%ld", (long)[components day], (long)[components month], (long)yearvalue];
    
    hour_row=[components hour];
    minute_row=[components minute];
    
    
    selected_time=[NSString stringWithFormat:@"%ld:%ld",(long)[components hour],(long)[components minute]];
    
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSDate *datee = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %@", selected_date, selected_time]];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    date = [dateFormat stringFromDate:datee];
    
    
    [self.tableView reloadData];
}


//get nearest driver
-(void)getDriverList{
    
    
    NSString *lat=[[NSString alloc] initWithFormat:@"%f",l2];
    NSString *lon=[[NSString alloc] initWithFormat:@"%f",l3];
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:lat forKey:@"latitude"];
    [dict setValue:lon forKey:@"longitude"];
    
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:GETNEARESTDRIVER]];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html", nil]];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@""
          parameters:dict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 
                 
                 NSDictionary *dictRes =responseObject;
                 
                 NSDictionary *dictArray= [dictRes objectForKey:@"result"];
                 
                
                 
                 
                 if (![dictArray isKindOfClass:[NSNull class]]) {
                     
                     
                     
                     if ([[dictArray objectForKey:@"status"]isEqualToString:SUCCESS_RESPONSE]) {
                         
                         namearr=[[NSMutableArray alloc] init];
                         latarr=[[NSMutableArray alloc] init];
                         longarr=[[NSMutableArray alloc] init];
                         statusarr=[[NSMutableArray alloc] init];
                         
                         NSMutableArray *responsee=[dictArray objectForKey:@"response"];
                         
                         namearr=[responsee valueForKey:@"driver_name"];
                         latarr=[responsee valueForKey:@"latitude"];
                         longarr=[responsee valueForKey:@"longitude"];
                         statusarr=[responsee valueForKey:@"cab_status"];
                         
                         //first initialize array
                         _annotationList = [[NSMutableArray alloc] init];
                         for (int i=0; i<[namearr count]; i++) {
                             
                             
                             check3=true;
                             
                        NSDictionary  *new=[NSDictionary dictionaryWithObjectsAndKeys:[latarr objectAtIndex:i],@"latitude",[longarr objectAtIndex:i],@"longitude",@"my location",@"address",
                                                 nil];
                             
                             [_annotationList addObject:new];
                             
                             
                         }
                       //  [self setAnnotionsWithList:_annotationList];
                         
                         
                     }else if([[dictArray objectForKey:@"status"] isEqualToString:ERROR_RESPONSE]){
                         
                     }
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 
                 
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error in Retrieving "
                    message:[NSString stringWithFormat:@"%@",error]
                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
                 
             }
     ];
    
}

- (void) didLoadPath : (NSNotification*) notification
{

	// initialize our moving object
	HGMapPath *path = (HGMapPath*)[notification object];
	HGMovingAnnotation *movingObject = [[HGMovingAnnotation alloc] initWithMapPath:path];
    
    //the annotation retains its path
	
	// add the annotation to the map
    
	[self.mapView addAnnotation:movingObject];
	
	// zoom the map around the moving object
	MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
	MKCoordinateRegion region = MKCoordinateRegionMake(MKCoordinateForMapPoint(movingObject.currentLocation), span);
	[self.mapView setRegion:region animated:YES];
	
	// start moving the object
	[movingObject start];
}

-(void)setPickerView{
    
    toolbarTargetFrame = CGRectMake(0, self.view.bounds.size.height-176-44, 320, 44);
    datePickerTargetFrame = CGRectMake(0, self.view.bounds.size.height-176, 320, 186);
    
    darkView = [[UIView alloc] initWithFrame:self.view.bounds] ;
    darkView.alpha = 0;
    
    
    darkView.backgroundColor = [UIColor blackColor];
    
    darkView.tag = 9;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PickerCancel)] ;
    
    [darkView addGestureRecognizer:tapGesture];
    [self.view addSubview:darkView];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height+84, 320, 186)] ;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    
    pickerView.tag = 10;
    pickerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:pickerView];
    
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 44)] ;
    
    
    toolBar.tag = 11;
    
    //toolBar.barStyle = UIBarStyleBlackTranslucent;
    toolBar.backgroundColor=[UIColor grayColor];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
    
    
    UIButton *title = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 40)] ;
    
   CGRect frameimg = CGRectMake(0, 0, 60, 40);
    
    
    //done button
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    
    
    [someButton setTitle:@"Done" forState:UIControlStateNormal];
    [someButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [someButton addTarget:self action:@selector(PickerDone)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    
    
    //cancel button
    UIButton *someButton1 = [[UIButton alloc] initWithFrame:frameimg];
    
   
    [someButton1 setTitle:@"Cancel" forState:UIControlStateNormal];
    [someButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [someButton1 addTarget:self action:@selector(PickerCancel)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton1 setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *doneButton1 =[[UIBarButtonItem alloc] initWithCustomView:someButton1];
    
     UIBarButtonItem *doneButton2 =[[UIBarButtonItem alloc] initWithCustomView:title];
    
    
    
    [title setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [someButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    [someButton1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    title.titleLabel.font=[UIFont systemFontOfSize:14];

    
    [toolBar setItems:[NSArray arrayWithObjects: doneButton, spacer, doneButton2,spacer, doneButton1, nil]];
    
    [self.view addSubview:toolBar];
    
    [UIView beginAnimations:@"MoveIn" context:nil];
    toolBar.frame = toolbarTargetFrame;
    pickerView.frame = datePickerTargetFrame;
    darkView.alpha = 0.5;
    [UIView commitAnimations];
    
    if (dateflag) {
        
    [title setTitle:@"Select Pickup Date" forState:UIControlStateNormal];
        
    [pickerView selectRow:month_row inComponent:0 animated:NO];
    [pickerView selectRow:day_row inComponent:1 animated:NO];
    [pickerView selectRow:year_row inComponent:2 animated:NO];
    
    }
    else if (timeflag){
        [title setTitle:@"Select Pickup Time" forState:UIControlStateNormal];
       
        [pickerView selectRow:hour_row inComponent:1 animated:NO];
        [pickerView selectRow:minute_row inComponent:2 animated:NO];
        
    }else{
        [title setTitle:@"Select Card" forState:UIControlStateNormal];
       
        [pickerView selectRow:card_row inComponent:0 animated:NO];
        creditcardid=[existingcard_id objectAtIndex:card_row];
        
    }
    
    
    
}
-(void)PickerDone{
    
    if (dateflag) {
        
        dateflag=false;
        
        NSInteger row1 = [pickerView selectedRowInComponent:0]; //month
        NSInteger row2 = [pickerView selectedRowInComponent:1];//day
        NSInteger row3 = [pickerView selectedRowInComponent:2];//year
        
        month_row=row1;
        day_row=row2;
        year_row=row3;
        
        
        
        selected_date=[NSString stringWithFormat:@"%ld/%ld/%@", (long)(row2+1), (long)(row1+1), [year_array objectAtIndex:row3]];
        
        //checking that if user has selected wrong date
        
     
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSDate *datee = [dateFormat dateFromString:selected_date];
        
        
        if ([datee compare:[NSDate date]] == NSOrderedAscending) {
            
            //if selected time is less than the current time
            [self updatedatetime];
            
        }
        
        
    }else if (timeflag){
        
        timeflag=false;
        
        NSInteger row1 = [pickerView selectedRowInComponent:1]; //hour
        
        NSInteger row2 = [pickerView selectedRowInComponent:2];//minute
        
        selected_time=[NSString stringWithFormat:@"%ld:%ld", (long)row1, (long)row2];
        
        hour_row=row1;
        minute_row=row2;
        
        
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
        
        NSDate *datee = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %ld:%ld", selected_date, (long)hour_row,(long)minute_row]];
        
        
        if ([datee compare:[NSDate date]] == NSOrderedAscending) {
            
            //if selected time is less than the current time
            [self updatedatetime];
            
        }


    }else if (cardflag){
        
        cardflag=false;
        
        NSInteger row1 = [pickerView selectedRowInComponent:0];
        
        card_row=row1;
        
        selected_card=[existingcard objectAtIndex:row1];
        
    }
    
        [self.tableView reloadData];
    
    
    darkView.hidden=YES;
    pickerView.hidden=YES;
    toolBar.hidden=YES;
}
-(void)PickerCancel{
    
    
    
    darkView.hidden=YES;
    pickerView.hidden=YES;
    toolBar.hidden=YES;
}
- (void)changeDate : (UIDatePicker *)sender {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // UIDatePicker *datePicker = sender;
      
        if ([sender.date compare:[NSDate date]] == NSOrderedAscending) {
            NSDate *currentDate = [NSDate date];
            NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:300];
            sender.date = datePlusOneMinute;
        }
        
    });
    
  
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    date=[dateformate stringFromDate:sender.date];
    
    
}
-(void)getCreditCards{
    
    existingcard=[[NSMutableArray alloc] init];
    existingcard_id=[[NSMutableArray alloc] init];
    
    NSUserDefaults *def1=[NSUserDefaults standardUserDefaults];
    
    NSString *userid=[def1 objectForKey:@"user_id"];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    [dict setValue:userid forKey:@"user_id"];
    
    
    
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:EXISTING_CARD]];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html", nil]];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@""
          parameters:dict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 NSDictionary *dictRes =responseObject;
                
                 
                 NSMutableArray *dictArray1= [dictRes objectForKey:@"result"];
                 NSArray *dictArray=[dictArray1 valueForKey:@"data"];
                 
                 
                 if (![dictArray1 isKindOfClass:[NSNull class]]) {
                     
                     if ([[dictArray1 valueForKey:@"status"]isEqualToString:SUCCESS_RESPONSE]) {
                         
                         for (int i=0; i<[dictArray count]; i++) {
                             
                             NSMutableArray *dataa=[dictArray objectAtIndex:i];
                             if(i==0)
                             {
                                 selected_card=[dataa valueForKey:@"card_name"];
                                 creditcardid=[dataa valueForKey:@"card_id"];
                             }
                             
                        [existingcard addObject:[dataa valueForKey:@"card_name"]];
                             
                        [existingcard_id addObject:[dataa valueForKey:@"card_id"]];
                             
                         }
                     }else{
                         
                     }
                 }
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
             }
     ];
}




-(void)dismissDatePicker{
    
}


- (IBAction)cancelButton:(id)sender {
    
    self.cancelBtn.hidden=YES;
    tableviewflag=true;

    
    [self setConstriantsForfooterTableView:154];
    
    
   [requestbutton setTitle:request_button forState:UIControlStateNormal];
    
}
-(void) sendRquest{
   
    //spin the address popup left image
    //getting time zone
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    
    
    //dismiss confirm request
    tableviewflag=true;
    self.tableView.hidden=YES;
    
    [requestbutton setTitle:request_button forState:UIControlStateNormal];

    
    NSUserDefaults *def1=[NSUserDefaults standardUserDefaults];
    
    NSString *userid=[def1 objectForKey:@"user_id"];
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    
    
    [dict setValue:userid forKey:@"userid"];
    [dict setValue:lat11 forKey:@"pic_lat"];
    [dict setValue:lon11 forKey:@"pic_lon"];
    [dict setValue:creditcardid forKey:@"card_id"];
    [dict setValue:mylocationaddress forKey:@"pickupaddress"];
    [dict setValue:date forKey:@"bookingdate"];
    //[dict setValue:@"Asia/Kolkata" forKey:@"timezone"];
    [dict setValue:tzName forKey:@"timezone"];
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:SAVE_REQUEST]];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html", nil]];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [client postPath:@""
          parameters:dict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 self.cancelBtn.hidden=YES;
                 NSDictionary *dictRes =responseObject;
                 NSArray *dictArray= [dictRes objectForKey:@"response"];
                 NSDictionary *dictResponse=[dictArray objectAtIndex:0];
                 
                 if (![dictResponse isKindOfClass:[NSNull class]]) {
                     
                     
                     home_splash.hidden=YES;
                     self.cercular.hidden=YES;
                     //spin the address popup left image
                     [self stopSpin];
                     

                     NSString *titile;
                     
        if ([[dictResponse objectForKey:@"status"]isEqualToString:SUCCESS_RESPONSE]) {
            
            //showing driver view
            [self showdriverView];
            
            if ([[dictResponse valueForKey:@"flag"] isEqualToString:@"1"]) {
               
            UIImage *myImage = nil;
            
            myImage=[UIImage imageNamed:@"user_profile_pic_imag2.png"];
            
            NSURL *url=[NSURL URLWithString:[dictResponse valueForKey:@"driver_profile_image"]];
            
            [driverImageView setImageWithURL:url placeholderImage:myImage];
            
            driverNamelbl.text=[dictResponse valueForKey:@"driver_number_plat"];
            drivernumber=[dictResponse valueForKey:@"driver_contact_number"];
                
                return;
            
            }else{
                
                titile=@"Your driver has been booked and will pick you up at your requested time.";
            }
            
        }else{
                         
        titile=[dictResponse objectForKey:@"msg"];
                         
                         
                         
            }
                     
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:titile
                                                                  message:nil
                                        delegate:self
                                                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [av show];

                     
                     
                 }
             }
     
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 
                 self.cancelBtn.hidden=YES;
                 home_splash.hidden=YES;
                 self.cercular.hidden=YES;
                 //spin the address popup left image
                 [self stopSpin];
                 

                 
                 
                 UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Internet Access Error"
                                                              message:[NSString stringWithFormat:@"%@",error]
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [av show];
                 
             }
     ];
    
    
    
    
}

@end
