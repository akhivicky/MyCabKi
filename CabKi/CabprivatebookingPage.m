//
//  HomeViewController.m
//  CabKi
//
//  Created by Administrator on 04/12/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "CabprivatebookingPage.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "HGMovingAnnotation.h"
#import "HGMovingAnnotationView.h"



@interface CabprivatebookingPage ()

@end

@implementation CabprivatebookingPage
@synthesize  mapView,locationManager,headerView,constraintBtn,cab_active_unactive_btn,showAddressLbl,switch_label,countLbl,cancel,menubtn,customerImageview,customernameLbl,bottomview,requestbtn,searchdisplaycontroller,searchBar, seartable;





#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
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
    
 
   
    showAddressLbl.hidden=YES;

   
    AddressArr=[[NSArray alloc] init];
    AddressArr1=[[NSArray alloc] init];
    searchAddressArray=[[NSMutableArray alloc] init];
    searchAddressArray1=[[NSMutableArray alloc] init];
    
     NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
   NSDictionary *finaldata=[def valueForKey:@"finaldata"];
    booking_id=[finaldata valueForKey:@"booking_id"];
    int constraintvalue=0;
    
    if([[finaldata valueForKey:@"destinationflag"] isEqualToString:@"1"]){
        
         destinationflag=true;
        [self.btnSearch setTitle:@"Change Destination" forState:UIControlStateNormal];
        showAddressLbl.hidden=NO;
        showAddressLbl.text=[finaldata valueForKey:@"destination_address"];
        
        constraintvalue=145;
        
    }else{
        [self.btnSearch setTitle:@"Add Destination" forState:UIControlStateNormal];
         destinationflag=false;
        constraintvalue=95;
        
    }
 
    constraintBtn =[NSLayoutConstraint
                    constraintWithItem:cab_active_unactive_btn
                    attribute:NSLayoutAttributeTop
                    relatedBy:NSLayoutRelationEqual
                    toItem:self.view
                    attribute:NSLayoutAttributeTop
                    multiplier:1.0
                    constant:constraintvalue];
    
    [self.view addConstraint:constraintBtn];
    
    
    
    self.btnSearch.layer.cornerRadius = 6;
    self.btnSearch.clipsToBounds = YES;
    self.searchBar.hidden=YES;
    
    
    
    
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"Loading..";
    HUD.square=YES;
    
    
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    for(int i=0;i<locations.count;i++){
        
        CLLocation * newLocation = [locations objectAtIndex:i];
        latitude=newLocation.coordinate.latitude;
        longitude=newLocation.coordinate.longitude;
        
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


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.btnSearch.hidden=NO;
    self.searchBar.hidden=YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.btnSearch.hidden=NO;
    self.searchBar.hidden=YES;
}




- (IBAction)searchbutton:(id)sender {
    
    self.btnSearch.hidden=YES;
    self.searchBar.hidden=NO;
    [self.searchdisplaycontroller setActive: YES animated: YES];
    self.searchdisplaycontroller.searchBar.hidden = NO;
    [self.searchdisplaycontroller.searchBar becomeFirstResponder];
    
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
    
    [self.searchdisplaycontroller setActive:NO animated:YES];
    
    
}
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{

    
    self.searchdisplaycontroller.searchBar.text=@"";
    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    searchstrr=searchText;
    
 
    NSString* result = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    searchstring=result;
    [self showMap:result];
    
    AddressArr=[[NSMutableArray alloc] init];
    //searching with name
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", result];
    
    AddressArr = [AddressArr1 filteredArrayUsingPredicate:resultPredicate];
    
    //search with postal code
    NSPredicate *resultPredicate1 = [NSPredicate predicateWithFormat:@"postal_code contains[c] %@", result];
    NSArray *AddressArr2 = [AddressArr1 filteredArrayUsingPredicate:resultPredicate1];
    NSMutableArray *finaladdressarry=[[NSMutableArray alloc] init];
    
    
    //first add value
    for (int i=0; i<[AddressArr count]; i++) {
        
        AddressModel *mm=AddressArr[i];
        [finaladdressarry addObject:mm];
    }
    
    
    for (int i=0; i<[AddressArr2 count]; i++) {
        
        AddressModel *mm=AddressArr2[i];
        int k=0;
        for (int t=0; t<[AddressArr count]; t++) {
            AddressModel *mmm=AddressArr[t];
            
            if ([mm.venue_id isEqualToString:mmm.venue_id]) {
                k=1;
            }
            
        }
        if (k==0) {
            [finaladdressarry addObject:mm];
        }
        
    }
    
    
    AddressArr=finaladdressarry;
    
    
    if ([AddressArr count]==0) {
        
        //searching with postal code
        
        AddressArr=[[NSMutableArray alloc] init];
        
    }
}

//table view methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return [AddressArr count];
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
        UITableViewCell *cell;
        
        static NSString *cellIdentifier = @"cell";
        
        cell = [tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        if ([AddressArr count]>0) {
            
            
            AddressModel *venue = AddressArr[indexPath.row];
            
            
            if ([venue.address rangeOfString:searchstring].location != NSNotFound) {
                
                if (venue.address) {
                    cell.textLabel.text = venue.address;
                    
                }else{
                    cell.textLabel.text = venue.name;
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",venue.type];
                
            } else if([venue.postal_code rangeOfString:searchstring].location != NSNotFound) {
                
                NSLog(@"22");
                if (venue.postal_code) {
                    cell.textLabel.text = venue.postal_code;
                }else{
                    cell.textLabel.text = venue.name;
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                             venue.type];
            }
            else{
                NSLog(@"33");
                cell.textLabel.text = venue.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",
                                             venue.type];
            }
            
        }
        
        return cell;
        
        
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        AddressModel *venue = AddressArr[indexPath.row];
    
        float spanX = 0.00025;
        float spanY = 0.00025;
        
        
        
        MKCoordinateRegion region;
        region.center.latitude = venue.latitude;
        region.center.longitude = venue.longitude;
        
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        [self.mapView setRegion:region animated:YES];
        
        AddressArr=[[NSArray alloc] init];
        
        
        self.searchdisplaycontroller.searchResultsTableView.hidden=YES;
        
        [self.searchdisplaycontroller setActive:NO animated:YES];
        
        self.searchdisplaycontroller.delegate=nil;
        self.searchdisplaycontroller.searchBar.text=venue.name;
        self.searchdisplaycontroller.delegate=self;
    
        //call webservice to add destination
    
        destinationaddress=venue.address;
    
  
    [HUD show:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:booking_id forKey:@"bookingid"];
    [dict setValue:destinationaddress forKey:@"address"];
    [dict setValue:[NSString stringWithFormat:@"%f", latitude] forKey:@"latitude"];
       [dict setValue:[NSString stringWithFormat:@"%f", longitude] forKey:@"longitude"];
    
   
    
    
   
    
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    
    [obj ValidateEmailAndPhone:dict :self :ADD_DESTINATION :@"adddestinationfromprivate":HUD];
    
    
}


-(void)ResponseMessage : (NSDictionary *) dict{
    [HUD hide:YES];
    
    NSMutableArray *obj=[dict valueForKey:@"response"];
    

        if ([[obj valueForKey:@"status"] isEqualToString:@"true"]) {
            showAddressLbl.hidden=NO;
            showAddressLbl.text=destinationaddress;
            [self.view removeConstraint:constraintBtn];
            
            constraintBtn =[NSLayoutConstraint
                            constraintWithItem:cab_active_unactive_btn
                            attribute:NSLayoutAttributeTop
                            relatedBy:NSLayoutRelationEqual
                            toItem:self.view
                            attribute:NSLayoutAttributeTop
                            multiplier:1.0
                            constant:140];
            
            [self.view addConstraint:constraintBtn];
             [self.btnSearch setTitle:@"Change Destination" forState:UIControlStateNormal];
            destinationflag=true;
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getVenues:(NSDictionary *) dict{
    
    NSArray *venues = [dict valueForKeyPath:@"results"];
    
    
    if ([venues count]>0) {
        
        //adding value into global array if not exist
        
        for (int i=0; i<[venues count]; i++) {
            
            int k=0;
            NSMutableArray *venue = [venues objectAtIndex:i];
            
            for (int a=0; a<[searchAddressArray count]; a++) {
                
                AddressModel *adm=[searchAddressArray objectAtIndex:a];
                if ([adm.venue_id isEqualToString: [venue valueForKey:@"id"]]) {
                    k=1;
                    break;
                }
                
            }
            if (k==0) {
                NSLog(@"i=%d",i);
                AddressModel *adm=[[AddressModel alloc]init];
                adm.name=[venue valueForKey:@"name"];
                adm.address=[venue valueForKey:@"formatted_address"];
                adm.venue_id=[venue valueForKey:@"id"];
                
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
            NSLog(@"address aarrry countakhilesh1=%lu",(unsigned long)[AddressArr1 count]);
            
            
        }
       
        //searching code start here
        
        if ([self isKeyboardOnScreen]) {
            
            
            [self.seartable reloadData];
            //searchingtxt.text=@"Searching.....";
            self.seartable.hidden=NO;
            
            
            AddressArr=[[NSMutableArray alloc] init];
            //searching with name
            NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchstring];
            
            AddressArr = [AddressArr1 filteredArrayUsingPredicate:resultPredicate];
            NSLog(@"address aarrry count1=%lu",(unsigned long)[AddressArr1 count]);
            
            //search with postal code
            NSPredicate *resultPredicate1 = [NSPredicate predicateWithFormat:@"postal_code contains[c] %@", searchstring];
            NSArray *AddressArr2 = [AddressArr1 filteredArrayUsingPredicate:resultPredicate1];
            NSMutableArray *finaladdressarry=[[NSMutableArray alloc] init];
            
            
            //first add value
            for (int i=0; i<[AddressArr count]; i++) {
                
                AddressModel *mm=AddressArr[i];
                [finaladdressarry addObject:mm];
            }
            
            
            
            
            for (int i=0; i<[AddressArr2 count]; i++) {
                
                AddressModel *mm=AddressArr2[i];
                int k=0;
                for (int t=0; t<[AddressArr count]; t++) {
                    AddressModel *mmm=AddressArr[t];
                    
                    if ([mm.venue_id isEqualToString:mmm.venue_id]) {
                        k=1;
                    }
                    
                }
                if (k==0) {
                    [finaladdressarry addObject:mm];
                }
                
            }
            
            
            AddressArr=finaladdressarry;
            
            
            if ([AddressArr count]==0) {
                
                
                
                AddressArr=[[NSMutableArray alloc] init];
                
            }
            
            [self.seartable reloadData];
            
            
        }
        
        
        
        
    }
    
    
}
-(void) showMap:(NSString*)search
{

    
    NSString *URLString;
    
    if (![search length]>0) {
        
        URLString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];
        
    }else{
        
        //another key
        //AIzaSyA2BywOPfEb6N10DH22bp0LZv69HrVwD9o
        //AIzaSyBdc52xIk2YxaDN8bjUbj6cHsgcVqvqxbk
        
        
        URLString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?location=%f,%f&radius=100&query=%@&sensor=true&key=AIzaSyA2BywOPfEb6N10DH22bp0LZv69HrVwD9o",latitude,longitude,search];
        
    }
    
    
    
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
 

- (IBAction)pickUpBtn:(id)sender{
    
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    
    NSDate *date=[def valueForKey:@"privatebookinginitialtime"];
    
    NSString *timedifference=[self timeLeftSinceDate:date];
    
    [def setObject:timedifference forKey:@"privatebookingtimedifference"];
    
    
    [HUD show:YES];
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    
    if (!destinationflag) {
        
        [geocoder reverseGeocodeLocation: self.locationManager.location completionHandler:
         
         ^(NSArray *placemarks, NSError *error) {
             
             
             
             //Get nearby address
             
             if (error==nil) {
                 
                 CLPlacemark *placemark = [placemarks objectAtIndex:0];
                 
                 //String to hold address
                 
               NSString  *address = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 
                 
                 [dict setValue:[NSString stringWithFormat:@"%f", latitude] forKey:@"drop_lat"];
                 [dict setValue:[NSString stringWithFormat:@"%f", longitude] forKey:@"drop_lon"];
                 
                 
                 [dict setValue:address forKey:@"destinationaddress"];
                 
                 [dict setValue:@"1" forKey:@"destinationflag"];
                 
                 [dict setValue:timedifference forKey:@"timeelapsed"];
                 
                 [dict setValue:booking_id forKey:@"booking_id"];
                 
                 
                 WebServiceClass *obj=[[WebServiceClass alloc] init];
                 
                 [obj ValidateEmailAndPhone:dict :self :CompletePrivateBooking :@"completeprivatebooking":HUD];
                 

             }else{
                 
                 
                 [HUD hide:YES];
                 _AlertView_WithOut_Delegate(@"Cabki", @"Unable to find the current address.", @"Ok", nil);
             }
         }];
        
    }else{
        
        [dict setValue:timedifference forKey:@"timeelapsed"];
        [dict setValue:@"0" forKey:@"destinationflag"];
        [dict setValue:booking_id forKey:@"booking_id"];
        
        WebServiceClass *obj=[[WebServiceClass alloc] init];
        
        [obj ValidateEmailAndPhone:dict :self :CompletePrivateBooking :@"completeprivatebooking":HUD];
        

    }
    
    
}

-(void)PrivatebookingCompleteResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSArray *obj=[dict valueForKey:@"response"];
    NSMutableArray *data=[obj objectAtIndex:0];
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    [def setObject:data forKey:@"finaldata"];
    
    
    
    if ([[data valueForKey:@"status"] isEqualToString:@"true"]) {
        
        //show dialog here
        PrivateBookingMeterReadingPage *rcchvc=[[PrivateBookingMeterReadingPage alloc] initWithNibName:@"PrivateBookingMeterReadingPage" bundle:nil];
        
        [self.navigationController pushViewController:rcchvc animated:YES];
        
        
    }
    
}
-(NSString*) timeLeftSinceDate: (NSDate * )dateT
{
    NSString *timeLeft=@"";
    
    NSDate *today10am =[NSDate date];
    
    NSInteger seconds = [today10am timeIntervalSinceDate:dateT];
    
    NSInteger days = (int) (floor(seconds / (3600 * 24)));
    if(days) seconds -= days * 3600 * 24;
    
    NSInteger hours = (int) (floor(seconds / 3600));
    if(hours) seconds -= hours * 3600;
    
    NSInteger minutes = (int) (floor(seconds / 60));
    if(minutes) seconds -= minutes * 60;
    
    
    int p=0;
    
    if(days) {
        p=1;
        timeLeft = [timeLeft stringByAppendingString:[NSString stringWithFormat:@"%ld Days", (long)days]];
    }
    if(hours) {
        if (p==1) {
            timeLeft =[timeLeft stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)hours] ];
        }else{
            timeLeft =[timeLeft stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)hours] ];
        }
        p=2;
    }
    if(minutes) {
        if (p==2) {
        timeLeft =[timeLeft stringByAppendingString:[NSString stringWithFormat: @":%ld", (long)minutes]];
        }else{
            timeLeft =[timeLeft stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)minutes]];
        }
         p=3;
    }
    if(seconds)
    {
        if (p==3) {
            
        timeLeft = [timeLeft stringByAppendingString:[NSString stringWithFormat: @":%ld", (long)seconds]];
            
        }else{
            
         timeLeft = [timeLeft stringByAppendingString:[NSString stringWithFormat: @"%ld", (long)seconds]];
            
        }
    }
    
    return timeLeft;
}



- (IBAction)cancelBtn:(id)sender {
    [HUD show:YES];
    WebServiceClass *obj=[[WebServiceClass alloc] init];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    [dict setValue:booking_id forKey:@"booking_id"];
    
    [obj ValidateEmailAndPhone:dict :self :CancelPrivateBooking :@"CancelPrivateJob":HUD];
    
}
-(void)PrivatebookingCancelResponseMessage : (NSDictionary *) dict{
    
    [HUD hide:YES];
    
    NSArray *obj=[dict valueForKey:@"response"];
    NSMutableArray *data=[obj objectAtIndex:0];
    
    if ([[data valueForKey:@"status"] isEqualToString:@"true"]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
}

@end
